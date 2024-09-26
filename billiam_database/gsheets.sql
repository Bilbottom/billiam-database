/* Only seems to work with DuckDB v1.1.3 */

/* https://github.com/evidence-dev/duckdb_gsheets */
install gsheets from community;
load gsheets;

-- Authenticate with Google Account in the browser
create secret (type gsheet);
