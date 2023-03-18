
  create view "billiam"."staging"."finances__dbt_tmp" as (
    


WITH

src_finances AS (
    SELECT rowid, *
    FROM "billiam"."raw"."finances"
),

final AS (
    SELECT
        rowid + 1 AS row_id,  /* Just for maintaining uniqueness */
        "Transaction"::INT AS transaction_id,
        STRPTIME("Date", '%d/%m/%Y')::DATE AS transaction_date,
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
  );
