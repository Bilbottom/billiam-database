{{ config(enabled=false) }}
{# Not sure how to mock the date axis for this #}

{% call dbt_unit_testing.test(
    "pl__daily_metrics",
    "The date axis should be generated."
) %}
  {% call dbt_unit_testing.mock_ref("int__transaction_items") %}
    row_id | transaction_date | transaction_id | item     | cost | category | counterparty | exclusion_flag
    1      | '2018-01-01'     | 1              | 'Item 1' | 2.99 | 'Food'   | 'Tesco'      | false
    2      | '2018-01-01'     | 1              | 'Item 2' | 3.99 | 'Rent'   | 'Landlord'   | false
    3      | '2018-01-02'     | 2              | 'Item 3' | 4.99 | 'Food'   | 'Tesco'      | false
    4      | '2018-01-03'     | 3              | 'Item 4' | 5.99 | 'Food'   | 'Tesco'      | true
    5      | '2018-01-04'     | 4              | 'Item 5' | 6.99 | 'Rent'   | 'Landlord'   | false
  {% endcall %}

  {% call dbt_unit_testing.mock_ref("stg__daily_tracker") %}
    date_time             | project    | detail   | minutes | company
    '2018-01-01 08:15:00' | 'Meetings' | 'Task 1' | 15      | 'TSB'
    '2018-01-01 08:30:00' | 'BAU Task' | 'Task 2' | 15      | 'Jaja'
    '2018-01-02 08:45:00' | 'BAU Task' | 'Task 3' | 15      | 'Allica'
    '2018-01-04 09:05:00' | 'Catch Up' | 'Task 4' | 15      | 'Sainsbury''s'
  {% endcall %}

  {% call dbt_unit_testing.expect() %}
    metric_date  | total_cost | non_essential_cost | non_essential_cost_proportion | total_working_time | meeting_time | meeting_proportion | working_day_meeting_proportion
    '2018-01-01' | 6.98       | 2.99               | 42.8367                       | 30                 | 15           |  50.0              |  50.0
    '2018-01-02' | 4.99       | 4.99               | 100.0                         | 15                 | null         |  null              |  null
    '2018-01-04' | 6.99       | null               | 100.0                         | 15                 | 15           | 100.0              | 100.0
  {% endcall %}
{% endcall %}
