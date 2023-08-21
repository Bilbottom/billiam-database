#!/usr/bin/env bash
source .env  # For GITHUB_WORKSPACE

dbt clean
dbt deps
dbt source freshness

#dbt seed
#dbt run --full-refresh
#dbt test --store-failures

#dbt build --full-refresh

dbt docs generate
dbt docs serve --port=8085
