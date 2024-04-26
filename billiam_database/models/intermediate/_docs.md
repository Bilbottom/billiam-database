# Intermediate Objects

The intermediate objects are the second "layer" of the warehouse and are where the transformations, aggregations, and core business logic are applied.

The dbt documentation calls these the "purpose-built transformation steps":

- https://docs.getdbt.com/guides/best-practices/how-we-structure/3-intermediate

The intermediate layer can get quite large, so it's important to keep it organised. The dbt documentation recommends using sub-folders to organise the models, and using the [`dbt_project.yml`](../../dbt_project.yml) configurations for folder-level settings.
