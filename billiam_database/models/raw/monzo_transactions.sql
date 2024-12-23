model (
    name raw.monzo_transactions,
    kind full,
    grain (transaction_id),
    tags (finances),
    columns (
        transaction_id varchar,
        transaction_date date,
        transaction_time time,
        type varchar,
        counterparty varchar,
        emoji varchar,
        category varchar,
        cost decimal(18, 2),
        currency varchar,
        local_cost decimal(18, 2),
        local_currency varchar,
        notes varchar,
        address varchar,
        receipt blob,
        description varchar,
        category_split varchar,
    ),
);


select
    "Transaction ID" as transaction_id,
    "Date"::date as transaction_date,
    "Time"::time as transaction_time,
    trim("Type") as "type",
    trim("Name") as counterparty,
    "Emoji" as emoji,
    trim("Category") as category,
    -"Amount"::decimal(18, 2) as "cost",
    "Currency" as currency,
    -"Local amount"::decimal(18, 2) as local_cost,
    "Local currency" as local_currency,
    "Notes and #tags" as notes,
    "Address" as address,
    "Receipt" as receipt,
    trim("Description") as description,
    "Category split" as category_split,
from 'billiam_database/models/raw/data/monzo_transactions.csv'
;
