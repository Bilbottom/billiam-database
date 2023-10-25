{{ config(
    alias="daily_tracker",
    tags=["daily-tracker"]
) }}


{{ import(
    src_tracker = source("raw", "daily_tracker"),

    expand_columns=false
) }}

final AS (
    -- noqa: disable=ST06
    SELECT
        date_time::TIMESTAMP AS date_time,
        TRIM("task") AS "task",
        COALESCE(TRIM(detail), '') AS detail,
        "interval"::INTEGER AS "interval",
        TRIM(company) AS company
    FROM src_tracker
    -- noqa: enable=ST06
)

SELECT * FROM final
