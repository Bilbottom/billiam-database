{{ config(alias="daily_tracker") }}


{{ import(
    stg_tracker = ref("stg__daily_tracker"),

    expand_columns=false
) }}

final as (
    select
        date_time,
        "task",
        detail,
        "interval",
        company
    from stg_tracker
)

select * from final
