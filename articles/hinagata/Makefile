MAKE     = make
LATEXMK  = latexmk
CP       = cp
RM       = rm

SRC      = main

TARGET   = $(addsuffix .pdf, $(SRC))
CLASS   ?= word

TEXDEPS  = $(addsuffix .clo, $(CLASS)) $(addsuffix .cls, $(CLASS))
TEXFILES = ../../texfiles

TEXDTX   = $(addsuffix .dtx, $(TEXFILES)/$(CLASS))
TEXINS   = $(addsuffix .ins, $(TEXFILES)/$(CLASS))

.PHONY: all build continue clean lua cls

all:
	$(MAKE) build

lua:
	CLASS=word-lua $(MAKE) cls
	$(LATEXMK) -pdflatex=lualatex -pdf $(SRC)

build:
	$(MAKE) cls
	$(LATEXMK) $(SRC)

continue:
	$(LATEXMK) -pvc $(SRC)

cls: $(TEXDTX) $(TEXINS)
	$(RM) -rf $(TEXDEPS)
	$(MAKE) $(CLASS) -C $(TEXFILES)
	$(CP) -r $(foreach ext, .clo .cls, $(TEXFILES)/$(CLASS)$(ext)) ./

clean:
	$(RM) -f $(TEXDEPS) word-lua.cl*
	$(LATEXMK) -C
