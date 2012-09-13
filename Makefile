.PHONY: all clean

OPA=opa --parser classic $(OPAOPT)

SRC=src/default_css.opa src/min_chat.opa src/wiki_css.opa src/demo_wiki.opa

all: demo_wiki.exe

demo_wiki.exe: $(SRC)
	$(OPA) -o $@ $^

clean:
	rm -rf _build _files _tracks *.exe *.log
