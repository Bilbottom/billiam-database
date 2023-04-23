dbt clean
dbt deps
dbt source freshness
#dbt seed
dbt run --full-refresh
dbt test --store-failures
dbt docs generate
dbt docs serve
