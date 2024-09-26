sqlmesh -p billiam_database info
sqlmesh -p billiam_database janitor
sqlmesh -p billiam_database migrate
sqlmesh -p billiam_database test

sqlmesh -p billiam_database plan
sqlmesh -p billiam_database run
sqlmesh -p billiam_database audit

sqlmesh -p billiam_database ui
