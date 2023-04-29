dbt clean
dbt deps
dbt source freshness
#dbt seed
#dbt run --full-refresh --target dev
#dbt test --store-failures
dbt build --full-refresh

dbt docs generate
dbt docs serve
