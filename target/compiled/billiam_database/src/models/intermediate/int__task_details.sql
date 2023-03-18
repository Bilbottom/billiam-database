


WITH

src_tracker AS (
    SELECT *
    FROM "billiam"."staging"."daily_tracker"
),

final AS (
    SELECT
        GROUPING_ID(task, detail) AS group_id,
        CASE GROUPING_ID(task, detail)
            WHEN 0 THEN 'Task and detail'
            WHEN 1 THEN 'Task only'
        END AS group_description,
        task,
        detail,
        COUNT(*) AS total_records,
        SUM(interval) AS total_time,
        MIN(date_time) AS start_time,
        MAX(date_time) AS end_time
    FROM src_tracker
    GROUP BY GROUPING SETS (
        (task, detail),
        (task)
    )
)

SELECT * FROM final