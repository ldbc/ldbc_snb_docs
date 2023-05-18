#!/bin/bash

set -eu

export BI_DATA_ROOT_DIR=~/ldbc-bi-2022/
export STATS_DIR=~

cd ${BI_DATA_ROOT_DIR}

for SF in 1 3 10 30 100 300 1000 3000 10000 30000; do
    cat bi-sf${SF}-composite-projected-fk.tar.zst* | tar -xv --use-compress-program=unzstd
done

for SF in 1 3 10 30 100 300 1000 3000 10000 30000; do
    echo ${SF}
    cd ${BI_DATA_ROOT_DIR}/bi-sf${SF}-composite-projected-fk/graphs/csv/bi/composite-projected-fk/

    echo -n > ${STATS_DIR}/inserts-sf${SF}.csv
    echo -n > ${STATS_DIR}/deletes-sf${SF}.csv

    # inserts
    for ENTITY in Comment Comment_hasCreator_Person Comment_hasTag_Tag Comment_isLocatedIn_Country Comment_replyOf_Comment Comment_replyOf_Post Forum Forum_containerOf_Post Forum_hasMember_Person Forum_hasModerator_Person Forum_hasTag_Tag Person Person_hasInterest_Tag Person_isLocatedIn_City Person_knows_Person Person_likes_Comment Person_likes_Post Person_studyAt_University Person_workAt_Company Post Post_hasCreator_Person Post_hasTag_Tag Post_isLocatedIn_Country; do
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

