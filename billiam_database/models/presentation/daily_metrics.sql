model (
    name presentation.daily_metrics,
    kind full,
    grain (metric_date),
    columns (
        metric_date date,
        total_cost decimal(18, 3),
        non_essential_cost decimal(18, 3),
        non_essential_cost_proportion decimal(8, 4),
        total_working_time int,
        meeting_time int,
        meeting_proportion decimal(8, 4),
        working_day_meeting_proportion decimal(8, 4),
    ),
    audits (
      not_null(columns=[
        metric_date,
        total_cost,
        non_essential_cost,
        non_essential_cost_proportion,
        total_working_time,
        meeting_time,
        meeting_proportion,
        working_day_meeting_proportion,
      ]),
      unique_values(columns=[metric_date]),
    ),
);


/*
    Will break this down into smaller models later
*/

with recursive

date_dim as (
    -- noqa: disable=LT02
        select '2018-01-01'::date as metric_date
    union all
        select metric_date + interval 1 day
        from date_dim
        where metric_date < current_date
    -- noqa: enable=LT02
),

daily_transactions as (
    select
        transaction_date as metric_date,
        sum("cost") as total_cost,
        sum("cost") filter (where category not in ('Bills', 'Council Tax', 'Rent', 'Wage')) as non_essential_cost,
        @within(round(100.0 * non_essential_cost / total_cost, 4), 0, 100) as non_essential_cost_proportion,
    from intermediate.transaction_items
    where not exclusion_flag
    group by transaction_date
),

daily_work as (
    select
        date_time::date as metric_date,
        sum(minutes) as total_working_time,
        sum(minutes) filter (where project = 'Meetings') as meeting_time,
        round(100.0 * meeting_time / total_working_time, 4) as meeting_proportion,
        round(100.0 * meeting_time / least(total_working_time, 7.5 * 60), 4) as working_day_meeting_proportion,
    from raw.daily_tracker
    group by date_time::date
)

select
    date_dim.metric_date,

    coalesce(daily_transactions.total_cost, 0)::decimal(18, 3) as total_cost,
    coalesce(daily_transactions.non_essential_cost, 0)::decimal(18, 3) as non_essential_cost,
    coalesce(daily_transactions.non_essential_cost_proportion, 0)::decimal(8, 4) as non_essential_cost_proportion,
    coalesce(daily_work.total_working_time, 0)::int as total_working_time,
    coalesce(daily_work.meeting_time, 0)::int as meeting_time,
    coalesce(daily_work.meeting_proportion, 0)::decimal(8, 4) as meeting_proportion,
    coalesce(daily_work.working_day_meeting_proportion, 0)::decimal(8, 4) as working_day_meeting_proportion,
from date_dim
    left join daily_transactions
        using (metric_date)
    left join daily_work
        using (metric_date)
order by date_dim.metric_date
