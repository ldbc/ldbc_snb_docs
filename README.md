![LDBC_LOGO](https://raw.githubusercontent.com/wiki/ldbc/ldbc_snb_datagen/images/ldbc-logo.png)
# LDBC SNB Documentation

[![Build Status](https://travis-ci.org/ldbc/ldbc_snb_docs.svg?branch=master)](https://travis-ci.org/ldbc/ldbc_snb_docs)

[[Latest stable build (PDF)]](http://ldbc.github.io/ldbc_snb_docs/ldbc-snb-specification.pdf) [[Latest snapshot build (PDF)]](http://ldbc.github.io/ldbc_snb_docs_snapshot/ldbc-snb-specification.pdf)

## Benchmark specification

**For an architectural overview and guide on how to  develop benchmark implementations, please visit the [wiki of this repository](https://github.com/ldbc/ldbc_snb_docs/wiki).**

## Documentation of the specification's code

**This repository contains the LaTeX source for the specification** of the LDBC Social Network Benchmark. This README discusses how to build the [specification PDF](http://ldbc.github.io/ldbc_snb_docs/ldbc-snb-specification.pdf) from source.

### Generating query cards

To get consistent formatting, query cards are generated from query specifications defined in [YAML](http://yaml.org/) format. To regenerate them, follow these steps.

1. Install Pandoc and Python3 following dependencies:

    ```bash
    sudo apt-get install -y pandoc
    sudo apt-get install -y python3 python3-pip python3-setuptools
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
