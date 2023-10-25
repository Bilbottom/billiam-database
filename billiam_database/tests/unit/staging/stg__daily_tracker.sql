{{ config(tags=["unit-test"]) }}


{% call dbt_unit_testing.test(
    "stg__daily_tracker",
    "Strings are trimmed and nulls are replaced with empty strings."
) %}
  {% call dbt_unit_testing.mock_source("raw", "daily_tracker") %}
    date_time             | task            | detail                            | interval | company
    '2019-04-23 08:15:00' | 'BAU Task     ' | 'Running Unsecured Master Code  ' | 15       | 'TSB'
    '2019-04-23 08:30:00' | 'Adhoc Task   ' | 'Working on this workbook       ' | 15       | 'TSB'
    '2019-04-23 08:45:00' | 'Documentation' | 'Weekly Wellness Procedure Guide' | 15       | 'TSB'
    '2019-04-23 09:05:00' | null            | 'Weekly Wellness                ' | 15       | 'TSB'
  {% endcall %}

  {% call dbt_unit_testing.expect() %}
    date_time             | task            | detail                            | interval | company
    '2019-04-23 08:15:00' | 'BAU Task'      | 'Running Unsecured Master Code'   | 15       | 'TSB'
    '2019-04-23 08:30:00' | 'Adhoc Task'    | 'Working on this workbook'        | 15       | 'TSB'
    '2019-04-23 08:45:00' | 'Documentation' | 'Weekly Wellness Procedure Guide' | 15       | 'TSB'
    '2019-04-23 09:05:00' | null            | 'Weekly Wellness'                 | 15       | 'TSB'
  {% endcall %}
{% endcall %}
