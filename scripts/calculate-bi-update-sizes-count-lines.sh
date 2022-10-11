#!/bin/bash

set -eu

export BI_DATA_ROOT_DIR=~/ldbc-bi-2022/
export STATS_DIR=~

for SF in 1 3 10 30 100 300 1000 3000 10000; do
    echo ${SF}
    cd ${BI_DATA_ROOT_DIR}/bi-sf${SF}-composite-merged-fk/graphs/csv/bi/composite-merged-fk/

    echo -n > ${STATS_DIR}/inserts-sf${SF}.csv
    echo -n > ${STATS_DIR}/deletes-sf${SF}.csv

    # inserts
    for ENTITY in Comment Comment_hasTag_Tag Forum Forum_hasMember_Person Forum_hasTag_Tag Person Person_hasInterest_Tag Person_knows_Person Person_likes_Comment Person_likes_Post Person_studyAt_University Person_workAt_Company Post Post_hasTag_Tag; do
        echo ${ENTITY}
        for FILE in inserts/dynamic/${ENTITY}/*/*.csv.gz; do
            echo "${ENTITY} $(zcat ${FILE} | tail -n +2 | wc -l)" >> ${STATS_DIR}/inserts-sf${SF}.csv
        done
    done

    # deletes
    for ENTITY in Comment Forum Forum_hasMember_Person Person Person_knows_Person Person_likes_Comment Person_likes_Post Post; do
        echo ${ENTITY}
        for FILE in deletes/dynamic/${ENTITY}/*/*.csv.gz; do
            echo "${ENTITY} $(zcat ${FILE} | tail -n +2 | wc -l)" >> ${STATS_DIR}/deletes-sf${SF}.csv
        done
    done
done
