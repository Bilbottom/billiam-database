from billiam_database import macros


def test__within():
    """
    When the value is within the bounds, it should return the value.
    Otherwise, it should return the closest bound.
    """
    assert macros.within(5, 1, 10) == 5
    assert macros.within(0, 1, 10) == 1
    assert macros.within(11, 1, 10) == 10
