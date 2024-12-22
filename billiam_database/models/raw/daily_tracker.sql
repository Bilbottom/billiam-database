model (
    name raw.daily_tracker,
    kind full,
    grain (log_ts),
    tags (daily-tracker),
    columns (
        log_ts timestamp,
        project varchar,
        detail varchar,
        minutes int,
    ),
    audits (
      not_null(columns=[
        log_ts,
        project,
        detail,
        minutes,
      ]),
      unique_values(columns=[log_ts]),
    ),
);


select
    date_time::timestamp as log_ts,
    trim(task) as project,
    coalesce(trim(detail), '') as detail,
    "interval"::int as minutes,
from 'billiam_database/models/raw/data/daily_tracker.csv'
;
