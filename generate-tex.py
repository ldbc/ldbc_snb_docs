#!/usr/bin/env python3

import yaml
import glob
from jinja2 import Template
from os.path import basename, splitext
from subprocess import check_output

def escape(s):
    return s\
        .replace("_", "\\_")\
        .replace("&", "\\&")


def escape_map_values(map):
    if map is not None:
        map.update({k: escape(v) for k, v in map.items()})
        return map


def escape_list_entries(list):
    if list is not None:
        return [escape(e) for e in list]


def escape_map_list(list_of_maps):
    if list_of_maps is not None:
        return [escape_map_values(e) for e in list_of_maps]


with open('query-card-template.tex', 'r') as f:
    template = Template(f.read())

variable_template = Template('\\variable{name}{type}')

for filename in glob.glob("query-specifications/*.yaml"):
    print("Processing query specification: %s" % (filename))
    query_name = splitext(basename(filename))[0]
    with open(filename, 'r') as f:
        doc = yaml.load(f)

    number = doc['number']
    number_string = "%02d" % (number)
    description_markdown = doc['description']

    # currently, there are no off-the-shelf solutions for markdown -> latex conversion in Python3,
    # so we use Pandoc
    description_latex = check_output(
        ["pandoc", "--from=markdown", "--to=latex"],
        universal_newlines = True,
        input = description_markdown
    )

    query_card = template.render(
        number        = number,
        workload      = doc['workload'],
        number_string = number_string,
        title         = escape(doc['title']),
        description   = description_latex,
        group         = escape_list_entries(doc.get('group')),
        parameters    = escape_map_list(doc['parameters']),
        result        = escape_map_list(doc['result']),
        sort          = escape_map_list(doc.get('sort')),
        limit         = doc.get('limit'),
        choke_points  = doc.get('choke_points'),
    )

    with open("query-cards/%s.tex" % (query_name), 'w') as query_card_file:
        query_card_file.write(query_card)
