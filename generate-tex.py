#!/usr/bin/env python3

import yaml
import glob
from jinja2 import Template
from os.path import basename, splitext
from subprocess import check_output
from collections import defaultdict


# for Markdown to TeX conversion, we invoke Pandoc as a subprocess
def convert_markdown_to_tex(markdown):
    return check_output(
        ["pandoc", "--from=markdown", "--to=latex"],
        universal_newlines=True,
        input=markdown
    )


def convert_map_values_to_tex(map):
    if map is not None:
        map.update({k: convert_markdown_to_tex(v) for k, v in map.items()})
        return map


def convert_list_entries_to_tex(list):
    if list is not None:
        return [convert_markdown_to_tex(e) for e in list]


def convert_map_list_to_tex(list_of_maps):
    if list_of_maps is not None:
        return [convert_map_values_to_tex(e) for e in list_of_maps]

##### query cards

with open('templates/query-card-template.tex', 'r') as f:
    query_card_template = Template(f.read())

with open('templates/short-description-template.tex', 'r') as f:
    short_description_template = Template(f.read())

with open('templates/standalone-query-card.tex', 'r') as f:
    standalone_query_card_template = Template(f.read())

with open('templates/parameters', 'r') as f:
    parameters_template = Template(f.read())

all_choke_points = set()
all_queries = set()
query_choke_point = defaultdict(list)      # queries -> cps
choke_point_references = defaultdict(list) # cps -> queries

for filename in glob.glob("query-specifications/*.yaml"):
    print("Processing query specification: %s" % filename)
    query_id = splitext(basename(filename))[0]

    with open(filename, 'r') as f:
        doc = yaml.load(f, Loader=yaml.FullLoader)

    number = doc['number']
    #number_string = "%02d" % (number)
    number_string = number
    workload = doc['workload']
    title = doc['title']
    description_markdown = doc['description']
    operation = doc['operation']

    query_tuple = (query_id, workload, operation, number)
    all_queries.add(query_tuple)

    choke_points = list(map(lambda e: str(e), doc.get('choke_points', [])))
    for choke_point in choke_points:
        choke_point_references[choke_point].append(query_tuple)
        all_choke_points.add(choke_point)

    query_choke_point[query_id] = choke_points

    description_tex = convert_markdown_to_tex(description_markdown)
    
    # optional arguments 
    parameters = doc.get('parameters')
    results = doc.get('result')
    sort = doc.get('sort')
    limit = doc.get('limit')
   
    relevance_markdown = doc.get('relevance')
    if relevance_markdown is None:
        relevance_tex = None
    else:
        relevance_tex = convert_markdown_to_tex(relevance_markdown)

    parameter_file_text = parameters_template.render(
        parameters = parameters,
    )

    with open("parameters/%s.parameters" % query_id, 'w') as parameter_file:
        parameter_file.write(parameter_file_text)

    query_card_text = query_card_template.render(
        number        = number,
        workload      = workload,
        operation     = operation,
        number_string = number_string,
        query_id      = query_id,
        title         = title,
        description   = description_tex,
        parameters    = convert_map_list_to_tex(parameters),
        result        = convert_map_list_to_tex(results),
        sort          = convert_map_list_to_tex(sort),
        limit         = limit,
        choke_points  = choke_points,
        relevance     = relevance_tex,
    )

    with open("query-cards/%s.tex" % query_id, 'w') as query_card_file:
        query_card_file.write(query_card_text)

    ##### short descriptions
    short_description_text = short_description_template.render(
        number        = number,
        title         = title,
        description   = description_tex,
    )
    short_description_text = short_description_text.replace("\n\n", "\n")

    with open("short-descriptions/%s.tex" % query_id, 'w') as short_description_file:
        short_description_file.write(short_description_text)

    ##### standalone query cards
    standalone_query_card_text = standalone_query_card_template.render(
        query_id=query_id
    )
    with open("standalone-query-cards/%s.tex" % query_id, 'w') as standalone_query_card_file:
        standalone_query_card_file.write(standalone_query_card_text)

##### choke points

with open('templates/choke-point-template.tex', 'r') as f:
    choke_point_template = Template(f.read())

for choke_point in choke_point_references:
    choke_point_filename = choke_point.replace('.', '-')

    queries = choke_point_references[choke_point]
    queries_sorted = sorted(queries, key=lambda tup: tup[0])
    choke_point_text = choke_point_template.render(
        queries = queries_sorted,
    )

    with open("choke-points/cp-%s.tex" % choke_point_filename, 'w') as choke_point_file:
        choke_point_file.write(choke_point_text)

##### table for choke points and queries

print('Processing choke points... ', end='')

all_queries_sorted = sorted(all_queries, key=lambda tup: tup[0])
all_choke_points_sorted = sorted(all_choke_points)

with open('templates/choke-points-queries.tex', 'r') as f:
    choke_points_queries_template = Template(f.read())

choke_points_queries_text = choke_points_queries_template.render(
    choke_point_references = choke_point_references,
    query_choke_point = query_choke_point,
    queries = all_queries_sorted,
    choke_points = all_choke_points_sorted,
)

with open("choke-points/choke-points-queries.tex", 'w') as choke_points_queries_template:
    choke_points_queries_template.write(choke_points_queries_text)

#### CSV for choke points and queries (to be pasted in a spreadsheet)

with open('templates/choke-points-queries.csv', 'r') as f:
    choke_points_queries_template = Template(f.read())

choke_points_queries_text = choke_points_queries_template.render(
    choke_point_references = choke_point_references,
    query_choke_point = query_choke_point,
    queries = all_queries_sorted,
    choke_points = all_choke_points_sorted,
)

with open("choke-points/choke-points-queries.csv", 'w') as choke_points_queries_template:
    choke_points_queries_template.write(choke_points_queries_text)

print('Done')
