/**
 * Main file of Demo Wiki
 */

import stdlib.components.login
import stdlib.widgets.appframe
import stdlib.widgets.loginbox


//Addition of the part realtiv to appframe
idappframe = "idappframe"
idclogin = "idclogin"


/**
 * {1 Login management}
 */

/** Type of login datas */
type Account.token = option((string,string))

/** Type of a login state */
type Account.credential = {
      name : string
      cred : {admin} / {user} / {anon} //Note => Admin is useless for the moment
 }

/**
 * Db path to user -> pass
 */
db /default_users : stringmap(string)

/** Init databse with a default user */
do if not(Db.exists(@/default_users["demo"])) then /default_users["demo"] <- "demo"

/**
 * Login configuration
 */
login_config : CLogin.config(Account.token,Account.credential,Account.credential) =
  /* A function that generate xhtml that allow to logout. */
  logout_xhtml(name : string, dochange : Account.token -> void) =
    <> {name} - <a onclick={_->dochange(none)}>logout</a> </>
{
  /* Check (username * password) and returns an optionnal login state  */
  authenticate(token,cred) =
    match token with
      | {some=(username,password)} ->
           if Db.exists(@/default_users[username]) && /default_users[username] == password
           then some({name=username cred={user}})
           else some(cred)
      | {none} -> {none}
  loginbox(dochange, cred) =
    box(xhtml) =
      WLoginbox.html(WLoginbox.default_config, idclogin, (s1,s2->dochange(some((s1,s2)))), xhtml)
    match cred.cred with
    | {anon} -> box(none)
    | _ -> box(some(logout_xhtml(cred.name,dochange)))
  /* Perform some dom modification when user login state change */
  on_change(dochange, cred) =
    match cred.cred with
      | {anon} ->
             do WLoginbox.set_logged_out(idclogin,<></>)
             do Dom.transform([ #demo_infos <- "To log in use the username \"demo\" and the password \"demo\"" ])
             WAppFrame.do_set_content(idappframe, public_page(""))
      | {user} ->
             do WLoginbox.set_logged_in(idclogin,logout_xhtml(cred.name,dochange))
             do Dom.transform([ #demo_infos <- "" ])
             WAppFrame.do_set_content(idappframe, private_page("",cred.name))
      //Normally the following case never happens because there is no admin account
      | {admin} -> do WLoginbox.set_logged_in(idclogin,logout_xhtml(cred.name,dochange))
             do Dom.transform([ #demo_infos <- "" ])
             WAppFrame.do_set_content(idappframe, private_page("the page of the administrator",cred.name))
    end
  get_credential = identity
  prelude=none
}

/** The login component of the application. */
@publish server_state = CLogin.make({name="Home" cred={anon}}, login_config)





/**
 * {1 Build the application }
 */

/**
 * {2 Chat part}
 */
 
/** Initialize the chat room */
chat_room = Min_chat_server.init()

/** Broadcast a message to Min_chat when a page is being edited */
broadcast_edit(username: string, page_name: string, action: string): void =
  now_str = Date.to_string(Date.now())
  Min_chat.broadcast(chat_room, username, {system},
      "{action} the page '{page_name}' on {now_str}")

/** Chat configuration */
minchat_config: Min_chat.config = Min_chat.default_config





/**
 * {2 Wiki part }
 */

get_wiki_config(username: string): Wiki_css.config =
  {
    user=some(username)

    on_edit=broadcast_edit(username, _, "has started editing")
    on_save=broadcast_edit(username, _, "saved")
  }

/** XHTML pages */
common_page(wiki_config, page_title: string): xhtml =
  <div id="wiki_css"
      style={css { margin-top: 3px; } }
      onready={_ -> Wiki_css.load_wiki_page(wiki_config, page_title)}>
  </div>





/**
 * {2 Build application with appframe component}
 */

action : WAppFrame.action = {on_search = _ -> void}

appframe_config =
  {WAppFrame.default_config with
    sidebar = none
    searchbox = none
  }

/** The private page contains wiki + chat */
@server private_page(page_title: string, usr_name: string) =
  wiki_config = get_wiki_config(usr_name)
  onready(_) = Dom.transform([#minchat <- Min_chat.start(minchat_config, chat_room, usr_name)])
  <>
    <div id="minchat" style={css { margin-top: 3px; } } onready={onready}></div>
    {common_page(wiki_config, page_title)}
  </>

/** The public page contains only wiki (read only) */
public_page(page_title: string) =
  <><div id="minchat">You are not logged in.<br />Login in if you want to edit the pages and acceed the chat.</div>
    {common_page(Wiki_css.default_config, page_title)}
  </>

main_body(title) : xhtml =
  cred = CLogin.get_credential(server_state)
  econtent : WAppFrame.content= {
    topbar = <h2 style={css {margin: 0px; padding-top: 5px; padding-left: 5px; color: #ffffff; }}>{title}</h2>
    main =
      match cred.cred with
      | {anon} -> public_page(title)
      | {user} -> private_page(title, cred.name)
      | {admin} -> private_page(title, cred.name)
      end
    statusbar =
      match cred.cred with
      | {anon} ->
          <p id="demo_infos" style={ css { text-align: center; color: #fff; padding: 0px; margin: 0px;} }>
            To log in use the username "demo" and the password "demo"
          </p>
      | _ -> <></>
    loginbox  = CLogin.html(server_state)
  }
  WAppFrame.html(appframe_config, idappframe, action, econtent)


/**
 * {2 Server declaration}
 */
/** Static inclusion of some images */
style_parser = @static_resource_directory("style")

/** Server URL parser */
urls = parser
  /* Images */
  | resource={Server.resource_map(style_parser)} .* -> resource
  /* All other pages */
  | "/" title_opt=(.+)? ->
    page_title = (match title_opt with
      | {none} -> "Home"
      | {~some} -> Text.to_string(some))
    do Resource.register_external_css("/style/css.css")
    Resource.page(page_title, main_body(page_title))

server = { Server.simple_server(urls) with server_name = "wiki" }
