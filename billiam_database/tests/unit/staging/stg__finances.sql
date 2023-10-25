{{ config(tags=["unit-test"]) }}


{% call dbt_unit_testing.test(
    "stg__finances",
    "Strings are trimmed and nulls are replaced with empty strings."
) %}
  {% call dbt_unit_testing.mock_source("raw", "finances") %}
    "Transaction" | "Date"       | Item       | Cost       | Category   | Retailer  | "Payment Method" | Exclusion | "Repayment Identifier" | "Reimbursement Transaction" | "Expenditure Identifier" | "Regular Spending" | "Small Transaction" | "Week Ending" | Month        | "Pay Date"   | "Overall Category" | "Item Roundup" | "Transaction Roundup"
    1             | '2018-01-18' | 'Cheese  ' | '£5.24'    | '   Food ' | 'Tesco  ' | 'Santander'      | 0         | null                   | null                        | 'Expenditure'            | 0                  | 1                   | '20/01/2018'  | '01/01/2018' | '00/01/1900' | 'Food        '     | 9.04           | 8.44
    1             | '2018-01-18' | 'Chillies' | '£0.90'    | '   Food ' | 'Tesco  ' | 'Santander'      | 0         | null                   | null                        | 'Expenditure'            | 0                  | 1                   | '20/01/2018'  | '01/01/2018' | '00/01/1900' | 'Food        '     |  1.4           | 8.44
    1             | '2018-01-18' | 'Lettuce ' | '£1000.50' | 'Food '    | 'Tesco  ' | 'Santander'      | 0         | null                   | null                        | 'Expenditure'            | 0                  | 1                   | '20/01/2018'  | '01/01/2018' | '00/01/1900' | 'Food        '     |    3           | 8.44
    2             | '2018-01-18' | 'Internet' | '-£10.00'  | ' Bills'   | 'Someone' | 'Cash     '      | 1         | null                   | null                        | 'Income     '            | 0                  | 1                   | '20/01/2018'  | '01/01/2018' | '00/01/1900' | 'Living Costs'     |    0           | 0
  {% endcall %}

  {% call dbt_unit_testing.expect() %}
    row_id | transaction_id | transaction_date | item       | cost    | category | counterparty | payment_method | exclusion_flag | reimbursement_transaction_id
    1      | 1              | '2018-01-18'     | 'Cheese'   | 5.24    | 'Food'   | 'Tesco'      | 'Santander'    | false          | null
    2      | 1              | '2018-01-18'     | 'Chillies' | 0.90    | 'Food'   | 'Tesco'      | 'Santander'    | false          | null
    3      | 1              | '2018-01-18'     | 'Lettuce'  | 1000.50 | 'Food'   | 'Tesco'      | 'Santander'    | false          | null
    4      | 2              | '2018-01-18'     | 'Internet' | -10.00  | 'Bills'  | 'Someone'    | 'Cash'         | true           | null
  {% endcall %}
{% endcall %}
