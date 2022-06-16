#!/bin/sh

echo "Initializing DB"

wait_for_dns(){
    host=$(echo "$1" | awk -F ":" "{print \$1}")
    echo "$(date) Waiting for ${host}"
    count=120
    while [ "${count}" -ge 0 ]; do
        if getent hosts "${host}"; then
            break
        fi
        sleep 1
         count=$((count-1))
    done
}

wait_for_dns "${DB_HOST}"

echo "$(date) ============== creating tables ==============="
mysql -u "root" -p"${DB_ROOT_PASSWORD}" -h "${DB_HOST}" < "${APPLICATION_JOB_DIR}/bin/initdb.sql" && echo "Done initializing DB" || (echo "Failed initializing DB" && exit 1)

echo "$(date) ============== starting app ==============="
/bin/go-mysql-crud

