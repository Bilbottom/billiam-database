# We use a number of environment variables to configure dbt:
#   GITHUB_WORKSPACE: The root of the repository
#   DBT_PROJECT_DIR: The directory containing the dbt_project.yml file
#   DBT_PROFILES_DIR: The directory containing the profiles.yml file
source .env

dbt clean
dbt deps

# TODO: The counterparty seed is causing a top-level packages directory to be created. Stop this from happening
#dbt source freshness
#dbt run --full-refresh
#dbt test --store-failures

dbt build --full-refresh

dbt docs generate
dbt docs serve --port=8085
