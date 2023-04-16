{# Import a set of objects #}

{% macro import() %}
    {%- for key, value in kwargs.items() %}
    {{ key }} AS (
        {# Expand the relation #}
        {{- dp_a4tb_demand_forecast_sales_forecast_poc_dv.select_star(value) | indent(width=8) }}
    ){{- "" if loop.last else "," -}}
    {% endfor %}
{% endmacro %}
