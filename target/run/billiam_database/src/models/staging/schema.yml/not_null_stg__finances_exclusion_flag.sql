select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select exclusion_flag
from "billiam"."staging"."finances"
where exclusion_flag is null



      
    ) dbt_internal_test