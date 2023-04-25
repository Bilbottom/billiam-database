
{% macro select_star(relation) %}
    {#
    Build a select statement that lists all of the column in the object.

    Adapted from:
    - https://stackoverflow.com/a/67124464/8213085
    #}
    {%- if relation is string -%}
        {{ return( _select(relation) ) }}
    {%- else -%}
        {{ return( _select(
            relation,
            _get_columns(relation)
        ) ) }}
    {%- endif -%}

{% endmacro %}


{% macro _select(object, column_list="*") %}
    {#
    Helper macro to construct the `SELECT` statements.

    The whitespace is being a pain, so purposefully de-denting the SQL.
    #}
    {%- if column_list == '*' -%}

SELECT *
FROM {{ object }}

    {%- else -%}

SELECT
    {{ column_list | indent(width=4) }}
FROM {{ object }}

    {%- endif -%}
{% endmacro %}


{% macro _get_columns(relation) %}
    {#
    Helper macro to get the columns in an object.

    This queries the `INFORMATION_SCHEMA` to get the columns in the object.
    #}
    {%- set column_query -%}
        SELECT
            COALESCE(
                NULLIF(STRING_AGG(COLUMN_NAME ORDER BY ORDINAL_POSITION, ',\n'), ''),
                '*'  /* The model doesn't exist in the INFORMATION_SCHEMA yet */
            ) AS COLUMN_LIST
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE UPPER(TABLE_SCHEMA) = UPPER('{{ relation.schema }}')
          AND UPPER(TABLE_NAME) = UPPER('{{ relation.identifier }}')
    {%- endset -%}

    {%- if execute -%}
        {{ return( run_query(column_query).columns[0].values()[0] ) }}
    {%- else -%}
        {{ return( "*" ) }}
    {%- endif -%}
{% endmacro %}
