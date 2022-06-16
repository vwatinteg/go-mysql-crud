#!/bin/sh

echo "Initializing DB"

echo "============== ENV ==============="
env

echo "============== mysql ==============="
which mysql

mysql -u "${DB_USER}" -p"${DB_PASSWORD}" -h "${DB_HOST}" < "${APPLICATION_JOB_DIR}/bin/initdb.sql" && echo "Done initializing DB" || (echo "Failed initializing DB" && exit 1)

/bin/go-mysql-crud

