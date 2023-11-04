{% call dbt_unit_testing.test(
    "pl__task_details",
    "The presentation object is a copy-and-paste from the intermediate object."
) %}
  {% call dbt_unit_testing.mock_ref("int__task_details") %}
    group_id | group_description | task          | detail   | total_records | total_time | start_time            | end_time
    0        | 'Task and detail' | 'BAU Task'    | 'Task 1' | 1             | 15         | '2019-04-23 08:15:00' | '2019-04-23 08:15:00'
    0        | 'Task and detail' | 'BAU Task'    | 'Task 2' | 1             | 15         | '2019-04-23 08:30:00' | '2019-04-23 08:30:00'
    0        | 'Task and detail' | 'BAU Task'    | 'Task 3' | 1             | 15         | '2019-04-23 08:45:00' | '2019-04-23 08:45:00'
    0        | 'Task and detail' | 'BAU Task'    | 'Task 4' | 1             | 15         | '2019-04-23 09:05:00' | '2019-04-23 09:05:00'
    1        | 'Task only'       | 'BAU Task'    | null     | 4             | 60         | '2019-04-23 08:15:00' | '2019-04-23 09:05:00'
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
