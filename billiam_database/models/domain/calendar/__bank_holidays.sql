model (
    name calendar.bank_holidays,
    kind full,
    grain (division, date_dt),
    columns (
        division varchar,
        date_dt date,
        title varchar,
        notes varchar,
    ),

);


/*
    Excluded until the following issue is resolved:

    - https://github.com/tobymao/sqlglot/issues/4542
*/


with bank_holidays(division, title, date_dt, notes, bunting) as (
    select
        division,
        unnest(events.events, recursive:=true)
    from (
        unpivot 'https://www.gov.uk/bank-holidays.json'
        on "england-and-wales", "scotland", "northern-ireland"
        into
            name division
            value events
    )
)

select
    division,
    date_dt,
    title,
    notes,
from bank_holidays
;
