
{% macro import(
    expand_columns=true,
    include_with=true,
    include_recursive=false,
    include_final_comma=true
) %}
    {%- if include_with -%}WITH{%- endif %}{% if include_recursive %} RECURSIVE{%- endif %}

    {%- for key, value in kwargs.items() %}
    {{ key }} AS (
        SELECT {{ billiam_database._parse_relation(relation=value, expand_columns=expand_columns) | indent(width=8) }}
        FROM {{ value }}
    ){{- "" if loop.last else "," -}}
    {%- endfor -%}{{- "," if include_final_comma else "" -}}
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
