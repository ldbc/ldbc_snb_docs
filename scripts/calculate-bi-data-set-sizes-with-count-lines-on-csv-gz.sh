#!/bin/bash

# Calculate BI data set sizes by running `wc -l` on the `.csv.gz` files using streaming decompression via `zcat`
# We use `tail -n +2` to ignore the headers of the CSV files.

set -eu

export BI_DATA_ROOT_DIR=~/ldbc-bi-2022/
export STATS_DIR=~

cd ${BI_DATA_ROOT_DIR}

for SF in 1 3 10 30 100 300 1000 3000 10000 30000; do
    echo ${SF}
    cd ${BI_DATA_ROOT_DIR}/bi-sf${SF}-composite-projected-fk/graphs/csv/bi/composite-projected-fk/

    echo -n > ${STATS_DIR}/inserts-sf${SF}.csv
    echo -n > ${STATS_DIR}/deletes-sf${SF}.csv
    echo -n > ${STATS_DIR}/initial-snapshot-sf${SF}.csv

    # inserts
    for ENTITY in Comment Comment_hasCreator_Person Comment_hasTag_Tag Comment_isLocatedIn_Country Comment_replyOf_Comment Comment_replyOf_Post Forum Forum_containerOf_Post Forum_hasMember_Person Forum_hasModerator_Person Forum_hasTag_Tag Person Person_hasInterest_Tag Person_isLocatedIn_City Person_knows_Person Person_likes_Comment Person_likes_Post Person_studyAt_University Person_workAt_Company Post Post_hasCreator_Person Post_hasTag_Tag Post_isLocatedIn_Country; do
        echo "## Inserts"
        echo ${ENTITY}

        for FILE in inserts/dynamic/${ENTITY}/*/*.csv.gz; do
            echo "${ENTITY} $(zcat ${FILE} | tail -n +2 | wc -l)" >> ${STATS_DIR}/inserts-sf${SF}.csv
        done
    done

    # deletes
    for ENTITY in Comment Forum Forum_hasMember_Person Person Person_knows_Person Person_likes_Comment Person_likes_Post Post; do
        echo "## Deletes"
        echo ${ENTITY}

        for FILE in deletes/dynamic/${ENTITY}/*/*.csv.gz; do
            echo "${ENTITY} $(zcat ${FILE} | tail -n +2 | wc -l)" >> ${STATS_DIR}/deletes-sf${SF}.csv
        done
    done

    # initial snapshot
    for DIR in dynamic/Comment dynamic/Comment_hasCreator_Person dynamic/Comment_hasTag_Tag dynamic/Comment_isLocatedIn_Country dynamic/Comment_replyOf_Comment dynamic/Comment_replyOf_Post dynamic/Forum dynamic/Forum_containerOf_Post dynamic/Forum_hasMember_Person dynamic/Forum_hasModerator_Person dynamic/Forum_hasTag_Tag dynamic/Person dynamic/Person_hasInterest_Tag dynamic/Person_isLocatedIn_City dynamic/Person_knows_Person dynamic/Person_likes_Comment dynamic/Person_likes_Post dynamic/Person_studyAt_University dynamic/Person_workAt_Company dynamic/Post dynamic/Post_hasCreator_Person dynamic/Post_hasTag_Tag dynamic/Post_isLocatedIn_Country static/Organisation static/Organisation_isLocatedIn_Place static/Place static/Place_isPartOf_Place static/Tag static/TagClass static/TagClass_isSubclassOf_TagClass static/Tag_hasType_TagClass; do
        echo "## Initial snapshot"
        echo ${DIR}

        for FILE in ${DIR}/*.csv.gz; do
            echo "${DIR} $(zcat ${FILE} | tail -n +2 | wc -l)" >> ${STATS_DIR}/stats-sf${SF}.csv
        done
    done
done

