DOCUMENT=ldbc-snb-specification.tex

spec: $(DOCUMENT) choke-points/choke-points-queries.tex
	latexmk -pdf --interaction=batchmode $(DOCUMENT)

all: choke-points/choke-points-queries.tex compile_query_cards workloads texfot
	ls *.pdf

choke-points/choke-points-queries.tex: $(wildcard query-specifications/*.yaml)
	./generate-tex.py

compile_query_cards: $(DOCUMENT) choke-points/choke-points-queries.tex
	cd standalone-query-cards && \
	for card in *.tex; do \
		echo $$card ; \
		pdflatex --interaction=batchmode $$card ; \
	done

workloads: $(DOCUMENT)
	for doc in workload-*.tex; do \
		./texfot.pl latexmk -pdf --interaction=batchmode $$doc ; \
	done

texfot: $(DOCUMENT) choke-points/choke-points-queries.tex
	./texfot.pl latexmk -pdf --interaction=batchmode $(DOCUMENT)

clean:
	rm -f *.aux *.dvi *.thm *.lof *.log *.lot *.fls *.out *.toc *.bbl *.blg *.fdb_latexmk
	cd standalone-query-cards && rm -rf *.aux *.dvi *.thm *.lof *.log *.lot *.fls *.out *.toc *.bbl *.blg *.fdb_latexmk
	rm -f query-cards/*
