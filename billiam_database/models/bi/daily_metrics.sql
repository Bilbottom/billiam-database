model (
    name bi.daily_metrics,
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
);


with

date_dim as (
    select date_dt as metric_date
    from calendar.calendar
    where date_dt::date between '2018-01-01'::date and current_date
),

daily_transactions as (
    select
        transaction_date as metric_date,
        sum("cost") as total_cost,
        sum("cost") filter (where category not in ('Bills', 'Council Tax', 'Rent', 'Wage')) as non_essential_cost,
        @within(round(100.0 * non_essential_cost / total_cost, 4), 0, 100) as non_essential_cost_proportion,
    from finances.transaction_items
    where not exclusion_flag
    group by metric_date
),

daily_work as (
    select
        log_ts::date as metric_date,
        sum(minutes) as total_working_time,
        sum(minutes) filter (where project = 'Meetings') as meeting_time,
        round(100.0 * meeting_time / total_working_time, 4) as meeting_proportion,
        round(100.0 * meeting_time / least(total_working_time, 7.5 * 60), 4) as working_day_meeting_proportion,
    from career.daily_tracker
    group by metric_date
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
order by metric_date
;
