OCAMLBUILD = ocamlbuild

# FILES
ROOT = lib
BUILD_ROOT = _build/$(ROOT)
LIB_NAME = electron

# FLAGS
FOLDERS =	$(shell find $(ROOT) -type d)
FOLDERS_FLAG = $(foreach folder,$(FOLDERS),-I $(folder))
WARNING_FLAGS = -w @1..3@5..8@10..26@28..31+32..38@39..43@46..49+50
PACKAGES = js_of_ocaml,js_of_ocaml.ppx

# COMMANDS
OCAMLC_COMMAND = -ocamlc 'ocamlc -annot -g'
OCAMLBUILD_FLAG	= -use-ocamlfind

.PHONY: all
all: clean-copy
		$(OCAMLBUILD) $(OCAMLBUILD_FLAG) $(OCAMLC_COMMAND) $(FOLDERS_FLAG) \
				-pkgs $(PACKAGES) $(LIB_NAME).cma
		cp $(BUILD_ROOT)/$(LIB_NAME).cm* .

# ocamldoc does not support packed modules...
# workaround find there:
# http://stackoverflow.com/questions/17368613/using-ocamldoc-with-packs

.PHONY: doc
doc: clean-copy
		rm -r docs/*
		ocp-pack -mli -o lib/electron/main.ml lib/electron/main/*.ml
		ocp-pack -mli -o lib/electron/renderer.ml lib/electron/renderer/*.ml
		ocp-pack -mli -o lib/electron.ml.tmp lib/electron/*.ml
		echo "(** Implementation of Electron project. *)" > lib/electron.mli
		cat lib/electron.ml.tmpi >> lib/electron.mli; rm lib/electron.ml.tmpi
		mv lib/electron.ml.tmp lib/electron.ml
		$(OCAMLBUILD) $(OCAMLBUILD_FLAG) $(FOLDERS_FLAG) -pkgs $(PACKAGES) \
				$(LIB_NAME).docdir/index.html
		rm $(LIB_NAME).docdir
		mkdir -p docs
		cp -r _build/$(LIB_NAME).docdir/* docs
		rm -f lib/electron/main.{ml,mli} lib/electron/renderer.{ml,mli} \
				lib/electron.{ml,mli}


.PHONY: clean
clean: clean-copy
		$(OCAMLBUILD) -clean

.PHONY: clean-copy
clean-copy:
		rm -f *.cm*
		rm -f lib/electron/main.{ml,mli} lib/electron/renderer.{ml,mli} \
				lib/electron.{ml,mli}
