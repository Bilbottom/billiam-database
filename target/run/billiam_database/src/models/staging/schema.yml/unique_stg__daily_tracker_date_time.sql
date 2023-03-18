select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

select
    date_time as unique_field,
    count(*) as n_records

from "billiam"."staging"."daily_tracker"
where date_time is not null
group by date_time
having count(*) > 1



      
    ) dbt_internal_test