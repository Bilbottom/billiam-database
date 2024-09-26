model (
    name presentation.working_hours,
    kind full,
    grain (week_starting),
    columns (
        week_starting date,
        scheduled_hours decimal(6, 4),
        absence_hours decimal(6, 4),
        expected_working_hours decimal(6, 4),
    ),
    audits (
      not_null(columns=[
        week_starting,
        scheduled_hours,
        absence_hours,
        expected_working_hours,
      ]),
      unique_values(columns=[week_starting]),
    ),
);


with recursive

dates(week_starting) as (
    -- noqa: disable=LT02
        select date_trunc('week', (select min(from_date) from seeds.work_hours))
    union all
        select week_starting + interval '1 week'
        from dates
        where week_starting < current_date - interval '1 week'
    -- noqa: enable=LT02
),

scheduled_hours as (
    select
        from_date,
        coalesce(to_date, '9999-12-31') as to_date,
        (0  -- noqa: LT02
            + sunday
            + monday
            + tuesday
            + wednesday
            + thursday
            + friday
            + saturday
        ) as scheduled_hours
    from seeds.work_hours
),

absence_hours as (
    select
        date_trunc('week', absence_date) as week_starting,
        sum(hours) as absence_hours
    from seeds.work_absences
    group by all
),

all_hours as (
    select
        dates.week_starting,
        coalesce(scheduled_hours.scheduled_hours, 0) as scheduled_hours,
        coalesce(absence_hours.absence_hours, 0) as absence_hours
    from dates
        left join scheduled_hours
            on dates.week_starting between scheduled_hours.from_date and scheduled_hours.to_date
        left join absence_hours
            using (week_starting)
)

select
    week_starting,
    scheduled_hours,
    absence_hours,
    scheduled_hours - absence_hours as expected_working_hours
from all_hours
order by week_starting
