#!/bin/sh

echo "Initializing DB"

echo "$(date) ============== ENV ==============="
env

echo "$(date) ============== mysql ==============="
which mysql

function wait_for_dns {
    host=$(echo "$1" | awk -F ":" "{print \$1}")
    echo "$(date) Waiting for ${host}"
    count=120
    while [ "${count}" -ge 0 ]; do
        if nslookup "${host}"; then
            break
        fi
        sleep 1
         count=$((count-1))
    done
}

wait_for_dns "${DB_HOST}"

set -x
set +e
echo "$(date) ============== file mysql ==============="
file /usr/bin/mysql

echo "$(date) ============== file mariadb ==============="
file /usr/bin/mariadb

set -e
echo "$(date) ============== creating tables ==============="
mysql -u "${DB_USER}" -p"${DB_PASSWORD}" -h "${DB_HOST}" < "${APPLICATION_JOB_DIR}/bin/initdb.sql" && echo "Done initializing DB" || (echo "Failed initializing DB" && exit 1)

echo "$(date) ============== starting app ==============="
/bin/go-mysql-crud

