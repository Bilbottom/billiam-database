select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select cost
from "billiam"."staging"."finances"
where cost is null



      
    ) dbt_internal_test