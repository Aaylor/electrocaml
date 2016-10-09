
MAIN_PATH=../..

.PHONY: all
all:
		ocamlfind ocamlc -I $(MAIN_PATH) $(MAIN_PATH)/electron.cma \
			-package js_of_ocaml -package js_of_ocaml.ppx -linkpkg index.ml \
			-o index.byte
		js_of_ocaml --debug-info --pretty index.byte
		npm start
