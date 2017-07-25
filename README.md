![LDBC_LOGO](https://raw.githubusercontent.com/wiki/ldbc/ldbc_snb_datagen/images/ldbc-logo.png)
# LDBC SNB Documentation

[![Build Status](https://travis-ci.org/ldbc/ldbc_snb_docs.svg?branch=master)](https://travis-ci.org/ldbc/ldbc_snb_docs)

[latest stable build (PDF))](http://ldbc.github.io/ldbc_snb_docs/ldbc-snb-specification.pdf) | [latest snapshot build (PDF)](http://ldbc.github.io/ldbc_snb_docs_snapshot/ldbc-snb-specification.pdf)

## Contributor's guide

* Install Python dependencies:

   ```
   sudo apt-get install -y python3-pip python3-setuptools
   ```

* We also use the `pandoc` package for Markdown to LaTeX conversion.

* To build the document, run `make` or `make texfot`. The latter requires Perl but gives you a cleaner output.

If you are using a Linux-based system, you can also check the [`.travis.yml`](.travis.yml) file as it provides a precise documentation of what you should do in order to build the docs.
