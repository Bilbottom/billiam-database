{{
    config(
        alias="finances",
        tags=["finances"]
    )
}}

{{ import(
    src_finances = source("raw", "finances"),

    expand_columns=false
) }}

final AS (
    SELECT
        ROW_NUMBER() OVER() AS row_id,  /* Just for maintaining uniqueness */
        "Transaction"::INT AS transaction_id,
        "Date"::DATE AS transaction_date,
        TRIM(Item) AS item,
        TRANSLATE(Cost, '£,', '')::DECIMAL(18, 2) AS cost,
        TRIM(Category) AS category,
        TRIM(Retailer) AS counterparty,
        TRIM("Payment Method") AS payment_method,
        COALESCE(Exclusion::BOOL, FALSE) AS exclusion_flag,
        "Reimbursement Transaction"::INT AS reimbursement_transaction_id
    FROM src_finances
)

SELECT * FROM final
