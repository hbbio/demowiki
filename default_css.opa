css = css

/** General style */

html {
  margin: 0;
  padding: 0;
  overflow: hidden;
}

body {
  color: black;
  background-color: #F8F8F8;
  overflow: hidden;
  text-align: left;
  line-height: normal;
  font-weight: normal;
  font-variant: normal;
  font-style: normal;
  font-size: 80%;
  font-family: helvetica, arial, sans-serif;
  margin: 0;
  padding: 0;
  height:100%;
  width:100%;
}

p {
  padding: 5px;
  text-align: justify;
  line-height: 140%;
}

h1 {
  background: url('/img/header2.png') repeat-x 0 0;
  font-family: helvetica, arial, sans-serif;
  border: none;
  width: 100%;
  color:white;
  font-weight: normal;
  font-size: 2.5em;
  padding: 5px 5px 5px 24px;
  margin: 0;
}

h3 {
  font-size: 15px;
  color: black;
  background: none;
  padding: 0;
  margin: 0;
}

h4{
  color: black;
}

#loginapp_header {
  background:transparent url(/img/header.png) repeat-x scroll 0 0;
  border-bottom:1px solid #FFFFFF;
  height:40px;
  padding:5px 0;
  position:fixed;
  width:100%;
  z-index:5;
  overflow: hidden;
}

#loginapp_logo {
  background: url('/img/logo.png') no-repeat 0 0;
  width:148px;
  height:31px;
  display:block;
  float:left;
  margin:5px;
}

#loginapp_content{
  margin-top: 50px;
  float: left;
  width: 100%;
}

input, select, textarea {
  margin:1px;
  padding:1px;
  font-size:12px;
  border: 1px solid #dddddd;
  font-family: helvetica, arial, sans-serif;
}

a {
  cursor: pointer;
  text-decoration:none;
  color:#264d73;
}

a:link, a:visited {
  text-decoration: none;
}

a:hover {
  color:gray;
}

a:active {
  color:gray;
}

a.button, a.clickedbutton, a.notclickedbutton {
  background : url('/img/btn.png') repeat-x 0 0;
  color      : #264d73;
}

a.button, a.clickedbutton, a.notclickedbutton, a.startbutton {
  margin      : 1px;
  padding     : 2px 8px;
  border      : 1px solid #cccccc;
  color       : #4d4d4d;
  font-weight : normal;
}

a.button:hover, a.clickedbutton:hover, a.notclickedbutton:hover,
    a.button:active, a.clickedbutton:active, a.notclickedbutton:active {
  color : #666;
}

/*
.button, .emptyzonebutton {
  -moz-border-radius:7px;
  -webkit-border-radius:7px;
}
*/


/** Login box style */

#loginapp_login_box{
  float: left;
  left: 150px;
  margin: 12px 10px;
  padding: 0 5px;
}

#loginapp_status{
  position: absolute;
  top: 12px;
}


/** Wiki style */

#wiki_css {
  margin-left: 220px;
}

.wiki_text {
  white-space:pre;
}

#wiki_result {
  background: none;
  width: 100%;
  padding: 0;
  margin: 0;
  margin-left: -50px;
  border: none;
  text-align: right;
  text-weight: bold;
}

.wiki_list {
  list-style-type: none;
  padding: 0px;
  margin: 0px;
}

#wiki_preview, #wiki_resultsearch {
  margin-left: 15px;
  padding-left: 10px;
  clear: left;
  display: block;
}

#wiki_area, #wiki_search_area {
  color:black;
  text-align: left;
  position: relative;
  margin-left: 15px;
  margin-right: 15px;
  background-color: #DCE4E7;
  padding: 5px;
  border: 5px solid #F2F2F2;
  font-family: helvetica, arial, sans-serif;
  font-size: 17px;
}

#wiki_content {
  overflow-x: hidden;
  overflow-y: auto;
  position: fixed;
  right: 0px;
  left: 220px;
  top: 105px;
  bottom: 0px;
}

#wiki_save, #wiki_cancel {
  background-position: center left;
  background-repeat: no-repeat;
}

#wiki_save {
  background-image: url('/img/save.png');
}

#wiki_cancel {
  background-image: url('/img/view.png');
}

.wiki_textarea {
  border: 1px solid #D0D0D0;
  height: 500px;
  margin-right: -5px;
  width: 100%;
  font-family: helvetica, arial, sans-serif;
  font-size: 15px;
}

.wiki_input {
  width: 150px;
  margin: 5px;
  padding: 3px;
  background: white;
  border: 1px solid #F2F2F2;
}

#wiki_save, #wiki_cancel, #wiki_view{
   color:black;
   padding: 20px 0px 20px 20px;
}

a.wiki_button {
  display:block;
  color:white;
  text-align:center;
  font-weight:bold;
  font-size: 13px;
  background: url('/img/btn_or.png') no-repeat 0 0;
  width: 87px;
  margin: 5px;
  padding: 5px 0;
  cursor:pointer;
}

.clickable {
  color: black;
  cursor: text;
  text-align: justify;
}


/** Chat style */

#minchat {
  padding: 0px;
  margin: 0px;
  height: 100%;
  float: left;
  width: 220px;
  position: absolute;
}

#minchat_frame {
  border-right: 2px solid lightGrey;
  padding: 5px;
  margin: 1px 0px 0px 0px;
  height: 100%;
}

#minchat_show {
  overflow: auto;
  position: absolute;
  top: 10px;
  left: 10px;
  bottom: 130px;
  width: 200px;
}

#minchat_controls {
  position: absolute;
  right: 10px;
  bottom: 60px;
  padding: 10px;
}

#minchat_entry {
  border: 2px solid gray;
  width: 100%;
  margin: 0px 0px 10px 0px;
  clear: both;
}

.minchat_user {
  background-color: #DCE4E7;
}
