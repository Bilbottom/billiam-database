model (
    name presentation.task_details,
    kind full,
    grain (group_id, project, detail),
    columns (
        group_id int,
        group_description varchar,
        project varchar,
        detail varchar,
        total_records int,
        total_time int,
        start_time timestamp,
        end_time timestamp,
    ),
    audits (
      not_null(columns=[
        group_id,
        group_description,
        project,
        detail,
        total_records,
        total_time,
        start_time,
        end_time,
      ]),
      unique_combination_of_columns(columns=[
        group_id,
        project,
        detail,
      ]),
    ),
);


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
from raw.daily_tracker
-- noqa: disable=RF06, PRS
-- SQLFluff thinks that `GROUPING SETS` is a column name?!
group by grouping sets (
    (project, detail),
    (project)
)
-- noqa: enable=RF06, PRS
