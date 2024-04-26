{% macro import(expand_columns=true) %}
    with recursive

    {%- for key, value in kwargs.items() %}
    {{ key }} as (
        select {{ billiam_database._parse_relation(relation=value, expand_columns=expand_columns) | indent(width=8) }}
        from {{ value }}
    ),
    {%- endfor -%}
{% endmacro %}


{% macro _parse_relation(relation, expand_columns) %}
    {%- if relation is string or not expand_columns -%}
        *
    {%- elif relation.is_cte -%}
        *
    {%- else -%}
        {{ "\n  " ~ dbt_utils.star(from=relation, quote_identifiers=False) }}
    {%- endif -%}
{% endmacro %}
