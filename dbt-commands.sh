# We use a number of environment variables to configure dbt:
#   GITHUB_WORKSPACE: The root of the repository
#   DBT_PROJECT_DIR: The directory containing the dbt_project.yml file
#   DBT_PROFILES_DIR: The directory containing the profiles.yml file
#
# These should be configured in a .env file so that the dotenv CLI can
# load them

# dotenv set GITHUB_WORKSPACE ...
# dotenv set DBT_PROJECT_DIR ...
# dotenv set DBT_PROFILES_DIR ...

dotenv run -- dbt debug
dotenv run -- dbt clean
dotenv run -- dbt deps

# TODO: A top-level `dbt_packages` directory is being created. Stop this from happening
dotenv run -- dbt source freshness
dotenv run -- dbt build --full-refresh
dotenv run -- dbt test --select tag:unit-test

dotenv run -- dbt docs generate
dotenv run -- dbt docs serve --port=8085

dotenv run -- dbt-unit-test-coverage
