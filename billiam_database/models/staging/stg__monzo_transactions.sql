{{ config(alias="monzo_transactions") }}


{{ import(
    src_monzo_transactions = source("raw", "monzo_transactions"),

    expand_columns=false
) }}

final AS (
    -- noqa: disable=ST06
    SELECT
        "Transaction ID" AS transaction_id,
        "Date"::DATE AS transaction_date,
        "Time"::TIME AS transaction_time,
        TRIM("Type") AS "type",
        TRIM("Name") AS counterparty,
        "Emoji" AS emoji,
        TRIM("Category") AS category,
        -"Amount"::DECIMAL(18, 2) AS "cost",
        "Currency" AS currency,
        -"Local amount"::DECIMAL(18, 2) AS local_cost,
        "Local currency" AS local_currency,
        "Notes and #tags" AS notes,
        "Address" AS address,
        TRIM("Receipt") AS receipt,
        TRIM("Description") AS description,
        "Category split" AS category_split,
    FROM src_monzo_transactions
    -- noqa: enable=ST06
)

SELECT * FROM final
