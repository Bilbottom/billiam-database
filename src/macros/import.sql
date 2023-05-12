
{% macro import(
    expand_columns=true,
    include_with=true,
    include_recursive=false,
    include_final_comma=true
) %}
    {#-
    Expand the key-value pairs into CTEs whose names are the keys.
    #}
    {% if include_with -%}WITH{%- endif %}{% if include_recursive %} RECURSIVE{%- endif %}

    {% for key, value in kwargs.items() %}
    {{ key }} AS (
        {% if expand_columns %}
            {# Expand the columns of the relation #}
            {{- select_star(value) | indent(width=8) }}
        {% else %}
            select * from {{ value }}
        {% endif %}
    ){{- "" if loop.last else "," -}}
    {% endfor %}{{- "," if include_final_comma else "" -}}
{% endmacro %}
