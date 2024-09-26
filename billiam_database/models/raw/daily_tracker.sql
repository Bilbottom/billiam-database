model (
    name raw.daily_tracker,
    kind full,
    grain (date_time),
    tags (daily-tracker),
    columns (
        date_time timestamp,
        project varchar,
        detail varchar,
        minutes int,
    ),
    audits (
      not_null(columns=[
        date_time,
        project,
        detail,
        minutes,
      ]),
      unique_values(columns=[date_time]),
    ),
);


select
    date_time::timestamp as date_time,
    trim("task") as project,
    coalesce(trim(detail), '') as detail,
    "interval"::int as minutes,
from 'billiam_database/models/raw/data/daily_tracker.csv'
