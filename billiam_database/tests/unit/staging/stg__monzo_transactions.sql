{% call dbt_unit_testing.test(
    "stg__monzo_transactions",
    "Strings are trimmed and nulls are replaced with empty strings."
) %}
  {% call dbt_unit_testing.mock_source("raw", "monzo_transactions") %}
    "Transaction ID"            | "Date"       | "Time"     | "Type"       | "Name"    | "Emoji" | "Category" | "Amount" | "Currency" | "Local amount" | "Local currency" | "Notes and #tags" | "Address" | "Receipt" | "Description" | "Category split"
    'tx_0123456789abcdefghijkl' | '2019-07-19' | '18:29:44' | 'Payment'    | 'Billiam' | null    | 'Home'     | 10.00    | 'GBP'      | 10.00          | 'GBP'            | 'MONZO'           | null      | null      | 'MONZO'       | null
    'tx_0123456789mnopqrstuvwx' | '2019-07-20' | '13:37:41' | 'Withdrawal' | 'Cortana' | null    | 'General'  | 100.00   | 'GBP'      | 100.00         | 'GBP'            | 'Monzo'           | null      | null      | 'Monzo'       | null
    'tx_0123456789yzABCDEFGHIJ' | '2019-07-20' | '13:45:40' | 'Something'  | 'Gandalf' | null    | 'Transfer' | 1000.00  | 'GBP'      | 1000.00        | 'GBP'            | 'Monzo'           | null      | null      | 'Monzo'       | null
  {% endcall %}

  {% call dbt_unit_testing.expect() %}
    transaction_id              | transaction_date | transaction_time | type         | counterparty | emoji | category   | cost     | currency | local_cost | local_currency | notes   | address | receipt | description | category_split
    'tx_0123456789abcdefghijkl' | '2019-07-19'     | '18:29:44'       | 'Payment'    | 'Billiam'    | null  | 'Home'     | -10.00   | 'GBP'    | -10.00     | 'GBP'          | 'MONZO' | null    | null    | 'MONZO'     | null
    'tx_0123456789mnopqrstuvwx' | '2019-07-20'     | '13:37:41'       | 'Withdrawal' | 'Cortana'    | null  | 'General'  | -100.00  | 'GBP'    | -100.00    | 'GBP'          | 'Monzo' | null    | null    | 'Monzo'     | null
    'tx_0123456789yzABCDEFGHIJ' | '2019-07-20'     | '13:45:40'       | 'Something'  | 'Gandalf'    | null  | 'Transfer' | -1000.00 | 'GBP'    | -1000.00   | 'GBP'          | 'Monzo' | null    | null    | 'Monzo'     | null
  {% endcall %}
{% endcall %}
