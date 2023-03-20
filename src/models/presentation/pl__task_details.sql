{{
    config(
        alias="task_details",
        materialized="view"
    )
}}


WITH

src_task_details AS (
    SELECT *
    FROM {{ ref("int__task_details") }}
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
