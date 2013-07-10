LATEX   = platex --interaction=nonstopmode --kanji=utf8
DVIPDFM = dvipdfmx -p jisb5

all : main.pdf

word.cls : ../../texfiles/word.cls
	cp $< $@

word.clo : ../../texfiles/word.clo
	cp $< $@

default-style.sty : ../../texfiles/default-style.sty
	cp $< $@

main.dvi : main.tex word.cls word.clo default-style.sty
	$(LATEX) $<

main.pdf : main.dvi
	$(DVIPDFM) $<

clean :
	rm -f word.cls word.clo default-style.sty *.dvi *.pdf *.log *.aux
