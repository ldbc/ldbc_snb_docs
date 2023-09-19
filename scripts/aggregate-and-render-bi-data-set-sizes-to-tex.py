import duckdb

con = duckdb.connect()

con.execute(f"CREATE OR REPLACE TABLE stats (file varchar, numEntities bigint);")
con.execute(f"CREATE OR REPLACE TABLE sum_stats (sf bigint, file varchar, numEntities bigint);")

#sfs = [1, 3, 10, 30, 100, 300, 1000, 3000, 10000, 30000]
sfs = [30000]

for update in ["inserts", "deletes"]:
    con.execute(f"DELETE FROM sum_stats;")
    for sf in sfs:
        con.execute(f"DELETE FROM stats;")
        con.execute(f"COPY stats FROM '{update}-sf{sf}.csv' (DELIMITER ' ', HEADER false);")
        con.execute(f"""
            INSERT INTO sum_stats
                SELECT {sf} AS sf, file, sum(numEntities) AS numEntities FROM stats GROUP BY file;
            """)

    con.execute(f"""
        COPY (
            PIVOT sum_stats
            ON sf
            USING sum(numEntities)
            GROUP BY file
            ORDER BY translate(file, '_', '')
        ) TO '{update}-entities.csv' (HEADER, DELIMITER ',');
        """)

    con.execute(f"""
        COPY (
            SELECT
                'vertices' AS type, *
            FROM
                (PIVOT sum_stats
                ON sf
                USING sum(numEntities))
        UNION ALL
            SELECT 'edges' AS type, *
            FROM
                (PIVOT sum_stats
                ON sf
                USING sum(numEntities))
            WHERE regexp_matches(file, '.*_.*')
        UNION ALL
            SELECT 'total' AS type, *
            FROM
                (PIVOT sum_stats
                ON sf
                USING sum(numEntities))
        ) TO '{update}-summary.csv' (HEADER, DELIMITER ',');
        """)

    # initial snapshot
    con.execute(f"DELETE FROM sum_stats;")
    for sf in sfs:
        con.execute(f"DELETE FROM stats;")
        con.execute(f"COPY stats FROM 'initial-snapshot-sf{sf}.csv' (DELIMITER ' ', HEADER false);")
        con.execute(f"""
            INSERT INTO sum_stats
                SELECT {sf} AS sf, file, sum(numEntities) AS numEntities FROM stats GROUP BY file;
            """)

    con.execute(f"""
        COPY (
            PIVOT sum_stats
            ON sf
            USING sum(numEntities)
            GROUP BY file
            ORDER BY translate(file, '_', '')
        ) TO 'initial_snapshot.csv' (HEADER, DELIMITER ',');
        """)

    con.execute(f"""
        COPY (
            SELECT
                'vertices',
                printf('\\numprint{{%s}}'     , sum(numEntities) FILTER (WHERE sf = 1)) AS sf1_num_entities,
                printf('\\numprint{{%s}}'     , sum(numEntities) FILTER (WHERE sf = 3)) AS sf3_num_entities,
                printf('\\numprint{{%s}}'     , sum(numEntities) FILTER (WHERE sf = 10)) AS sf10_num_entities,
                printf('\\numprint{{%s}}'     , sum(numEntities) FILTER (WHERE sf = 30)) AS sf30_num_entities,
                printf('\\numprint{{%s}}'     , sum(numEntities) FILTER (WHERE sf = 100)) AS sf100_num_entities,
                printf('\\numprint{{%s}}'     , sum(numEntities) FILTER (WHERE sf = 300)) AS sf300_num_entities,
                printf('\\numprint{{%s}}'     , sum(numEntities) FILTER (WHERE sf = 1000)) AS sf1000_num_entities,
                printf('\\numprint{{%s}}'     , sum(numEntities) FILTER (WHERE sf = 3000)) AS sf3000_num_entities,
                printf('\\numprint{{%s}}'     , sum(numEntities) FILTER (WHERE sf = 10000)) AS sf10000_num_entities,
                printf('\\numprint{{%s}} \\\\', sum(numEntities) FILTER (WHERE sf = 30000)) AS sf30000_num_entities,
            FROM sum_stats
            WHERE NOT regexp_matches(file, '.*_.*')
        UNION ALL
            SELECT
                'edges',
                printf('\\numprint{{%s}}'     , sum(numEntities) FILTER (WHERE sf = 1)) AS sf1_num_entities,
                printf('\\numprint{{%s}}'     , sum(numEntities) FILTER (WHERE sf = 3)) AS sf3_num_entities,
                printf('\\numprint{{%s}}'     , sum(numEntities) FILTER (WHERE sf = 10)) AS sf10_num_entities,
                printf('\\numprint{{%s}}'     , sum(numEntities) FILTER (WHERE sf = 30)) AS sf30_num_entities,
                printf('\\numprint{{%s}}'     , sum(numEntities) FILTER (WHERE sf = 100)) AS sf100_num_entities,
                printf('\\numprint{{%s}}'     , sum(numEntities) FILTER (WHERE sf = 300)) AS sf300_num_entities,
                printf('\\numprint{{%s}}'     , sum(numEntities) FILTER (WHERE sf = 1000)) AS sf1000_num_entities,
                printf('\\numprint{{%s}}'     , sum(numEntities) FILTER (WHERE sf = 3000)) AS sf3000_num_entities,
                printf('\\numprint{{%s}}'     , sum(numEntities) FILTER (WHERE sf = 10000)) AS sf10000_num_entities,
                printf('\\numprint{{%s}} \\\\', sum(numEntities) FILTER (WHERE sf = 30000)) AS sf30000_num_entities,
            FROM sum_stats
            WHERE regexp_matches(file, '.*_.*')
        ) TO 'num_entities.csv' (HEADER, DELIMITER ',');
        """)
