select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select row_id
from "billiam"."staging"."finances"
where row_id is null



      
    ) dbt_internal_test