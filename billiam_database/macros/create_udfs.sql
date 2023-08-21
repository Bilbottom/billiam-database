
{% macro create_udfs() %}
    {#
    Create the user defined functions in the target schema.

    Approach taken from:
    - https://discourse.getdbt.com/t/using-dbt-to-manage-user-defined-functions/18
    #}
    {{ create_within() }};
{% endmacro %}
