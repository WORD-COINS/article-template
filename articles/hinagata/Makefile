MAKE         = make
LATEXMK      = latexmk
LATEXMKFLAG ?=
LATEXMKFLAG += -halt-on-error -pdflatex=lualatex -pdf
CP           = cp
RM           = rm

SED          = sed
MAKEFILE     = Makefile

SRC          = main

TARGET       = $(addsuffix .pdf, $(SRC))
CLASS        = word-lua

TEXDEPS      = $(addsuffix .clo, $(CLASS)) $(addsuffix .cls, $(CLASS))
TEXFILES     = ../../texfiles

TEXDTX       = $(addsuffix .dtx, $(TEXFILES)/$(CLASS))
TEXINS       = $(addsuffix .ins, $(TEXFILES)/$(CLASS))

.PHONY: all build continue cls clean

all:
	$(MAKE) build

build:
	$(MAKE) cls
	$(LATEXMK) $(LATEXMKFLAG) $(SRC)

continue:
	LATEXMKFLAG+=-pvc $(MAKE)

cls: $(TEXDTX) $(TEXINS)
	$(RM) -rf $(TEXDEPS)
	$(MAKE) $(CLASS) -C $(TEXFILES)
	$(CP) -r $(foreach ext, .cls, $(TEXFILES)/$(CLASS)$(ext)) ./

clean:
	$(RM) -f $(TEXDEPS)
	$(LATEXMK) -C

