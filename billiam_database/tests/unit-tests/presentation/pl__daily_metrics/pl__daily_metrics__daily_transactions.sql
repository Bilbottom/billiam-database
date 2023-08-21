{{ config(tags=["unit-test"]) }}


{% call dbt_unit_testing.test(
    "pl__daily_metrics",
    "The date axis should be generated.",
    {"cte_name": "daily_transactions"}
) %}
  {% call dbt_unit_testing.mock_ref("int__transaction_items", {"input_format": "csv"}) %}
    row_id,transaction_date,transaction_id,item,cost,category,counterparty,exclusion_flag
    1,'2018-01-01',1,'Item 1',2.99,'Food','Tesco',false
    2,'2018-01-01',1,'Item 2',3.99,'Rent','Landlord',false
    3,'2018-01-02',2,'Item 3',4.99,'Food','Tesco',false
    4,'2018-01-03',3,'Item 4',5.99,'Food','Tesco',true
    5,'2018-01-04',4,'Item 5',6.99,'Rent','Landlord',false
  {% endcall %}

  {% call dbt_unit_testing.expect({"input_format": "csv"}) %}
    metric_date,total_cost,non_essential_cost,non_essential_cost_proportion
    '2018-01-01',6.98,2.99,42.8367
    '2018-01-02',4.99,4.99,100.0
    '2018-01-04',6.99,NULL,100.0
  {% endcall %}
{% endcall %}
