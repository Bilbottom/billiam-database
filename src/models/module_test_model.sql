{{ config(
    materialized="table",
    tags=["module-test"]
) }}

SELECT
    /* Standard Lib - math */
    '{{ modules.math.e }}' AS e,
    '{{ modules.math.inf }}' AS inf,
    '{{ modules.math.nan }}' AS nan,
    '{{ modules.math.pi }}' AS pi,
    '{{ modules.math.tau }}' AS tau,

    /* Third-Party Lib - requests */
    '{{ modules.requests.codes.ok }}' AS ok,
    '{{ modules.requests.codes.created }}' AS created,
    '{{ modules.requests.codes.accepted }}' AS accepted,

    /* Internal Lib - custom_package */
    '{{ modules.custom_package.some_string() }}' AS some_string,
    '{{ modules.custom_package.iff( is_incremental(), "do incremental thing", "do full refresh thing" ) }}' AS load_thing
