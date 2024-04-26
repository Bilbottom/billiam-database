{{ config(alias="monzo_transactions") }}


{{ import(
    src_monzo_transactions = source("raw", "monzo_transactions"),

    expand_columns=false
) }}

final as (
    -- noqa: disable=RF06
    select
        "Transaction ID" as transaction_id,  -- noqa: RF05
        "Date"::date as transaction_date,
        "Time"::time as transaction_time,
        trim("Type") as "type",
        trim("Name") as counterparty,
        "Emoji" as emoji,
        trim("Category") as category,
        -"Amount"::decimal(18, 2) as "cost",
        "Currency" as currency,
        -"Local amount"::decimal(18, 2) as local_cost,  -- noqa: RF05
        "Local currency" as local_currency,  -- noqa: RF05
        "Notes and #tags" as notes,  -- noqa: RF05
        "Address" as address,
        trim("Receipt") as receipt,
        trim("Description") as description,
        "Category split" as category_split,  -- noqa: RF05
    from src_monzo_transactions
    -- noqa: enable=RF06
)

select * from final
