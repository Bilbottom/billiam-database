# Intermediate Objects

The intermediate objects are the second "layer" of the warehouse and are where the transformations, aggregations, and core business logic are applied.

The dbt documentation calls these the "purpose-built transformation steps":

- https://docs.getdbt.com/guides/best-practices/how-we-structure/3-intermediate

The intermediate layer can get quite large, so it's important to keep it organised. The dbt documentation recommends using sub-folders to organise the models, and using the [`dbt_project.yml`](../../dbt_project.yml) configurations for folder-level settings.

---

## [int\_\_transaction_items](int__transaction_items.sql)

{% docs int__transaction_items %}

The items corresponding to each of the transactions.

Note that these are only items that have corresponding transactions in `int__transactions`. Most tests can be omitted since they are tested in
the staging layer.

This may be decommissioned in the future as it's not really doing much.

{% enddocs %}

---

## [int\_\_transactions](int__transactions.sql)

{% docs int__transactions %}

The transactions and their core measures.

Note that these are only transactions that cause some net movement in my overall balances -- for example, paying off a credit card is being considered as not changing my net balance, and has been excluded.

{% enddocs %}
