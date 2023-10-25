{{ config(tags=["unit-test"]) }}


{% call dbt_unit_testing.test(
    "int__transaction_items",
    "Only items whose transactions haven't been excluded should remain."
) %}
  {% call dbt_unit_testing.mock_ref("stg__finances") %}
    row_id | transaction_id | transaction_date | item     | cost | category | counterparty | payment_method | exclusion_flag | reimbursement_transaction_id
    1      | 1              | '2020-01-01'     | 'Item 1' | 2.99 | 'Food'   | 'Tesco'      | null           | null           | null
    2      | 1              | '2020-01-01'     | 'Item 2' | 3.99 | 'Food'   | 'Tesco'      | null           | null           | null
  {% endcall %}

  {% call dbt_unit_testing.mock_ref("int__transactions") %}
    transaction_id | transaction_date | cost | item_count | counterparty
    1              | '2020-01-01'     | 6.98 | 2          | 'Tesco'
  {% endcall %}

  {% call dbt_unit_testing.expect() %}
    row_id | transaction_date | transaction_id | item     | cost | category | counterparty | exclusion_flag
    1      | '2020-01-01'     | 1              | 'Item 1' | 2.99 | 'Food'   | 'Tesco'      | null
    2      | '2020-01-01'     | 1              | 'Item 2' | 3.99 | 'Food'   | 'Tesco'      | null
  {% endcall %}
{% endcall %}
