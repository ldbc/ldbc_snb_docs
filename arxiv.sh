#!/bin/bash

set -eu
set -o pipefail

# Release process
# ---------------
#
# 1. Edit ldbc.cls
#    - Set a stable version number for `\ldbcsnbdocversion`
#    - Under "The specification was built on the source code available at", uncomment the GitHub URL with the tag
#
# 2. Edit README.md
#    - Adjust the version number in the PDF links
#
# 3. Commit and push to GitHub
#
# 4. On GitHub, create a new release with a tag of the same name, following the pattern `v1.2.3`.
#
# 5. Locally, run `./arxiv.sh`
#
# 6. Go to arXiv, log in, replace submission, and upload the new ms.zip file.
#
# 7. Check the output and submit it.
#
# 8. Edit ldbc.cls
#    - Set a snapshot version number for `\ldbcsnbdocversion`
#    - Under "The specification was built on the source code available at", uncomment the GitHub URL pointing to the main branch
#
# 9. Commit and push to GitHub

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
rm -f *.aux *.dvi *.thm *.lof *.log *.lot *.fls *.out *.toc *.blg *.fdb_latexmk *.pdf
rm -f ms.zip
# standalone documents
rm -f standalone-query-cards/*
rm -f workload-*.tex
# binary docs
rm -f *.docx

# create archive
zip -r ms.zip *
