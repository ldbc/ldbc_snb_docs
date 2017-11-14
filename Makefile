DOCUMENT=ldbc-snb-specification.tex

all: $(DOCUMENT)
	latexmk -pdf --interaction=batchmode $(DOCUMENT)

query_cards: $(DOCUMENT)
	cd standalone-query-cards && \
	for card in *.tex; do \
		pdflatex $$card ; \
	done

texfot: $(DOCUMENT)
	./texfot.pl latexmk -pdf --interaction=batchmode $(DOCUMENT)

clean:
	rm -f *.aux *.dvi *.thm *.lof *.log *.lot *.fls *.out *.toc *.bbl *.blg
	cd standalone-query-cards && rm -rf *.aux *.dvi *.thm *.lof *.log *.lot *.fls *.out *.toc *.bbl *.blg
