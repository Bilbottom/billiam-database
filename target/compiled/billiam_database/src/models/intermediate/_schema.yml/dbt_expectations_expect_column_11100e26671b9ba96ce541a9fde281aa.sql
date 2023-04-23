




    with grouped_expression as (
    select
        
        
    
  
counterparty not like '%||%'
 as expression


    from "billiam"."intermediate"."transactions"
    

),
validation_errors as (

    select
        *
    from
        grouped_expression
    where
        not(expression = true)

)

select *
from validation_errors




