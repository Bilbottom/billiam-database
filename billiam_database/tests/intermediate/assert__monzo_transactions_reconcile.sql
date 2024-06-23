{{ import(
    stg_finances = ref("stg__finances"),
    stg_monzo_transactions = ref("stg__monzo_transactions"),
    seed_counterparty_exclusions = ref("counterparty_exclusions")
) }}

my_transactions_rollup AS (
    SELECT
        transaction_id,
        ANY_VALUE(transaction_date) AS transaction_date,
        ANY_VALUE(counterparty) AS counterparty,
        SUM(cost)::NUMERIC(18, 2) AS cost,
    FROM stg_finances
    WHERE 1=1
        AND payment_method = 'Monzo'
        AND category != 'Interest'
        AND counterparty NOT IN ('Monzo Joint', 'TfL')
        /* Specific exceptions */
        AND transaction_id NOT IN (
            1132, /* 2019-07-22, £5 Joining Reward */
        )
        /* Monzo changes */
        AND IF(transaction_date < '2023-11-17', item != 'Monzo Premium', 1=1)
    GROUP BY transaction_id
),

my_txns AS (
    SELECT
        ROW_NUMBER() OVER (ORDER BY transaction_id) AS row_id,

        transaction_id,
        transaction_date,
        counterparty,
        cost,

        (SUM(cost) OVER (ORDER BY transaction_id))::NUMERIC(18, 2) AS running_cost,
    FROM my_transactions_rollup
),
monzo_txns AS (
    SELECT
        ROW_NUMBER() OVER (ORDER BY transaction_date, transaction_time) AS row_id,

        transaction_id,
        transaction_date,
        REGEXP_REPLACE(REPLACE(counterparty, '’', ''''), ' (Co|Ltd|Limited|Limite)$', '', 'i') AS counterparty,
        cost::NUMERIC(18, 2) AS cost,

        (SUM(cost) OVER (ORDER BY transaction_date, transaction_time))::NUMERIC(18, 2) AS running_cost,
    FROM stg_monzo_transactions
    WHERE "type" NOT IN ('Pot transfer')
      AND cost != 0
      AND category NOT IN ('Savings')
      AND counterparty NOT IN ('Transport for London')
      AND counterparty NOT IN (FROM seed_counterparty_exclusions)
),

joined AS (
    SELECT
        row_id,
        my_txns.running_cost AS running_cost__mine,
        monzo_txns.running_cost AS running_cost__monzo,
        my_txns.running_cost = monzo_txns.running_cost AS match_flag
    FROM my_txns
        FULL JOIN monzo_txns USING (row_id)
    ORDER BY row_id
)

/*
For now, we just match "close enough" -- this is because the transactions
are recorded at different times between the sources _and_ because the
merchant names are not always consistent, so it's harder to join them
together with integrity.

We apply a 97.5% match threshold to the running total, so if the running
total is out for more than 2.5% of cases we flag this as a failure.
*/
SELECT 1.0 * SUM(match_flag::INT) / COUNT(*) AS match_ratio
FROM joined
HAVING match_ratio < 0.975
