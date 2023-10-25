{{ config(
    alias="finances",
    tags=["finances"]
) }}


{{ import(
    src_finances = source("raw", "finances"),

    expand_columns=false
) }}

final as (
    -- noqa: disable=ST06, RF06
    select
        row_number() over () as row_id,  /* Just for maintaining uniqueness */
        "Transaction"::int as transaction_id,
        "Date"::date as transaction_date,
        trim("Item") as item,
        translate("Cost", '£,', '')::decimal(18, 2) as "cost",
        trim("Category") as category,
        trim("Retailer") as counterparty,
        trim("Payment Method") as payment_method,  -- noqa: RF05
        coalesce("Exclusion"::bool, false) as exclusion_flag,
        "Reimbursement Transaction"::int as reimbursement_transaction_id  -- noqa: RF05
    from src_finances
    -- noqa: enable=ST06, RF06
)

select * from final
