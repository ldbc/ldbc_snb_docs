DOCUMENT=ldbc-snb-specification.tex

all: $(DOCUMENT)
	latexmk -pdf --interaction=batchmode $(DOCUMENT)

generate_query_cards: $(DOCUMENT)
	./generate-tex.py

compile_query_cards: $(DOCUMENT)
	cd standalone-query-cards && \
	for card in *.tex; do \
		../texfot.pl latexmk -pdf --interaction=batchmode $$card ; \
	done

texfot: $(DOCUMENT)
	./texfot.pl latexmk -pdf --interaction=batchmode $(DOCUMENT)

clean:
	rm -f *.aux *.dvi *.thm *.lof *.log *.lot *.fls *.out *.toc *.bbl *.blg *.fdb_latexmk
	cd standalone-query-cards && rm -rf *.aux *.dvi *.thm *.lof *.log *.lot *.fls *.out *.toc *.bbl *.blg *.fdb_latexmk
