OCAMLBUILD = ocamlbuild

# FILES
ROOT = lib
BUILD_ROOT = _build/$(ROOT)
LIB_NAME =	electron

# FLAGS
FOLDERS =	$(shell find $(ROOT) -type d)
FOLDERS_FLAG = $(foreach folder,$(FOLDERS),-I $(folder))
WARNING_FLAGS = -w @1..3@5..8@10..26@28..31+32..38@39..43@46..49+50
PACKAGES = js_of_ocaml,js_of_ocaml.ppx

# COMMANDS
OCAMLC_COMMAND = -ocamlc 'ocamlc -annot'
OCAMLBUILD_FLAG	= -use-ocamlfind

.PHONY: all
all: clean-copy
		$(OCAMLBUILD) $(OCAMLBUILD_FLAG) $(OCAMLC_COMMAND) $(FOLDERS_FLAG) \
				-pkgs $(PACKAGES) $(LIB_NAME).cma
		cp $(BUILD_ROOT)/$(LIB_NAME).cm* .

.PHONY: clean
clean: clean-copy
		$(OCAMLBUILD) -clean

.PHONY: clean-copy
clean-copy:
		rm -f *.cm*
