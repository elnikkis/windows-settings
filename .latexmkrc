#!/usr/bin/env perl
$latex = 'platex -kanji=utf8 -halt-on-error';
$latex_silent = 'platex -halt-on-error -interaction=batchmode';
$bibtex = 'pbibtex';
$dvipdf = 'dvipdfmx %O -o %D %S';
$makeindex = 'mendex %O -o %D %S';
$max_repeat = 5;
$pdf_mode = 3;
$pdf_previewer = 'start SumatraPDF.exe -reuse-instance';
