select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select category
from "billiam"."staging"."finances"
where category is null



      
    ) dbt_internal_test