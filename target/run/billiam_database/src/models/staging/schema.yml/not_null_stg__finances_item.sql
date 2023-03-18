select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select item
from "billiam"."staging"."finances"
where item is null



      
    ) dbt_internal_test