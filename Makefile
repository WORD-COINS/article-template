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

PANDOC       = pandoc
PANDOC_TEMPLATE = word-template.latex

.PHONY: all continue clean pandoc

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

pandoc:
	$(PANDOC) -f markdown -t latex -o $(SRC).tex --listings -M listings --template $(PANDOC_TEMPLATE) $(SRC).md
