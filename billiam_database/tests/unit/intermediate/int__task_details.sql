{% call dbt_unit_testing.test(
    "int__task_details",
    "Items are aggregated over two grains."
) %}
  {% call dbt_unit_testing.mock_ref("stg__daily_tracker") %}
    date_time             | task       | detail   | interval | company
    '2019-04-23 08:15:00' | 'BAU Task' | 'Task 1' | 15       | 'TSB'
    '2019-04-23 08:30:00' | 'BAU Task' | 'Task 2' | 15       | 'Jaja'
    '2019-04-23 08:45:00' | 'BAU Task' | 'Task 3' | 15       | 'Allica'
    '2019-04-23 09:05:00' | 'BAU Task' | 'Task 4' | 15       | 'Sainsbury''s'
  {% endcall %}

  {% call dbt_unit_testing.expect() %}
    group_id | group_description | task       | detail   | total_records | total_time | start_time            | end_time
    0        | 'Task and detail' | 'BAU Task' | 'Task 1' | 1             | 15         | '2019-04-23 08:15:00' | '2019-04-23 08:15:00'
    0        | 'Task and detail' | 'BAU Task' | 'Task 2' | 1             | 15         | '2019-04-23 08:30:00' | '2019-04-23 08:30:00'
    0        | 'Task and detail' | 'BAU Task' | 'Task 3' | 1             | 15         | '2019-04-23 08:45:00' | '2019-04-23 08:45:00'
    0        | 'Task and detail' | 'BAU Task' | 'Task 4' | 1             | 15         | '2019-04-23 09:05:00' | '2019-04-23 09:05:00'
    1        | 'Task only'       | 'BAU Task' | null     | 4             | 60         | '2019-04-23 08:15:00' | '2019-04-23 09:05:00'
  {% endcall %}
{% endcall %}
