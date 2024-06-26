{{ config(alias="task_details") }}


{{ import(
    src_tracker = ref("stg__daily_tracker")
) }}

final as (
    select
        grouping_id(project, detail)::integer as group_id,
        case grouping_id(project, detail)
            when 0 then 'Task and detail'
            when 1 then 'Task only'
        end as group_description,
        project,
        coalesce(detail, '') as detail,

        count(*)::integer as total_records,
        sum(minutes)::integer as total_time,
        min(date_time) as start_time,
        max(date_time) as end_time,
    from src_tracker
    -- noqa: disable=RF06, PRS
    -- SQLFluff thinks that `GROUPING SETS` is a column name?!
    group by grouping sets (
        (project, detail),
        (project)
    )
    -- noqa: enable=RF06, PRS
)

select * from final
