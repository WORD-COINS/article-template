MAKE         = make
LATEXMK      = latexmk
LATEXMKFLAG  = -halt-on-error
CP           = cp
RM           = rm

SRC          = main

TARGET       = $(addsuffix .pdf, $(SRC))

TEXFILES     = ../../texfiles

CLASS        = word
TEXDEPS      = $(foreach deps, $(CLASS).cls, $(TEXFILES)/$(deps))
LATEXMKFLAG +=

TEXDTX       = $(addsuffix .dtx, $(TEXFILES)/$(CLASS))
TEXINS       = $(addsuffix .ins, $(TEXFILES)/$(CLASS))

.PHONY: all continue cls clean

all: $(SRC).pdf
	$(CP) $< main.pdf

%.pdf: %.tex main.tex
	$(MAKE) cls
	$(LATEXMK) $(LATEXMKFLAG) $<

continue:
	LATEXMKFLAG+=-pvc
	$(MAKE)

cls: $(TEXDTX) $(TEXINS)
	$(RM) -rf $(TEXDEPS)
	$(MAKE) $(CLASS).cls -C $(TEXFILES)
	$(CP) -r $(foreach deps, $(TEXDEPS), $(deps)) ./

clean:
	$(RM) -f $(TEXDEPS)
	$(LATEXMK) -C
