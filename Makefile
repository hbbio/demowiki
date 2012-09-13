.PHONY: all clean

OPA=opa --parser classic $(OPAOPT)

SRC=default_css.opa min_chat.opa wiki_css.opa demo_wiki.opa

all: demo_wiki.exe

demo_wiki.exe: $(SRC)
	$(OPA) -o $@ $^

clean:
	rm -rf _build _files _tracks *.exe *.log
