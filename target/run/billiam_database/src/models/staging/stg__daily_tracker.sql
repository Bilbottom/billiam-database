
  create view "billiam"."staging"."daily_tracker__dbt_tmp" as (
    


WITH

src_tracker AS (
    SELECT *
    FROM "billiam"."raw"."daily_tracker"
),

final AS (
    SELECT
        date_time::TIMESTAMP AS date_time,
        TRIM(task) AS task,
        COALESCE(TRIM(detail), '') AS detail,
        interval::INTEGER AS interval,
        TRIM(company) AS company
    FROM src_tracker
)

SELECT * FROM final
  );
