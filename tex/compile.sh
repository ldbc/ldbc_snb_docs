#!/bin/bash

DOCUMENT=snb_doc

pdflatex $DOCUMENT
bibtex $DOCUMENT
pdflatex $DOCUMENT
