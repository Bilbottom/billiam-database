
    
    

with all_values as (

    select
        company as value_field,
        count(*) as n_records

    from "billiam"."staging"."daily_tracker"
    group by company

)

select *
from all_values
where value_field not in (
    'TSB','Jaja','Allica','Sainsbury''s'
)


