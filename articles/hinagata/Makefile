MAKE         = make
LATEXMK      = latexmk
LATEXMKFLAG ?=
LATEXMKFLAG += -halt-on-error
CP           = cp
RM           = rm

SED          = sed
MAKEFILE     = Makefile

SRC          = main

TARGET       = $(addsuffix .pdf, $(SRC))
CLASS        = word

TEXDEPS      = $(addsuffix .clo, $(CLASS)) $(addsuffix .cls, $(CLASS))
TEXFILES     = ../../texfiles

TEXDTX       = $(addsuffix .dtx, $(TEXFILES)/$(CLASS))
TEXINS       = $(addsuffix .ins, $(TEXFILES)/$(CLASS))

.PHONY: all build init-lua continue cls clean

all:
	$(MAKE) build

build:
	$(MAKE) cls
	$(LATEXMK) $(LATEXMKFLAG) $(SRC)

init-lua:
	$(SED) -i '4s/$$/ -pdflatex=lualatex -pdf/' $(MAKEFILE) || $(SED) -i '' '4s/$$/ -pdflatex=lualatex -pdf/' $(MAKEFILE)
	$(SED) -i "14s/$$/-lua/" $(MAKEFILE)                    || $(SED) -i '' "14s/$$/-lua/" $(MAKEFILE)
	$(SED) -i "22s/init-lua //" $(MAKEFILE)                 || $(SED) -i '' "22s/init-lua //" $(MAKEFILE)
	$(SED) -i "44s/.clo //" $(MAKEFILE)                     || $(SED) -i '' "44s/.clo //" $(MAKEFILE)
	$(SED) -i "31,37d" $(MAKEFILE)                          || $(SED) -i '' "31,37d" $(MAKEFILE)

continue:
	LATEXMKFLAG+=-pvc $(MAKE)

cls: $(TEXDTX) $(TEXINS)
	$(RM) -rf $(TEXDEPS)
	$(MAKE) $(CLASS) -C $(TEXFILES)
	$(CP) -r $(foreach ext, .clo .cls, $(TEXFILES)/$(CLASS)$(ext)) ./

clean:
	$(RM) -f $(TEXDEPS)
	$(LATEXMK) -C

