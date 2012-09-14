.PHONY: all clean

OPA=opa --parser classic $(OPAOPT)

SRC=src/chat.opa src/wiki.opa src/main.opa

all: wiki.exe

demo_wiki.exe: $(SRC)
	$(OPA) -o $@ $^

clean:
	rm -rf _build _files _tracks *.exe *.log
