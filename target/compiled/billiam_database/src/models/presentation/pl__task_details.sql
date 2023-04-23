


WITH

src_task_details AS (
    SELECT *
    FROM "billiam"."intermediate"."task_details"
),

final AS (
    SELECT
        group_id,
        group_description,
        task,
        detail,
        total_records,
        total_time,
        start_time,
        end_time
    FROM src_task_details
)

SELECT * FROM final