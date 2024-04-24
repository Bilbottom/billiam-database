{{ config(
    alias="daily_tracker",
    tags=["daily-tracker"]
) }}


{{ import(
    src_tracker = source("raw", "daily_tracker"),

    expand_columns=false
) }}

final as (
    -- noqa: disable=ST06
    select
        date_time::timestamp as date_time,
        trim("task") as project,
        coalesce(trim(detail), '') as detail,
        "interval"::integer as minutes,
        trim(company) as company
    from src_tracker
    -- noqa: enable=ST06
)

select * from final
