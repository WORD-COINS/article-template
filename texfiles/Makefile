LUALATEX ?= lualatex
LATEXFLAG += -halt-on-error
RM = rm

SRC = word

TARGETS = $(addsuffix .cls, $(SRC))
DOCUMENT = $(addsuffix .pdf, $(SRC))
TEXDTX = $(addsuffix .dtx, $(SRC))
TEXINS = $(addsuffix .ins, $(SRC))

.PHONY: all clean

.DEFAULT_GOAL := all

all: $(TARGETS) $(DOCUMENT)

$(TARGETS): $(TEXINS) $(TEXDTX)
	$(LUALATEX) $(LATEXFLAG) $(TEXINS)

$(DOCUMENT): $(TEXDTX)
	$(LUALATEX) $(LATEXFLAG) $(TEXDTX)

clean:
	$(RM) -f *.aux *.cls *.log *.toc *.dvi *.pdf *.out *.fls
