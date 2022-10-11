#!/bin/bash

set -eu

export BI_DATA_ROOT_DIR=~/ldbc-bi-2022/
export STATS_DIR=~

for SF in 10000; do
    echo ${SF}
    cd ${BI_DATA_ROOT_DIR}/bi-sf${SF}-composite-projected-fk/graphs/csv/bi/composite-projected-fk/initial_snapshot

    echo -n > ${STATS_DIR}/stats-sf${SF}.csv

    for DIR in dynamic/Comment dynamic/Comment_hasCreator_Person dynamic/Comment_hasTag_Tag dynamic/Comment_isLocatedIn_Country dynamic/Comment_replyOf_Comment dynamic/Comment_replyOf_Post dynamic/Forum dynamic/Forum_containerOf_Post dynamic/Forum_hasMember_Person dynamic/Forum_hasModerator_Person dynamic/Forum_hasTag_Tag dynamic/Person dynamic/Person_hasInterest_Tag dynamic/Person_isLocatedIn_City dynamic/Person_knows_Person dynamic/Person_likes_Comment dynamic/Person_likes_Post dynamic/Person_studyAt_University dynamic/Person_workAt_Company dynamic/Post dynamic/Post_hasCreator_Person dynamic/Post_hasTag_Tag dynamic/Post_isLocatedIn_Country static/Organisation static/Organisation_isLocatedIn_Place static/Place static/Place_isPartOf_Place static/Tag static/TagClass static/TagClass_isSubclassOf_TagClass static/Tag_hasType_TagClass; do
        echo ${DIR}
        for FILE in ${DIR}/*.csv.gz; do
            echo "${DIR} $(zcat ${FILE} | tail -n +2 | wc -l)" >> ${STATS_DIR}/stats-sf${SF}.csv
        done
    done
done
