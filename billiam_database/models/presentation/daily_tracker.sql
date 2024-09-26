model (
    name presentation.daily_tracker,
    kind full,
    grain (date_time),
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
    date_time,
    project,
    detail,
    minutes,
from raw.daily_tracker
