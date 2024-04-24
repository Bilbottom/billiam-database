{{ config(alias="transaction_items") }}


{{ import(
    stg_finances = ref("stg__finances"),
    int_transactions = ref("int__transactions")
) }}

final as (
    select
        stg_finances.row_id,
        stg_finances.transaction_date,
        stg_finances.transaction_id,
        stg_finances.item,
        stg_finances."cost",
        stg_finances.category,
        stg_finances.counterparty,
        stg_finances.exclusion_flag,
    from stg_finances
        semi join int_transactions using (transaction_id)
    order by stg_finances.row_id
)

select * from final
