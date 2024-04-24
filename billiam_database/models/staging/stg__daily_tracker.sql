{{ config(
    alias="daily_tracker",
    tags=["daily-tracker"]
) }}


{{ import(
    src_tracker = source("raw", "daily_tracker"),

    expand_columns=false
) }}

final as (
    select
        date_time::timestamp as date_time,
        trim("task") as project,
        coalesce(trim(detail), '') as detail,
        "interval"::integer as minutes,
        trim(company) as company
    from src_tracker
)

select * from final
