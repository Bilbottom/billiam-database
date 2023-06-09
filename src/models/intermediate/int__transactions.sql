{{
    config(
        alias="transactions",
        tags=["finances"]
    )
}}


{{ import(
    stg_finances = ref("stg__finances")
) }}

final AS (
    SELECT
        transaction_id,
        transaction_date,
        ROUND(SUM(cost), 2) AS cost,
        COUNT(*) AS item_count,
        GROUP_CONCAT(DISTINCT counterparty, '||') AS counterparty
    FROM stg_finances
    GROUP BY transaction_id, transaction_date
    HAVING NOT(COUNT(*) = 2 AND ROUND(SUM(cost), 2) = 0)  /* Exclude credit repayment transactions */
    ORDER BY transaction_id
)

SELECT * FROM final
