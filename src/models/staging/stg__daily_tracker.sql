{{
    config(
        alias="daily_tracker",
        tags=["daily-tracker"]
    )
}}

{{ import(
    src_tracker = source("raw", "daily_tracker")
) }}

final AS (
    SELECT
        date_time::TIMESTAMP AS date_time,
        TRIM(task) AS task,
        COALESCE(TRIM(detail), '') AS detail,
        interval::INTEGER AS interval,
        TRIM(company) AS company
    FROM src_tracker
)

SELECT * FROM final
