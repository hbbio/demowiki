/**
 * Simple test case for [wiki_css.opa].
 */

search_page()    = html("OPA wiki :: search", Wiki_css.search())
index_page()     = html("OPA wiki :: index", Wiki_css.index())
main(name)       = html("OPA wiki :: {name}", Wiki_css.page(name, true))

static_png(png) = Resource.image({png=png})

urls = parser
     | "/favicon." (.*)-> static_png(@static_source_content("./resources/favicon.png"))
     | "/resources/save.png"     -> static_png(@static_source_content("./resources/save.png"))
     | "/resources/view.png"     -> static_png(@static_source_content("./resources/view.png"))
     | "/resources/index.png"    -> static_png(@static_source_content("./resources/index.png"))
     | "/index"        -> index_page()
     | "/search"       -> search_page()
     | "/" topic=Rule.alphanum_string -> main(topic)
     | "/"             -> main("Home")

server = simple_server(urls)

