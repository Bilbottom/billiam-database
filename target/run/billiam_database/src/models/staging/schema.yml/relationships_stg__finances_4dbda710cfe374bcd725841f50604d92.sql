select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

with child as (
    select reimbursement_transaction_id as from_field
    from (select * from "billiam"."staging"."finances" where reimbursement_transaction_id IS NOT NULL) dbt_subquery
    where reimbursement_transaction_id is not null
),

parent as (
    select transaction_id as to_field
    from "billiam"."staging"."finances"
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null



      
    ) dbt_internal_test