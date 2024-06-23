{{ import(
    stg_finances = ref("stg__finances"),
    stg_monzo_transactions = ref("stg__monzo_transactions")
) }}

my_txns AS (
    SELECT
        transaction_date,
        SUM(cost)::NUMERIC(18, 2) AS cost,
    FROM stg_finances
    WHERE counterparty = 'TfL'
      AND payment_method = 'Monzo'
    GROUP BY transaction_date
),
monzo_txns AS (
    SELECT
        transaction_date,
        SUM(cost)::NUMERIC(18, 2) AS cost,
    FROM stg_monzo_transactions
    WHERE counterparty = 'Transport for London'
      AND cost != 0
    GROUP BY transaction_date
),

dates AS (
        SELECT MIN(transaction_date) AS transaction_date
        FROM my_txns
    UNION ALL
        SELECT transaction_date + INTERVAL 1 DAY
        FROM dates
        WHERE transaction_date < CURRENT_DATE
),

joined AS (
    SELECT
        transaction_date,
        COALESCE(my_txns.cost, 0) AS cost__mine,
        COALESCE(monzo_txns.cost, 0) AS cost__monzo,

        SUM(cost__mine)  OVER t_date AS running_cost__mine,
        SUM(cost__monzo) OVER t_date AS running_cost__monzo,

        running_cost__mine = running_cost__monzo AS match_flag
    FROM dates
        LEFT JOIN my_txns    USING (transaction_date)
        LEFT JOIN monzo_txns USING (transaction_date)
    WINDOW t_date AS (ORDER BY transaction_date)
)

/*
For now, we just match "close enough" -- this is because the transactions
are recorded at different times between the sources _and_ because the
grain is different, so it's harder to join them together with integrity.

Remember that the `stg__finances` model records each _journey_, whereas
the `stg__monzo_transactions` model records each _transaction_ which can
correspond to several journeys.

We apply an 80% match threshold to the running total, so if the running
total is out for more than 20% of cases we flag this as a failure.
*/
SELECT 1.0 * SUM(match_flag::INT) / COUNT(*) AS match_ratio
FROM joined
HAVING match_ratio < 0.80
