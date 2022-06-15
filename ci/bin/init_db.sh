#!/bin/bash

mysql -u "${DB_USER}" -p"${DB_PASSWORD}" -h "${DB_HOST}" < "${APPLICATION_JOB_DIR}/bin/initdb.sql"
