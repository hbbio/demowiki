/**
 * Simple test case for [min_chat.opa].
 */

styled_page(title, body) =
  Resource.full_page(title, body, <link rel="stylesheet" type="text/css" href="resources/css.css" />, {success}, [])

start_min_chat(room, cnx) =
  id = String.sub(0, 8, Server.user_string_of_connexion(cnx))
  styled_page("Chat", Min_chat.start(room, id))

room = Min_chat_server.init()

urls      = parser .* -> start_min_chat(room, _)
resources = @static_include_directory("resources")

server = Server.make(Resource.add_auto_server(resources, urls))
