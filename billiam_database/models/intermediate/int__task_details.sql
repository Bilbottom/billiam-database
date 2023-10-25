{{ config(alias="task_details") }}


-- noqa: disable=PRS
-- The `interval` column in `stg__daily_tracker` can't be parsed
{{ import(
    src_tracker = ref("stg__daily_tracker")
) }}
-- noqa: enable=PRS

final as (
    -- noqa: disable=ST06
    select
        grouping_id("task", detail) as group_id,
        case grouping_id("task", detail)
            when 0 then 'Task and detail'
            when 1 then 'Task only'
        end as group_description,
        "task",
        detail,

        count(*) as total_records,
        sum("interval") as total_time,
        min(date_time) as start_time,
        max(date_time) as end_time,
    from src_tracker
    -- noqa: disable=CP02, RF06, PRS
    -- SQLFluff thinks that `GROUPING SETS` is a column name?!
    group by grouping sets (
        ("task", detail),
        ("task")
    )
    -- noqa: enable=CP02, RF06, PRS
)

select * from final
