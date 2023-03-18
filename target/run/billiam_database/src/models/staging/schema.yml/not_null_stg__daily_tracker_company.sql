select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select company
from "billiam"."staging"."daily_tracker"
where company is null



      
    ) dbt_internal_test