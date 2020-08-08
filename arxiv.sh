#!/bin/bash

# prevent "Couldn't read xref table" errors
cd patterns
for f in *.pdf; do pdftk $f cat output $f.new && mv $f.new $f; done
cd ..

# compile a single bib file
cat bib/*.bib > ms.bib
mv ldbc-snb-specification.tex ms.tex
sed -i 's/\\bibliography{.*}/\\bibliography{ms}/' ms.tex

# Even though the file exists, arXiv still states the following:
# "We do not run bibtex in the auto-TeXing procedure. If you use bibtex, you must compile the .bbl file on your computer then include that in your uploaded source files. See using bibtex.
# The name of the .bbl file must match the name of the main .tex file for the system to process the references correctly."
# If the ms.bbl file is there, just ignore this problem.

# build
./generate-tex.py
latexmk -pdf --interaction=batchmode ms

# cleanup 
rm *.aux *.dvi *.thm *.lof *.log *.lot *.fls *.out *.toc *.blg *.fdb_latexmk *.pdf
rm ms.zip
# standalone documents
rm standalone-query-cards/*
rm workload-*.tex
# binary docs
rm *.docx

# create archive
zip -r ms.zip *
