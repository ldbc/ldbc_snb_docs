#!/bin/bash

pdflatex snb_doc.tex
bibtex snb_doc
pdflatex snb_doc.tex
