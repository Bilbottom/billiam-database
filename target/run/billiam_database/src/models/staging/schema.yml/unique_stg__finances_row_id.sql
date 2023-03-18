select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

select
    row_id as unique_field,
    count(*) as n_records

from "billiam"."staging"."finances"
where row_id is not null
group by row_id
having count(*) > 1



      
    ) dbt_internal_test