from sqlmesh import macro


@macro()
def within(evaluator, expr, lower_bound: str, upper_bound: str) -> str:
    """
    Returns `expr` if it is between `lower_bound` and `upper_bound`, inclusive.
    Otherwise, returns the closest bound.

    Examples:

        SELECT @within(5,  1, 10);  -- 5
        SELECT @within(0,  1, 10);  -- 1
        SELECT @within(11, 1, 10);  -- 10
    """
    return f"GREATEST(LEAST({expr}, {upper_bound}), {lower_bound})"
