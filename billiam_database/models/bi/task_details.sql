model (
    name bi.task_details,
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
);


select
    grouping_id(project, detail)::int as group_id,
    case grouping_id(project, detail)
        when 0 then 'Task and detail'
        when 1 then 'Task only'
    end as group_description,
    project,
    coalesce(detail, '') as detail,

    count(*)::int as total_records,
    sum(minutes)::int as total_time,
    min(log_ts) as start_time,
    max(log_ts) as end_time,
from career.daily_tracker
group by grouping sets (
    (project, detail),
    (project)
);
