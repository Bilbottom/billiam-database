# Presentation Objects

The presentations objects are the third and final "layer" of the warehouse and are where the objects for analytics and reporting are kept.

The dbt documentation calls these "marts" what are the "business-defined entities":

- https://docs.getdbt.com/guides/best-practices/how-we-structure/4-marts

The presentation layer typically has objects that are wide and heavily denormalised.

---

## [pl\_\_daily_metrics](pl__daily_metrics.sql)

{% docs pl__daily_metrics %}

Daily metrics across both sources.

There is a row for each day from 2018-01-01 to the current day.

{% enddocs %}

---

## [pl\_\_daily_tracker](pl__daily_tracker.sql)

{% docs pl__daily_tracker %}

Work tracker history from 2019-04-23.

The source of this model is my "automated" timesheet application, available at:

- https://github.com/Bilbottom/daily-tracker

Each row corresponds to an interval of work, which has a timestamp, details about the work, and the duration of the interval.

{% enddocs %}

---

## [pl\_\_task_details](pl__task_details.sql)

{% docs pl__task_details %}

Rolled-up aggregates for the tasks and their details.

This table has rows at 2 grains:

- Task level
- Detail level (per task)

The grains are identified by the `group_id` (and the corresponding `group_description`) columns.

{% enddocs %}
