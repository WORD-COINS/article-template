#!/usr/bin/env perl

$pdflatex = 'lualatex %O -synctex=1 -interaction=nonstopmode -shell-escape %B';
$latex= 'platex %O -synctex=1 -interaction=nonstopmode -kanji=utf8 -shell-escape %B';
$bibtex = 'pbibtex %O -kanji=utf8 %B';
$dvipdf= 'dvipdfmx %O -p jisb5 -d 5 -o %D %S';
$makeindex= 'mendex %O -U -r -c -g -s %B -p any %B';
$pdf_mode = 1;
$pdf_update_method = 3;
