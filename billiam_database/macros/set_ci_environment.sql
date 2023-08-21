
{% macro set_ci_environment() %}
    {#
    Run the required SQL to configure the database.

    Approach taken from:
    - https://docs.getdbt.com/docs/build/hooks-operations#operations
    #}
    {% set sql %}
        {{ create_within() }};
    {% endset %}

    {% do run_query(sql) %}
    {% do log("CI environment configured.", info=True) %}
{% endmacro %}
