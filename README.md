![LDBC_LOGO](https://raw.githubusercontent.com/ldbc/ldbc_snb_docs/main/figures/ldbc-logo.png)
# LDBC SNB Documentation

[![Build Status](https://github.com/ldbc/ldbc_snb_docs/actions/workflows/compile-spec.yml/badge.svg)](https://github.com/ldbc/ldbc_snb_docs/actions)

[[latest PDF (2.2.4-SNAPSHOT)]](https://ldbcouncil.org/ldbc_snb_docs/ldbc-snb-specification.pdf)
[[stable PDF (2.2.3)]](https://arxiv.org/pdf/2001.02299.pdf)

## Benchmark specification

For a quick overview of LDBC SNB, start with [The LDBC Benchmark Suite presentation](https://archive.fosdem.org/2023/schedule/event/ldcb_benchmark_suite/attachments/slides/5767/export/events/attachments/ldcb_benchmark_suite/slides/5767/the_ldbc_benchmark_suite_fosdem_hpc_devroom_2023_szarnyas.pdf) [🎥 recording](https://www.youtube.com/watch?v=q26DHnQFw54) by Gábor Szárnyas (FOSDEM 2024).

For a guide on how to develop SNB implementations, please check out the READMEs of the reference implementation repositories linked below.

## Software components

The SNB workloads are stored in different repositories:

* SNB Interactive v1:
  * Data generator: https://github.com/ldbc/ldbc_snb_datagen_hadoop
  * Driver: https://github.com/ldbc/ldbc_snb_interactive_v1_driver
  * Reference implementations: https://github.com/ldbc/ldbc_snb_interactive_v1_impls
* SNB Interactive v2 (work-in-progress):
  * Data generator: https://github.com/ldbc/ldbc_snb_datagen_spark
  * Driver: https://github.com/ldbc/ldbc_snb_interactive_v2_driver
  * Reference implementations: https://github.com/ldbc/ldbc_snb_interactive_v2_impls
* SNB Business Intelligence (BI):
  * Data generator: https://github.com/ldbc/ldbc_snb_datagen_spark
  * Driver and reference implementations: https://github.com/ldbc/ldbc_snb_bi

## How to cite LDBC benchmarks

* **Social Network Benchmark:**
  * **Detailed specification:** [The LDBC Social Network Benchmark](https://arxiv.org/pdf/2001.02299.pdf) by the LDBC Social Network Benchmark task force and contributors, arXiv/CoRR abs/2001.02299, 2020. [[bib](bib/specification.bib)]
  * **BI workload:** [An early look at the LDBC Social Network Benchmark's Business Intelligence workload](https://ldbcouncil.org/sites/default/files/ldbc-bi-grades.pdf), GRADES-NDA at SIGMOD 2018 by G. Szárnyas et al. [[bib](bib/snb-bi.bib)]
  * **Interactive workload:** [The LDBC Social Network Benchmark: Interactive Workload](https://ir.cwi.nl/pub/23380), SIGMOD 2015 by O. Erling et al. [[bib](bib/snb-interactive.bib)]
* **Related benchmarks:**
  * **LDBC Graphalytics:** [LDBC Graphalytics: A Benchmark for Large-Scale Graph Analysis on Parallel and Distributed Platforms](https://www.vldb.org/pvldb/vol9/p1317-iosup.pdf), VLDB 2016 paper by A. Iosup et al. [[bib](bib/graphalytics.bib)], [The LDBC Graphalytics Benchmark](https://arxiv.org/pdf/2011.15028.pdf), technical report [[bib](bib/graphalytics-specification.bib)]
  * **LDBC Semantic Publishing Benchmark:** [Benchmarking RDF Query Engines: The LDBC Semantic Publishing Benchmark](http://ceur-ws.org/Vol-1700/paper-01.pdf), BLINK at ISWC 2016 by V. Kotsev et al. [[bib](bib/spb.bib)]
  * **LSQB (Labelled Subgraph Query Benchmark):** a [microbenchmark](https://github.com/ldbc/lsqb) focusing on subgraph queries (graph pattern matching) using labelled graphs produced by the LDBC data generator. [[bib](bib/lsqb.bib)]

## How to build the this document

**This repository contains the LaTeX source for the specification** of the LDBC Social Network Benchmark. This README discusses how to build the [specification PDF](https://ldbcouncil.org/ldbc_snb_docs/ldbc-snb-specification.pdf) from source.

### Generating query cards

To get consistent formatting, query cards are generated from query specifications defined in [YAML](https://yaml.org/) format. This is a necessary step to compile to the document.

Install Pandoc, Python, and the required packages:

```bash
scripts/install-dependencies.sh
```

### Building the document

To build the document locally, run `make` or `make texfot`. The latter requires Perl but produces a cleaner output.

We also provide a [GitHub Action repository and a Docker container](https://github.com/ldbc/document-builder) and [images on Docker Hub](https://hub.docker.com/r/ldbc/document-builder). To use this locally, run:

```bash
docker run --rm --volume=`pwd`:"/github/workspace" ldbc/document-builder:2021 texfot query_cards workloads && sudo chown -R ${USER}:${USER} .
```
