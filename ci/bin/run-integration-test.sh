#!/bin/sh

wait_for_dns() {
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

echo "$(date) Test cover - ${TEST_COVER}"

wait_for_dns "${DB_HOST}"
wait_for_dns "${CONSUL_SERVICENAME}.query.consul"

testBinary=$(find -L "${PKG_BASE_DIR}/integration" -type f -name "${APPLICATION_NAME}-integration.test")
echo "$(date) ========================== Path to integration test binary - ${testBinary}  =========================="

"${testBinary}" -test.v args | tee "${APPLICATION_LOGS_DIR}/integration_test.log"

echo "$(date)  ************ COPYING TEST RESULTS TO XML ************"
"${PKG_BASE_DIR}/go-tools/go-junit-report" < "${APPLICATION_LOGS_DIR}/integration_test.log" > "${TEST_LOGS_DIR}/test.xml"

echo "$(date) ************ TEST COMPLETE ************"
