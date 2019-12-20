DOCUMENT=ldbc-snb-specification.tex

spec: $(DOCUMENT)
	latexmk -pdf --interaction=batchmode $(DOCUMENT)

all: generate_query_cards compile_query_cards workloads texfot
	ls *.pdf

generate_query_cards: $(DOCUMENT)
	./generate-tex.py

compile_query_cards: $(DOCUMENT)
	cd standalone-query-cards && \
	for card in *.tex; do \
		../texfot.pl latexmk -pdf --interaction=batchmode $$card ; \
	done

workloads: $(DOCUMENT)
	for doc in workload-*.tex; do \
		./texfot.pl latexmk -pdf --interaction=batchmode $$doc ; \
	done

texfot: $(DOCUMENT)
	./texfot.pl latexmk -pdf --interaction=batchmode $(DOCUMENT)

clean:
	rm -f *.aux *.dvi *.thm *.lof *.log *.lot *.fls *.out *.toc *.bbl *.blg *.fdb_latexmk
	cd standalone-query-cards && rm -rf *.aux *.dvi *.thm *.lof *.log *.lot *.fls *.out *.toc *.bbl *.blg *.fdb_latexmk
	rm query-cards/*
