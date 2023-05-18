import duckdb

# This script assumes that the raw data set for scale factor 'sf' is stored in
# the bi-sf{sf}-raw directory

con = duckdb.connect()

for entity in ["static/Organisation", "static/Place", "static/Tag", "static/TagClass", "dynamic/Comment", "dynamic/Comment_hasTag_Tag", "dynamic/Forum", "dynamic/Forum_hasMember_Person", "dynamic/Forum_hasTag_Tag", "dynamic/Person", "dynamic/Person_hasInterest_Tag", "dynamic/Person_knows_Person", "dynamic/Person_likes_Comment", "dynamic/Person_likes_Post", "dynamic/Person_studyAt_University", "dynamic/Person_workAt_Company", "dynamic/Post", "dynamic/Post_hasTag_Tag"]:
    print(entity.replace("_", "\_"), end=" ")
    for sf in [1, 3, 10, 30, 100, 300, 1000, 3000, 10000, 30000]:
        con.execute(f"select count(*) from read_parquet('bi-sf{sf}-raw/graphs/parquet/raw/composite-merged-fk/{entity}/*.parquet')")
        result = con.fetchone()
        print(f"& \\numprint{{{result[0]}}} ", end="")
    
    print("\\\\")
