![LDBC_LOGO](https://raw.githubusercontent.com/ldbc/ldbc_snb_docs/main/figures/ldbc-logo.png)
# LDBC SNB Documentation

[![Build Status](https://circleci.com/gh/ldbc/ldbc_snb_docs.svg?style=svg)](https://circleci.com/gh/ldbc/ldbc_snb_docs)

[[latest PDF (0.4.0-SNAPSHOT)]](http://ldbcouncil.org/ldbc_snb_docs/ldbc-snb-specification.pdf)
[[stable PDF (0.3.3)]](https://arxiv.org/pdf/2001.02299.pdf)

## Benchmark specification

For a quick overview of LDBC SNB, start with our [presentation](https://docs.google.com/presentation/d/1p-nuHarSOKCldZ9iEz__6_V3sJ5kbGWlzZHusudW_Cc/).

For a guide on how to develop SNB Interactive implementations, please check out the README of the [Interactive implementations repository](https://github.com/ldbc/ldbc_snb_interactive_implementations).

## Compatibility

The two SNB workloads (Interactive/BI) are stored in different repositories:

* Interactive (auditable since v0.3.2):
  * Data generator: https://github.com/ldbc/ldbc_snb_datagen_hadoop
  * Driver: https://github.com/ldbc/ldbc_snb_driver
  * Implementations: https://github.com/ldbc/ldbc_snb_interactive
* BI (WIP, will be release in v0.4.0+):
  * Data generator: https://github.com/ldbc/ldbc_snb_datagen_spark
  * Driver and implementations: https://github.com/ldbc/ldbc_snb_bi

## How to cite LDBC benchmarks

* **Social Network Benchmark:**
  * **Detailed specification:** [The LDBC Social Network Benchmark (version 0.3.3)](https://arxiv.org/pdf/2001.02299.pdf) by the LDBC Social Network Benchmark task force, arXiv/CoRR abs/2001.02299, 2020. [[bib](bib/specification.bib)]
  * **BI workload:** [An early look at the LDBC Social Network Benchmark's Business Intelligence workload](http://ldbcouncil.org/sites/default/files/ldbc-bi-grades.pdf), GRADES-NDA at SIGMOD 2018 by G. Szárnyas et al. [[bib](bib/snb-bi.bib)]
  * **Interactive workload:** [The LDBC Social Network Benchmark: Interactive Workload](https://ir.cwi.nl/pub/23380), SIGMOD 2015 by O. Erling et al. [[bib](bib/snb-interactive.bib)]
* **Related benchmarks:**
  * **LDBC Graphalytics:** [LDBC Graphalytics: A Benchmark for Large-Scale Graph Analysis on Parallel and Distributed Platforms](http://www.vldb.org/pvldb/vol9/p1317-iosup.pdf), VLDB 2016 paper by A. Iosup et al. [[bib](bib/graphalytics.bib)], [The LDBC Graphalytics Benchmark](https://arxiv.org/pdf/2011.15028.pdf), technical report [[bib](bib/graphalytics-specification.bib)]
  * **LDBC Semantic Publishing Benchmark:** [Benchmarking RDF Query Engines: The LDBC Semantic Publishing Benchmark](http://ceur-ws.org/Vol-1700/paper-01.pdf), BLINK at ISWC 2016 by V. Kotsev et al. [[bib](bib/spb.bib)]
  * **LSQB (Labelled Subgraph Query Benchmark):** a [microbenchmark](https://github.com/ldbc/lsqb) focusing on subgraph queries (graph pattern matching) using labelled graphs produced by the LDBC data generator.

## How to build the this document

**This repository contains the LaTeX source for the specification** of the LDBC Social Network Benchmark. This README discusses how to build the [specification PDF](http://ldbcouncil.org/ldbc_snb_docs/ldbc-snb-specification.pdf) from source.

### Generating query cards

To get consistent formatting, query cards are generated from query specifications defined in [YAML](http://yaml.org/) format. This is a necessary step to compile to the document.

Install Pandoc, Python3, and the required packages:

```bash
scripts/install-dependencies.sh
```

### Building the document

To build the document locally, run `make` or `make texfot`. The latter requires Perl but gives you a cleaner output.

We also provide a [GitHub Action repository and a Docker container](https://github.com/ldbc/document-builder) and [images on Docker Hub](https://hub.docker.com/r/ldbc/document-builder). To use this locally, run:

```bash
docker run --rm --volume=`pwd`:"/github/workspace" ldbc/document-builder:2021 texfot compile_query_cards workloads && sudo chown -R ${USER}:${USER} .
```

For the GitHub Actions configuration, check out the content of the [`.github/workflows/`](.github/workflows/ directory).
