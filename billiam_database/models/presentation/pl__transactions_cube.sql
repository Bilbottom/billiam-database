{{ config(
    alias="transactions_cube",
    materialized="incremental",
    unique_key=[
        "group_id",
        "transaction_date",
        "category",
        "counterparty",
        "exclusion_flag",
    ]
) }}


/*
    Not helpful for me, but illustrates the usage
*/

{{ import(
    int_transaction_items = ref("int__transaction_items")
) }}

final as (
    -- noqa: disable=ST06
    select
        grouping_id(
            transaction_date,
            category,
            counterparty,
            exclusion_flag
        ) as group_id,
        transaction_date,
        category,
        counterparty,
        exclusion_flag,

        count(distinct transaction_id) as total_transaction_count,
        count(*) as total_item_count,
        count(distinct item) as distinct_item_count,
        sum("cost") as total_cost,
        avg("cost") as average_cost,
        min("cost") as min_cost,
        max("cost") as max_cost,
        stddev_pop("cost") as standard_dev_cost,
    from int_transaction_items
    -- noqa: enable=ST06
    {% if is_incremental() %}
    -- noqa: disable=LT02
    where transaction_date >= (
        select max(transaction_date)
        from {{ this }}
    )
    -- noqa: enable=LT02
    {% endif %}
    group by cube(
        transaction_date,
        category,
        counterparty,
        exclusion_flag
    )
)

select * from final
