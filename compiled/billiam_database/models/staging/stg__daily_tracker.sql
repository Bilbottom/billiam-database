



    with recursive
    src_tracker as (
        select *
        from 'billiam_database/models/source/daily_tracker.csv'
    ),

final as (
    select
        date_time::timestamp as date_time,
        trim("task") as project,
        coalesce(trim(detail), '') as detail,
        "interval"::integer as minutes,
    from src_tracker
)

select * from final