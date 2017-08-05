#!/usr/bin/env python3

import yaml
import glob
from jinja2 import Template
from os.path import basename, splitext
from subprocess import check_output
from collections import defaultdict

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
    query_card_template = Template(f.read())

choke_point_references = defaultdict(list)

for filename in glob.glob("query-specifications/*.yaml"):
    print("Processing query specification: %s" % (filename))
    query_id = splitext(basename(filename))[0]
    with open(filename, 'r') as f:
        doc = yaml.load(f)

    number = doc['number']
    number_string = "%02d" % (number)
    workload = doc['workload']
    description_markdown = doc['description']
    operation = doc['operation']

    choke_points = doc.get('choke_points', [])
    for choke_point in choke_points:
        choke_point_references[choke_point].append((query_id, workload, operation, number))

    # currently, there are no off-the-shelf solutions for Markdown to TeX conversion in Python 3,
    # so we use Pandoc -- it's hands down the best Markdown to Tex converter you can get anyways
    description_latex = check_output(
        ["pandoc", "--from=markdown", "--to=latex"],
        universal_newlines = True,
        input = description_markdown
    )

    query_card_text = query_card_template.render(
        number        = number,
        workload      = workload,
        operation     = operation,
        number_string = number_string,
        query_id      = query_id,
        title         = escape(doc['title']),
        description   = description_latex,
        group         = escape_list_entries(doc.get('group')),
        parameters    = escape_map_list(doc.get('parameters')),
        result        = escape_map_list(doc.get('result')),
        sort          = escape_map_list(doc.get('sort')),
        limit         = doc.get('limit'),
        choke_points  = choke_points,
        relevance     = doc.get('relevance'),
    )

    with open("query-cards/%s.tex" % query_id, 'w') as query_card_file:
        query_card_file.write(query_card_text)

with open('choke-point-template.tex', 'r') as f:
    choke_point_template = Template(f.read())

for choke_point in choke_point_references:
    choke_point_filename = str(choke_point).replace('.', '-')

    queries = choke_point_references[choke_point]
    queries_sorted = sorted(queries, key=lambda tup: tup[0])
    choke_point_text = choke_point_template.render(
        queries = queries_sorted,
    )

    with open("query-cards/cp-%s.tex" % choke_point_filename, 'w') as choke_point_file:
        choke_point_file.write(choke_point_text)
