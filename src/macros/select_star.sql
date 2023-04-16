{#
    Build a select statement that lists all of the column in the object

    https://stackoverflow.com/a/67124464/8213085
#}

{% macro select_star(relation) %}
    {%- if relation is string -%}
        {{ return( dp_a4tb_demand_forecast_sales_forecast_poc_dv._select(relation) ) }}
    {%- else -%}
        {{ return( dp_a4tb_demand_forecast_sales_forecast_poc_dv._select(
            relation,
            dp_a4tb_demand_forecast_sales_forecast_poc_dv._get_columns(relation)
        ) ) }}
    {%- endif -%}

{% endmacro %}


{# Helper macro to construct the SELECT statements #}
{% macro _select(object, column_list="*") %}
    {%- if column_list == '*' -%}

SELECT *
FROM {{ object }}

    {%- else -%}

SELECT
    {{ column_list | indent(width=4) }}
FROM {{ object }}

    {%- endif -%}
{% endmacro %}


{# Helper macro to get the columns in an object #}
{% macro _get_columns(relation) %}
    {%- set column_query -%}
        SELECT
            COALESCE(
                NULLIF(LISTAGG(COLUMN_NAME, ',\n') WITHIN GROUP (ORDER BY ORDINAL_POSITION), ''),
                '*'  /* The model doesn't exist in the INFORMATION_SCHEMA yet */
            ) AS COLUMN_LIST
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_SCHEMA = '{{ relation.schema }}' COLLATE 'en-ci'
          AND TABLE_NAME = '{{ relation.identifier }}' COLLATE 'en-ci'
    {%- endset -%}

    {%- if execute -%}
        {{ return( run_query(column_query).columns[0].values()[0] ) }}
    {%- else -%}
        {{ return( "*" ) }}
    {%- endif -%}
{% endmacro %}
