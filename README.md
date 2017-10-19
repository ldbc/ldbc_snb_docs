![LDBC_LOGO](https://raw.githubusercontent.com/wiki/ldbc/ldbc_snb_datagen/images/ldbc-logo.png)
# LDBC SNB Documentation

[![Build Status](https://travis-ci.org/ldbc/ldbc_snb_docs.svg?branch=master)](https://travis-ci.org/ldbc/ldbc_snb_docs)

[[Latest stable build (PDF)]](http://ldbc.github.io/ldbc_snb_docs/ldbc-snb-specification.pdf) [[Latest snapshot build (PDF)]](http://ldbc.github.io/ldbc_snb_docs_snapshot/ldbc-snb-specification.pdf)

This repository contains the LaTeX source for the specification of the LDBC Social Network Benchmark.

This README discusses how to build the [specification PDF](http://ldbc.github.io/ldbc_snb_docs/ldbc-snb-specification.pdf) from source. For an architectural overview and guide on how to  develop benchmark implementations, please visit the [wiki of this repository](https://github.com/ldbc/ldbc_snb_docs/wiki).

## Generating query cards

To get consistent formatting, query cards are generated from query specifications defined in [YAML](http://yaml.org/) format.

1. Install Pandoc and Python3 following dependencies:

    ```bash
    sudo apt-get install -y pandoc
    sudo apt-get install -y python3 python3-pip python3-setuptools
    ```

1. To generate the TeX files for query cards, run the following command:

    ```bash
    ./generate-tex.py
    ```

## Building the document

To build the document, run `make` or `make texfot`. The latter requires Perl but gives you a cleaner output.

If you are using a Linux-based system, you can also check the [`.travis.yml`](.travis.yml) file as it provides a precise documentation of what you should do in order to build the docs.

## Notations and conventions

### Query specifications

The query specifications are defined in [YAML](http://yaml.org/) format.

### Naming conventions

* If an attribute exists in the graph as part of an entity (vertex/edge) and is returned unchanged, name it `entity.attributeName`.
* If it is computed or aggregated, use `camelCase` notation.
