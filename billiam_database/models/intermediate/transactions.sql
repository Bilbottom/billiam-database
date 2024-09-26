model (
    name intermediate.transactions,
    kind full,
    grain (transaction_id),
    columns (
        transaction_id int,
        transaction_date date,
        cost decimal(18, 2),
        item_count int,
        counterparty varchar,
    ),
);


select
    transaction_id,
    transaction_date,
    round(sum("cost"), 2) as "cost",
    count(*) as item_count,
    string_agg(distinct counterparty, '||') as counterparty,
from raw.finances
group by transaction_id, transaction_date
having not (count(*) = 2 and round(sum("cost"), 2) = 0)  /* Exclude credit repayment transactions */
order by transaction_id
