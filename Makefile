MAKE         = make
LATEXMK      = latexmk
LATEXMKFLAG += -halt-on-error -lualatex

CP           = cp
CD           = cd
RM           = rm

SRC          = main

TARGET       = $(addsuffix .pdf, $(SRC))

TEXFILES     = ./texfiles

CLASS        = word
TEXDEPS      = $(foreach deps, $(CLASS).cls, $(TEXFILES)/$(deps))

TEXINS       = $(addsuffix .ins, $(TEXFILES)/$(CLASS))

.PHONY: all continue clean

all: $(SRC).pdf

%.pdf: %.tex $(CLASS).cls
	$(MAKE) $(TEXDEPS)
	$(LATEXMK) $(LATEXMKFLAG) $<

continue:
	LATEXMKFLAG +=-pvc $(MAKE)

$(CLASS).cls: $(TEXDEPS)
	$(CP) -r $(foreach deps, $(TEXDEPS), $(deps)) ./

clean:
	$(RM) -f $(TEXDEPS)
	$(LATEXMK) -C
