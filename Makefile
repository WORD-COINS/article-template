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

TEXDEPS      = $(addsuffix .cls, $(TEXFILES)/$(CLASS))
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
	$(RM) -f $(TEXDEPS)
	$(LATEXMK) -C
