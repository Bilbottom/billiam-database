
  
    

    create  table
      "billiam"."presentation"."daily_metrics__dbt_tmp"
    as (
      

/*
    Will break this down into smaller models later
*/


WITH RECURSIVE

src_transactions AS (
    SELECT *
    FROM "billiam"."intermediate"."transaction_items"
),
src_tracker AS (
    SELECT *
    FROM "billiam"."staging"."daily_tracker"
),

date_dim AS (
        SELECT '2018-01-01'::DATE AS metric_date
    UNION ALL
        SELECT metric_date + INTERVAL 1 DAY
        FROM date_dim
        WHERE metric_date < CURRENT_DATE()
),

daily_transactions AS (
    SELECT
        transaction_date AS metric_date,
        SUM(cost) AS total_cost,
        SUM(cost) FILTER (WHERE category NOT IN ('Bills', 'Council Tax', 'Rent', 'Wage')) AS non_essential_cost,
        GREATEST(LEAST(ROUND(100.0 * non_essential_cost / total_cost, 4), 100), 0) AS non_essential_cost_proportion
    FROM src_transactions
    WHERE NOT exclusion_flag
    GROUP BY transaction_date
),
daily_work AS (
    SELECT
        date_time::DATE AS metric_date,
        SUM("interval") AS total_working_time,
        SUM("interval") FILTER (WHERE task IN ('Meetings', 'Catch Up')) AS meeting_time,
        ROUND(100.0 * meeting_time / total_working_time, 4) AS meeting_proportion,
        ROUND(100.0 * meeting_time / (7.5 * 60), 4) AS working_day_meeting_proportion
    FROM src_tracker
    GROUP BY date_time::DATE
)

SELECT
    date_dim.metric_date,

    COALESCE(daily_transactions.total_cost, 0) AS total_cost,
    COALESCE(daily_transactions.non_essential_cost, 0) AS non_essential_cost,
    COALESCE(daily_transactions.non_essential_cost_proportion, 0) AS non_essential_cost_proportion,
    COALESCE(daily_work.total_working_time, 0) AS total_working_time,
    COALESCE(daily_work.meeting_time, 0) AS meeting_time,
    COALESCE(daily_work.meeting_proportion, 0) AS meeting_proportion,
    COALESCE(daily_work.working_day_meeting_proportion, 0) AS working_day_meeting_proportion
FROM date_dim
    LEFT JOIN daily_transactions USING(metric_date)
    LEFT JOIN daily_work USING(metric_date)
ORDER BY date_dim.metric_date
    );
  