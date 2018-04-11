MAKE         = make
LATEXMK      = latexmk
LATEXMKFLAG += -halt-on-error
CP           = cp
RM           = rm

SRC          = main

TARGET       = $(addsuffix .pdf, $(SRC))

TEXFILES     = ../../texfiles

CLASS        = word
TEXDEPS      = $(foreach deps, $(CLASS).cls, $(TEXFILES)/$(deps))

TEXDTX       = $(addsuffix .dtx, $(TEXFILES)/$(CLASS))
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

$(TEXDEPS): $(TEXDTX) $(TEXINS)
	LATEXMKFLAG="$(LATEXMKFLAG)" $(MAKE) $(CLASS).cls -C $(TEXFILES)

clean:
	$(MAKE) clean -C $(TEXFILES)
	$(RM) -f $(TEXDEPS)
	$(LATEXMK) -C
