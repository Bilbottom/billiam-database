source .env  # For GITHUB_WORKSPACE, DBT_PROFILES_DIR, and DBT_PROJECT_DIR

dbt clean
dbt deps
dbt source freshness

#dbt run --full-refresh
#dbt test --store-failures

#dbt build --full-refresh

dbt docs generate
dbt docs serve --port=8085
