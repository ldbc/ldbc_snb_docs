![LDBC_LOGO](https://raw.githubusercontent.com/wiki/ldbc/ldbc_snb_datagen/images/ldbc-logo.png)
# LDBC SNB Documentation

[![Build Status](https://travis-ci.org/ldbc/ldbc_snb_docs.svg?branch=master)](https://travis-ci.org/ldbc/ldbc_snb_docs)

[[Latest stable build (PDF)]](http://ldbc.github.io/ldbc_snb_docs/ldbc-snb-specification.pdf) [[Latest snapshot build (PDF)]](http://ldbc.github.io/ldbc_snb_docs_snapshot/ldbc-snb-specification.pdf)

## Benchmark specification

**For an architectural overview and guide on how to develop benchmark implementations, please visit the [wiki of this repository](https://github.com/ldbc/ldbc_snb_docs/wiki).**

## Related repositories

The documentation of the [LDBC Graphalytics benchmark](https://graphalytics.org) is maintained in a [separate repository](https://github.com/ldbc/ldbc_graphalytics_docs).

## How to cite LDBC benchmarks

* **LDBC Semantic Publishing Benchmark:** _Venelin Kotsev, Nikos Minadakis, Vassilis Papakonstantinou, Orri Erling, Irini Fundulaki, Atanas Kiryakov: Benchmarking RDF Query Engines: The LDBC Semantic Publishing Benchmark. BLINK@ISWC 2016_ [[bib](bib/spb.bib)].
* **LDBC Graphalytics:** _Alexandru Iosup, Tim Hegeman, Wing Lung Ngai, Stijn Heldens, Arnau Prat-Pérez, Thomas Manhardt, Hassan Chafi, Mihai Capota, Narayanan Sundaram, Michael J. Anderson, Ilie Gabriel Tanase, Yinglong Xia, Lifeng Nai, Peter A. Boncz: LDBC Graphalytics: A Benchmark for Large-Scale Graph Analysis on Parallel and Distributed Platforms. PVLDB 9(13): 1317-1328 (2016)_ [[bib](bib/graphalytics.bib)].
* **LDBC Social Network Benchmark - Interactive workload:** _Orri Erling, Alex Averbuch, Josep-Lluís Larriba-Pey, Hassan Chafi, Andrey Gubichev, Arnau Prat-Pérez, Minh-Duc Pham, Peter A. Boncz: The LDBC Social Network Benchmark: Interactive Workload. SIGMOD Conference 2015: 619-630_ [[bib](bib/snb-interactive.bib)].
* **LDBC Social Network Benchmark - BI workload:** _Gábor Szárnyas, Arnau Prat-Pérez, Alex Averbuch, József Marton, Marcus Paradies, Moritz Kaufmann, Orri Erling, Peter A. Boncz, Vlad Haprian, János Benjamin Antal: An early look at the LDBC social network benchmark's business intelligence workload. GRADES/NDA@SIGMOD/PODS 2018: 9:1-9:11_ [[bib](bib/snb-bi.bib)].
* **The full specification:** _LDBC Social Network Benchmark task force: The LDBC Social Network Benchmark (version 0.4.0-SNAPSHOT), Linked Data Benchmark Council, 2019, <https://ldbc.github.io/ldbc_snb_docs/ldbc-snb-specification.pdf>_ [[bib](bib/specification.bib)].

## How to build the this document

**This repository contains the LaTeX source for the specification** of the LDBC Social Network Benchmark. This README discusses how to build the [specification PDF](http://ldbc.github.io/ldbc_snb_docs/ldbc-snb-specification.pdf) from source.

### Generating query cards

To get consistent formatting, query cards are generated from query specifications defined in [YAML](http://yaml.org/) format. To regenerate them, follow these steps.

1. Install Pandoc and Python3 following dependencies:

    ```bash
    sudo apt-get install -y pandoc
    sudo apt-get install -y python3 python3-pip python3-setuptools
    sudo pip3 install -r requirements.txt
    ```

1. To generate the TeX files for query cards, run the following command:

    ```bash
    make generate_query_cards
    ```

### Building the document

To build the document, run `make` or `make texfot`. The latter requires Perl but gives you a cleaner output.

We also provide a Dockerfile for building the document. To create the Docker image, run the following command:

```console
docker build . --tag ldbc/docs
```

Once the image is created, you can compile the document by issuing:

```console
docker run -v `pwd`/:/mnt/ ldbc/docs /bin/bash -c \
  "cd /mnt/ && ./generate-tex.py && make generate_query_cards texfot compile_query_cards"
```

### Notations and conventions

#### Naming conventions

* If an attribute exists in the graph as part of an entity (node/edge) and is returned unchanged, name it `entity.attributeName`.
* If it is computed or aggregated, use `camelCase` notation.
