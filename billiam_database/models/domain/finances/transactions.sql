model (
    name finances.transactions,
    kind full,
    grain (transaction_id),
    columns (
        transaction_id int,
        transaction_date date,
        cost decimal(18, 2),
        item_count int,
        counterparty varchar,
        reimbursement_transaction_id int,
    ),
);


select
    transaction_id,
    any_value(transaction_date) as transaction_date,
    sum(cost) as cost,
    count(*) as item_count,
    string_agg(distinct counterparty, '||') as counterparty,
    any_value(reimbursement_transaction_id) as reimbursement_transaction_id,
from raw.finances
where item != 'Credit Card Bill'  /* Exclude credit repayment transactions */
group by transaction_id
order by transaction_id
;
