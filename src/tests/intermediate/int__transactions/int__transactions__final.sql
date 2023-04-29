{{ config(tags=["unit-test"]) }}

 -- depends_on: {{ ref("stg__finances") }}


{% call dbt_unit_testing.test(
    "int__transactions",
    "Items should roll up into transactions (the usual type of test case)"
) %}
  {% call dbt_unit_testing.mock_ref("stg__finances", {"input_format": "csv"}) %}
    row_id,transaction_id,transaction_date,item,cost,category,counterparty,payment_method,exclusion_flag,reimbursement_transaction_id
    1,1,'2020-01-01','Item 1',2.99,'Food','Tesco',null,null,null
    2,1,'2020-01-01','Item 2',3.99,'Food','Tesco',null,null,null
  {% endcall %}

  {% call dbt_unit_testing.expect({"input_format": "csv"}) %}
    transaction_id,transaction_date,cost,item_count,counterparty
    1,'2020-01-01',6.98,2,'Tesco'
  {% endcall %}
{% endcall %}
