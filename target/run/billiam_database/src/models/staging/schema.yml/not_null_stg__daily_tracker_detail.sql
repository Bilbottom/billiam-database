select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select detail
from "billiam"."staging"."daily_tracker"
where detail is null



      
    ) dbt_internal_test