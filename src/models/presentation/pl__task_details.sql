{{
    config(
        alias="task_details",
        materialized="view",
        tags=["daily-tracker"]
    )
}}


{{ import(
    src_task_details = ref("int__task_details")
) }}

final AS (
    SELECT
        group_id::INT AS group_id,
        group_description,
        task,
        detail,
        total_records::INT AS total_records,
        total_time::INT AS total_time,
        start_time,
        end_time
    FROM src_task_details
)

SELECT * FROM final
