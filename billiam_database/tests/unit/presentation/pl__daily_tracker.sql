{% call dbt_unit_testing.test(
    "pl__daily_tracker",
    "The stage object is copied exactly."
) %}
  {% call dbt_unit_testing.mock_ref("stg__daily_tracker") %}
    date_time             | task            | detail                            | interval | company
    '2019-04-23 08:15:00' | 'BAU Task'      | 'Running Unsecured Master Code'   | 15       | 'TSB'
    '2019-04-23 08:30:00' | 'Adhoc Task'    | 'Working on this workbook'        | 15       | 'TSB'
    '2019-04-23 08:45:00' | 'Documentation' | 'Weekly Wellness Procedure Guide' | 15       | 'TSB'
    '2019-04-23 09:00:00' | 'Something'     | 'Weekly Wellness'                 | 15       | 'TSB'
  {% endcall %}

  {% call dbt_unit_testing.expect() %}
    date_time             | task            | detail                            | interval | company
    '2019-04-23 08:15:00' | 'BAU Task'      | 'Running Unsecured Master Code'   | 15       | 'TSB'
    '2019-04-23 08:30:00' | 'Adhoc Task'    | 'Working on this workbook'        | 15       | 'TSB'
    '2019-04-23 08:45:00' | 'Documentation' | 'Weekly Wellness Procedure Guide' | 15       | 'TSB'
    '2019-04-23 09:00:00' | 'Something'     | 'Weekly Wellness'                 | 15       | 'TSB'
  {% endcall %}
{% endcall %}
