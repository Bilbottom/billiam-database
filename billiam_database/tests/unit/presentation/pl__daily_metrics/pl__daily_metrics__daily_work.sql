{% call dbt_unit_testing.test(
    "pl__daily_metrics",
    "The date axis should be generated.",
    {"cte_name": "daily_work"}
) %}
  {% call dbt_unit_testing.mock_ref("stg__daily_tracker") %}
    date_time             | task       | detail   | interval | company
    '2019-04-23 08:15:00' | 'Meetings' | 'Task 1' | 15       | 'TSB'
    '2019-04-23 08:30:00' | 'BAU Task' | 'Task 2' | 15       | 'Jaja'
    '2019-04-24 08:45:00' | 'BAU Task' | 'Task 3' | 15       | 'Allica'
    '2019-04-25 09:05:00' | 'Catch Up' | 'Task 4' | 15       | 'Sainsbury''s'
  {% endcall %}

  {% call dbt_unit_testing.expect() %}
    metric_date  | total_working_time | meeting_time | meeting_proportion | working_day_meeting_proportion
    '2019-04-23' | 30                 | 15           |  50.0              |  50.0
    '2019-04-24' | 15                 | null         |  null              |  null
    '2019-04-25' | 15                 | 15           | 100.0              | 100.0
  {% endcall %}
{% endcall %}
