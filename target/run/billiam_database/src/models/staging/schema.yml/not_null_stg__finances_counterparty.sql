select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select counterparty
from "billiam"."staging"."finances"
where counterparty is null



      
    ) dbt_internal_test