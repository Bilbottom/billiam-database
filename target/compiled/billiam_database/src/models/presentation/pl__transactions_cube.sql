

/*
    Not helpful for me, but illustrates the usage
*/

WITH

int_transaction_items AS (
    SELECT *
    FROM "billiam"."intermediate"."transaction_items"
),

final AS (
    SELECT
        GROUPING_ID(
            transaction_date,
            category,
            counterparty,
            exclusion_flag
        ) AS group_id,
        transaction_date,
        category,
        counterparty,
        exclusion_flag,

        COUNT(DISTINCT transaction_id) AS total_transaction_count,
        COUNT(*) AS total_item_count,
        COUNT(DISTINCT item) AS distinct_item_count,
        SUM(cost) AS total_cost,
        AVG(cost) AS average_cost,
        MIN(cost) AS min_cost,
        MAX(cost) AS max_cost,
        STDDEV_POP(cost) AS standard_dev_cost
    FROM int_transaction_items
    
    WHERE transaction_date >= (
        SELECT MAX(transaction_date)
        FROM "billiam"."presentation"."transactions_cube"
    )
    
    GROUP BY CUBE(
        transaction_date,
        category,
        counterparty,
        exclusion_flag
    )
)

SELECT * FROM final