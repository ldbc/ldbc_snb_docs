#!/bin/bash

pdflatex sib_spec.tex
bibtex sib_spec 
pdflatex sib_spec.tex
