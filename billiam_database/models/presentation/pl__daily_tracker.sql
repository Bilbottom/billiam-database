{{ config(alias="daily_tracker") }}


{{ import(
    stg_tracker = ref("stg__daily_tracker")
) }}

final as (
    select
        date_time,
        project,
        detail,
        minutes,
        company
    from stg_tracker
)

select * from final
