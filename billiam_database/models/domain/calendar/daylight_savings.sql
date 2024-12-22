model (
    name calendar.daylight_savings,
    kind full,
    grain (region, year_number),
    columns (
        region             varchar,
        year_number        int,
        dst_start_time_utc timestamp,
        dst_end_time_utc   timestamp,
    ),
);


select
    'UK/EU' as region,  /* Currently just UK/EU, but this may change in the future */
    year_number,
    max(if(month_number = 3,  date_dt, '1900-01-01') || ' 01:00:00') as dst_start_time_utc,
    max(if(month_number = 10, date_dt, '1900-01-01') || ' 01:00:00') as dst_end_time_utc
from calendar.calendar
where day_name = 'Sunday'
group by year_number
order by year_number
;

/*
    In the UK:

    - DST starts on the last Sunday in March at 01:00 UTC
    - DST end on the last Sunday in October at 01:00 UTC

    Between these dates and times, the time in the UK is UTC +1 hour

    For example, in 2022:

    - When local standard time was about to reach
        Sunday, 27 March 2022, 01:00:00 clocks were turned forward 1 hour to
        Sunday, 27 March 2022, 02:00:00 local daylight time instead.

    - When local daylight time was about to reach
        Sunday, 30 October 2022, 02:00:00 clocks were turned backward 1 hour to
        Sunday, 30 October 2022, 01:00:00 local standard time instead.

    Sources:

        - https://en.wikipedia.org/wiki/Daylight_saving_time_by_country
        - https://www.timeanddate.com/time/change/uk
*/
