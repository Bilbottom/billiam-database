select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select task
from "billiam"."staging"."daily_tracker"
where task is null



      
    ) dbt_internal_test