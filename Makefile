SUBDIRS = util,parse,trans,type,codegen,top
LIBS = str
MAIN = top

OCAMLBUILD = ocamlbuild
OCAMLBUILDFLAGS = -use-ocamlfind

DEBUG = $(MAIN).d.byte
NATIVE = $(MAIN).native
PROFILE = $(MAIN).p.native
TOPLEVEL = $(MAIN).top

all: c0c

c0c: bin/c0c
bin/c0c: native
	mkdir -p bin
	install $(NATIVE) $@

debug: $(DEBUG)
native: $(NATIVE)
profile: $(PROFILE)
top: $(TOPLEVEL)

OCAMLOPTS = $(OCAMLBUILDFLAGS) -Is $(SUBDIRS) -libs $(LIBS)
OCAMLBRUN = $(OCAMLBUILD) $(OCAMLOPTS)

%.native: always
	$(OCAMLBRUN) $@
%.d.byte: always
	$(OCAMLBRUN) -cflags -annot $@
top: always
	$(OCAMLBRUN) $@

clean:
	$(OCAMLBUILD) -Is $(SUBDIRS) -clean
	@echo			# $(OCAMLBUILD) -clean needs a newline
	rm -f bin/tangoc
	rmdir bin

always:

.PHONY: c0c debug native top clean always
