# https://github.com/MotherDuck-Open-Source/metabase_duckdb_driver
FROM openjdk:19-buster

ENV MB_PLUGINS_DIR=/home/plugins/

ADD https://downloads.metabase.com/v0.47.4/metabase.jar /home/
ADD https://github.com/AlexR2D2/metabase_duckdb_driver/releases/download/0.2.3/duckdb.metabase-driver.jar /home/plugins/
ADD billiam_database/billiam.duckdb /home/

RUN chmod 744 /home/plugins/duckdb.metabase-driver.jar

CMD ["java", "-jar", "/home/metabase.jar"]
