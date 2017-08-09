# Changelog

## 0.3.0

### Formatting and technical improvements

* Introduced continuous integration for the document using the [Travis CI](https://travis-ci.org/ldbc/ldbc_snb_docs) service.
* Introduced YAML files for defining query specifications and a Python script with [Jinja templates](http://jinja.pocoo.org/) to generate TeX code. These hold all query and update operations for both workloads (BI and Interactive).
* Added headers for easier navigation.
* Fixed character encoding issues.
* Redrawn the schema in [yEd](https://www.yworks.com/products/yed).

### Contents

* Introduced "query cards" to represent queries in a succint way, containing both the textual description and the visual representation (graph pattern) of the query, input parameters, expected result fields, etc.
* Restructured the document:
  * Merge BI and interactive choke points and moved the to the appendix.
  * Added chapter for presenting related work.
* Add links between choke points and queries both ways, and also introduced a table to represent the coverage of choke points.
* Added references to related LDBC works.
* Added and reviewed BI queries, resulting in a lot of corrections and improvements.
* Updated contributors section.
