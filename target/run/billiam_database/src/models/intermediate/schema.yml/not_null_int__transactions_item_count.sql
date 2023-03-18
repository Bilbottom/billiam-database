select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select item_count
from "billiam"."intermediate"."transactions"
where item_count is null



      
    ) dbt_internal_test