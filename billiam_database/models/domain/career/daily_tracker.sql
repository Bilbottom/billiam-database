model (
    name career.daily_tracker,
    kind full,
    grain (log_ts),
    columns (
        log_ts timestamp,
        project varchar,
        detail varchar,
        minutes int,
    ),
);


select
    log_ts,
    project,
    detail,
    minutes,
from raw.daily_tracker
;
