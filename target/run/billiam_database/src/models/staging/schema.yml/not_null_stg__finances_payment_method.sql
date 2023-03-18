select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select payment_method
from "billiam"."staging"."finances"
where payment_method is null



      
    ) dbt_internal_test