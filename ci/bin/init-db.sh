#!/bin/sh

echo "Initializing DB"

echo "============== ENV ==============="
env

echo "============== mysql ==============="
which mysql


function wait_for_dns {
    host=$(echo "$1" | awk -F ":" "{print \$1}")
    echo "Waiting for ${host}"
    count=120
    while [ "${count}" -ge 0 ]; do
        if nslookup "${host}"; then
            break
        fi
        sleep 1
        (( count-=1 ))
    done
}

wait_for_dns "${DB_HOST}"

echo "============== creating tables ==============="
mysql -u "${DB_USER}" -p"${DB_PASSWORD}" -h "${DB_HOST}" < "${APPLICATION_JOB_DIR}/bin/initdb.sql" && echo "Done initializing DB" || (echo "Failed initializing DB" && exit 1)

echo "============== starting app ==============="
/bin/go-mysql-crud

