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

.PHONY: all continue clean

all: $(SRC).pdf

%.pdf: %.tex $(TEXDEPS)
	$(MAKE) $(TEXDEPS)
	$(LATEXMK) $(LATEXMKFLAG) $<

continue:
	LATEXMKFLAG+=-pvc
	$(MAKE)

$(TEXDEPS): $(TEXDTX) $(TEXINS)
	$(MAKE) $(CLASS).cls -C $(TEXFILES)
	$(CP) -r $(foreach deps, $(TEXDEPS), $(deps)) ./

clean:
	$(RM) -f $(TEXDEPS)
	$(LATEXMK) -C
