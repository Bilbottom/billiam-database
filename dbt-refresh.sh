dbt clean
proxy_off
dbt deps
proxy_on
dbt source freshness
#dbt seed
#dbt run --full-refresh
#dbt test --store-failures
dbt build --full-refresh

dbt docs generate
dbt docs serve --port=8085
