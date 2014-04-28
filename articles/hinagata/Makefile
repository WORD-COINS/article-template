MAKE     = make
LATEXMK  = latexmk
CP       = cp
RM       = rm

SRC      = main

TARGET   = $(addsuffix .pdf, $(SRC))
CLASS    = word

TEXDEPS  = $(addsuffix .cls, $(CLASS)) $(addsuffix .clo, $(CLASS))
TEXFILES = ../../texfiles

TEXDTX   = $(addsuffix .dtx, $(TEXFILES)/$(CLASS))
TEXINS   = $(addsuffix .ins, $(TEXFILES)/$(CLASS))

.PHONY: all build continue clean

all:
	$(MAKE) build

build:
	$(MAKE) $(TEXDEPS)
	$(LATEXMK) $(SRC)

continue:
	$(LATEXMK) -pvc $(SRC)

$(TEXDEPS): $(TEXDTX) $(TEXINS)
	$(RM) -rf $(TEXDEPS)
	$(MAKE) -C $(TEXFILES)
	$(CP) -r $(foreach ext, .clo .cls, $(TEXFILES)/$(CLASS)$(ext)) ./

clean:
	$(RM) -rf $(TEXDEPS)
	$(LATEXMK) -C
