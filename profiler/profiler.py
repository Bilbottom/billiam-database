from pathlib import Path

import db_query_profiler
import duckdb


def main():
    db_connection = duckdb.connect(
        database=str(Path(__file__).parent.parent / "src" / "billiam.duckdb"),
        read_only=True,
    )
    db_query_profiler.time_queries(
        conn=db_connection,
        repeat=1_000,
        directory="queries"
    )


if __name__ == "__main__":
    main()
