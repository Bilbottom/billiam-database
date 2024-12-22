model (
    name finances.credit_repayments,
    kind full,
    grain (transaction_id),
    columns (
        transaction_id int,
        transaction_date date,
        cost decimal(18, 2),
        payment_method varchar,
        counterparty varchar,
        exclusion_flag bool,
    ),
);


with repayment_items as (
    select
        finances.transaction_id,
        finances.transaction_date,
        finances.cost,
        finances.payment_method,
        finances.exclusion_flag,
    from raw.finances
        anti join finances.transactions
            using (transaction_id)
)

select
    me.transaction_id,
    me.transaction_date,
    me.cost,
    me.payment_method,
    bank.payment_method as counterparty,
    me.exclusion_flag or bank.exclusion_flag as exclusion_flag,
from repayment_items as me
    inner join repayment_items as bank
        using (transaction_id)
where 1=1
    and me.cost > 0
    and bank.cost < 0
order by me.transaction_id
;

/*
    `me.counterparty` is the name of the bank/institution, whereas
    `bank.payment_method` is the FK to the actual card in my spreadsheet
*/
