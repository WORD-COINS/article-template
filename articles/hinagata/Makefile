MAKE         = make
LATEXMK      = latexmk
LATEXMKFLAG ?=
CP           = cp
RM           = rm

SRC          = main

TARGET       = $(addsuffix .pdf, $(SRC))
CLASS       ?= word

ifeq ($(CLASS),word-lua)
	LATEXMKFLAG += -pdflatex=lualatex -pdf
endif

TEXDEPS      = $(addsuffix .clo, $(CLASS)) $(addsuffix .cls, $(CLASS))
TEXFILES     = ../../texfiles

TEXDTX       = $(addsuffix .dtx, $(TEXFILES)/$(CLASS))
TEXINS       = $(addsuffix .ins, $(TEXFILES)/$(CLASS))

.PHONY: all build lua continue continue-lua cls clean

all:
	$(MAKE) build

build:
	$(MAKE) cls
	$(LATEXMK) $(LATEXMKFLAG) $(SRC)

lua:
	CLASS=word-lua $(MAKE)

continue:
	LATEXMKFLAG=-pvc $(MAKE)

continue-lua:
	LATEXMKFLAG=-pvc CLASS=word-lua $(MAKE)

cls: $(TEXDTX) $(TEXINS)
	$(RM) -rf $(TEXDEPS)
	$(MAKE) $(CLASS) -C $(TEXFILES)
	-$(CP) -r $(foreach ext, .clo .cls, $(TEXFILES)/$(CLASS)$(ext)) ./

clean:
	$(RM) -f $(TEXDEPS) word-lua.cl*
	$(LATEXMK) -C
