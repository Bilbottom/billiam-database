
def some_string() -> str:
    return "some string"


def iff(condition: bool, if_true: str, if_false: str = "") -> str:
    return if_true if condition else if_false
