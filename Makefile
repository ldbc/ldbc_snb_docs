DOCUMENT=ldbc-snb-specification.tex

all: $(DOCUMENT)
	latexmk -pdf --interaction=batchmode $(DOCUMENT)
