Presentation Objects
---

The presentations objects are the third and final "layer" of the warehouse and are where the objects for analytics and reporting are kept.

The dbt documentation calls these "marts" what are the "business-defined entities":
- https://docs.getdbt.com/guides/best-practices/how-we-structure/4-marts

The presentation layer typically has objects that are wide and heavily denormalised.

---
## [pl__daily_metrics](pl__daily_metrics.sql)
{% docs pl__daily_metrics %}

Daily metrics across both sources.

There is a row for each day from 2018-01-01 to the current day.

{% enddocs %}

---
## [pl__task_details](pl__task_details.sql)
{% docs pl__task_details %}

Rolled-up aggregates for the tasks and their details.

This table has rows at 2 grains:
- Task level
- Detail level (per task)

The grains are identified by the `group_id` (and the corresponding `group_description`) columns.

{% enddocs %}
