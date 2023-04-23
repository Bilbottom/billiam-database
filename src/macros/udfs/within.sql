
{% macro create_within() %}
    {#
    Returns `expr` if it is between `lower_bound` and `upper_bound`, inclusive.
    Otherwise, returns the closest bound.


    Examples:

        SELECT within(5,  1, 10);  -- 5
        SELECT within(0,  1, 10);  -- 1
        SELECT within(11, 1, 10);  -- 10
    #}
    CREATE MACRO within(expr, lower_bound, upper_bound) AS
        GREATEST(LEAST(expr, upper_bound), lower_bound)
    ;
{% endmacro %}
