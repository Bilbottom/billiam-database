{{ config(
    alias="finances",
    tags=["finances"]
) }}


{{ import(
    src_finances = source("raw", "finances"),

    expand_columns=false
) }}

final AS (
    -- noqa: disable=ST06
    SELECT
        ROW_NUMBER() OVER () AS row_id,  /* Just for maintaining uniqueness */
        "Transaction"::INT AS transaction_id,
        "Date"::DATE AS transaction_date,
        TRIM(item) AS item,
        TRANSLATE("cost", '£,', '')::DECIMAL(18, 2) AS "cost",
        TRIM(category) AS category,
        TRIM(retailer) AS counterparty,
        TRIM("Payment Method") AS payment_method,  -- noqa: RF05
        COALESCE(exclusion::BOOL, FALSE) AS exclusion_flag,
        "Reimbursement Transaction"::INT AS reimbursement_transaction_id  -- noqa: RF05
    FROM src_finances
    -- noqa: enable=ST06
)

SELECT * FROM final
