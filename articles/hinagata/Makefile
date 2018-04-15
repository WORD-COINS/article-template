MAKE         = make
LATEXMK      = latexmk
LATEXMKFLAG += -halt-on-error
CP           = cp
RM           = rm

SRCS          = main_odd main_even

TARGET       = $(foreach src,$(SRCS), $(addsuffix .pdf, $(src)))

TEXFILES     = ../../texfiles

CLASS        = word
TEXDEPS      = $(foreach deps, $(CLASS).cls, $(TEXFILES)/$(deps))

TEXDTX       = $(addsuffix .dtx, $(TEXFILES)/$(CLASS))
TEXINS       = $(addsuffix .ins, $(TEXFILES)/$(CLASS))

.PHONY: all continue clean

all: $(TARGET)

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
