#!/bin/bash

echo "Initializing DB"

mysql -u "${DB_USER}" -p"${DB_PASSWORD}" -h "${DB_HOST}" < "initdb.sql" && echo "Done initializing DB" || (echo "Failed initializing DB" && exit 1)

