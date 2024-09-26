<div align="center">

[![Python](https://img.shields.io/badge/Python-3.11-blue.svg)](https://www.python.org/downloads/release/python-3110/)
[![Poetry](https://img.shields.io/endpoint?url=https://python-poetry.org/badge/v0.json)](https://python-poetry.org/)
[![Docker](https://img.shields.io/badge/Docker-24.0.6-blue.svg)](https://www.docker.com/)
[![tests](https://github.com/Bilbottom/billiam-database/actions/workflows/tests.yaml/badge.svg)](https://github.com/Bilbottom/billiam-database/actions/workflows/tests.yaml)
![GitHub last commit](https://img.shields.io/github/last-commit/Bilbottom/billiam-database)

[![code style: prettier](https://img.shields.io/badge/code_style-prettier-ff69b4.svg?style=flat-square)](https://github.com/prettier/prettier)
[![pre-commit.ci status](https://results.pre-commit.ci/badge/github/Bilbottom/billiam-database/main.svg)](https://results.pre-commit.ci/latest/github/Bilbottom/billiam-database/main)
[![DuckDB](https://img.shields.io/badge/DuckDB-1.1.1-teal.svg)](https://duckdb.org/)
[![Metabase](https://img.shields.io/badge/Metabase-0.47-teal.svg)](https://www.metabase.com/)

</div>

---

# Billiam's Database 🧙‍♂️

OLAP database project for life admin.

## About

As part of my life admin, I keep track of:

- Every transaction I make at an item level (since 2018-01-18)
- On the job, what I'm working on every 15 minutes (since 2019-04-23)

Note that the job tracker is my [daily-tracker](https://github.com/Bilbottom/daily-tracker) project.

Documentation is hosted at:

- https://bilbottom.github.io/billiam-database

## Setup

Since this is a personal project, I don't expect anyone else to do this, but I'm still documenting it for myself (I have a very, very bad memory).

### Pre-requisites

This project requires the following three tools to be installed:

- [Python](https://www.python.org/downloads/release/python-3110/)
- [Poetry](https://python-poetry.org/)
- [Docker](https://www.docker.com/) (only if you want to use [Metabase](https://www.metabase.com/))

The required versions are specified in the badges at the top of this README, and also in:

- [pyproject.toml](pyproject.toml)
- [poetry.lock](poetry.lock)

### Installation (SQLMesh)

After cloning the repo, install the dependencies and enable [pre-commit](https://pre-commit.com/):

```shell
poetry install --sync
pre-commit install --install-hooks
```

Pipeline changes need to be applied via a plan:

```
sqlmesh -p billiam_database plan
```

...and the pipeline can be run with the `run` command:

```
sqlmesh -p billiam_database run
```

The SQLMesh UI is great for doing these with a GUI:

```
sqlmesh -p billiam_database ui
```

### Installation (Metabase)

> [!WARNING]
>
> The DuckDB driver for Metabase is a community driver. This means that it might not work in all circumstances.

[Metabase](https://www.metabase.com/) is a tool for visualising data.

In this project, Metabase is run in a Docker container; run the following command:

```shell
# start
docker-compose --file docker-compose.yaml --project-name billiam-database up --detach

# stop
docker-compose --file docker-compose.yaml --project-name billiam-database down --remove-orphans
```

This will make Metabase available at:

- [http://localhost:3000](http://localhost:3000)

> [!WARNING]
>
> There are two important notes about the current Metabase configuration:
>
> - Since [DuckDB](https://duckdb.org/) only supports one connection at a time, you can't use Metabase and run the pipelines at the same time.
> - The Metabase data is stored locally in the `dockerfiles/metaduck-data` directory so that it persists between container restarts.
