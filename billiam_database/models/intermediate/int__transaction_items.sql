{{
    config(
        alias="transaction_items",
        tags=["finances"]
    )
}}


{{ import(
    stg_finances = ref("stg__finances"),
    int_transactions = ref("int__transactions")
) }}

final AS (
    SELECT
        row_id,
        transaction_date,
        transaction_id,
        item,
        cost,
        category,
        counterparty,
        exclusion_flag
    FROM stg_finances
    WHERE transaction_id IN (
        /*
            Only keep the items for transactions that haven't been filtered out.
        */
        SELECT transaction_id
        FROM int_transactions
    )
    ORDER BY row_id
)

SELECT * FROM final
