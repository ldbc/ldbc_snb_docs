![LDBC_LOGO](https://raw.githubusercontent.com/wiki/ldbc/ldbc_snb_datagen/images/ldbc-logo.png)
# LDBC SNB Documentation

[![Build Status](https://travis-ci.org/ldbc/ldbc_snb_docs.svg?branch=stable)](https://travis-ci.org/ldbc/ldbc_snb_docs)

[[PDF]](http://ldbc.github.io/ldbc_snb_docs/ldbc-snb-specification.pdf)

## Benchmark specification

For a quick overview of LDBC SNB, start with our [presentation](https://docs.google.com/presentation/d/1p-nuHarSOKCldZ9iEz__6_V3sJ5kbGWlzZHusudW_Cc/).

For a guide on how to develop benchmark implementations, please check out the [Benchmark Workflow](workflow.md) file.

## Compatibility

The LDBC Social Network Benchmark suite is continuously maintained with improvements in the specification, the data generator, the driver, and the reference implementation.
To ensure that you are using compatible LDBC repositories, use the following table:

| project | v0.3.x | v0.4.x |
| ------- | ------ | ------ |
| [Documentation](https://github.com/ldbc/ldbc_snb_docs) | [`v0.3.3`](https://github.com/ldbc/ldbc_snb_docs/releases/tag/v0.3.3) | [`dev`](https://github.com/ldbc/ldbc_snb_docs/tree/dev) |
| [Datagen](https://github.com/ldbc/ldbc_snb_datagen) | [`v0.3.3`](https://github.com/ldbc/ldbc_snb_datagen/releases/tag/v0.3.3) | [`dev`](https://github.com/ldbc/ldbc_snb_datagen/tree/dev) |
| [Driver](https://github.com/ldbc/ldbc_snb_driver) | [`v0.3.3`](https://github.com/ldbc/ldbc_snb_driver/releases/tag/0.3.3) | [`dev`](https://github.com/ldbc/ldbc_snb_driver/tree/dev) |
| [Implementations](https://github.com/ldbc/ldbc_snb_implementations) | [`stable`](https://github.com/ldbc/ldbc_snb_implementations/tree/stable) | [`dev`](https://github.com/ldbc/ldbc_snb_implementations/tree/dev) |

The `stable` branches of the repositories correspond to the `v0.3.x`, and the `dev` branches correspond to the `v0.4.x` releases.

## How to cite LDBC benchmarks

* **Social Network Benchmark**
  * **Detailed specification:** [The LDBC Social Network Benchmark (version 0.3.3)](https://arxiv.org/pdf/2001.02299.pdf) by the LDBC Social Network Benchmark task force, 2020. [[bib](bib/specification.bib)]
  * **BI workload:** [An early look at the LDBC Social Network Benchmark's Business Intelligence workload](http://ldbcouncil.org/sites/default/files/ldbc-bi-grades.pdf), GRADES-NDA at SIGMOD 2018 by G. Szárnyas et al. [[bib](bib/snb-bi.bib)]
  * **Interactive workload:** [The LDBC Social Network Benchmark: Interactive Workload](https://ir.cwi.nl/pub/23380), SIGMOD 2015 by O. Erling et al. [[bib](bib/snb-interactive.bib)]
* **Other LDBC benchmarks**
  * **LDBC Graphalytics:** [LDBC Graphalytics: A Benchmark for Large-Scale Graph Analysis on Parallel and Distributed Platforms](http://www.vldb.org/pvldb/vol9/p1317-iosup.pdf), VLDB 2016 paper by A. Iosup et al. [[bib](bib/graphalytics.bib)], [The LDBC Graphalytics Benchmark](https://arxiv.org/pdf/2011.15028.pdf), technical report [[bib](bib/graphalytics-specification.bib)]
  * **LDBC Semantic Publishing Benchmark:** [Benchmarking RDF Query Engines: The LDBC Semantic Publishing Benchmark](http://ceur-ws.org/Vol-1700/paper-01.pdf), BLINK at ISWC 2016 by V. Kotsev et al. [[bib](bib/spb.bib)]

## How to build the this document

**This repository contains the LaTeX source for the specification** of the LDBC Social Network Benchmark. This README discusses how to build the [specification PDF](http://ldbc.github.io/ldbc_snb_docs/ldbc-snb-specification.pdf) from source.

### Generating query cards

To get consistent formatting, query cards are generated from query specifications defined in [YAML](http://yaml.org/) format. This is a necessary step to compile to the document.

Install Pandoc and Python3 following dependencies:

```bash
sudo apt-get install -y pandoc
sudo apt-get install -y python3 python3-pip python3-setuptools
pip3 install -r requirements.txt
```

### Building the document

To build the document, run `make` or `make texfot`. The latter requires Perl but gives you a cleaner output.

We also provide [an image on Docker Hub](https://hub.docker.com/r/ldbc/docs) for building the document. To use it, run:

```bash
docker run -v `pwd`/:/mnt/ ldbc/docs /bin/bash -c \
  "cd /mnt/ && ./generate-tex.py && make generate_query_cards texfot compile_query_cards"; \
  sudo chown -R $USER:$USER .
```

You can also compile the image manually by issuing:

```bash
docker build . --tag ldbc/docs
```

### Notations and conventions

#### Naming conventions

* If an attribute exists in the graph as part of an entity (node/edge) and is returned unchanged, name it `entity.attributeName`.
* If an attribute is computed or aggregated, use `camelCase` notation.
