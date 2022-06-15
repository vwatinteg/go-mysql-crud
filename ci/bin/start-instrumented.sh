#!/bin/sh

echo "$(date) --------------------- INSTRUMENTED SCRIPT --------------------"

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

echo "$(date) ************ SETTING THE GO PATH ************"
export GOPATH="${PKG_BASE_DIR}/go-tools/go"
echo "Go path is - ${GOPATH}"

tar xvzf "${PKG_BASE_DIR}/instrumented/${APPLICATION_NAME}-src.tar.gz" -C "${GOPATH}/src/github.com/"

echo "$(date) =============================== START TEST RUN ==============================="
set -exo pipefail
"${PKG_BASE_DIR}/instrumented/${APPLICATION_NAME}-instrumented" -test.coverprofile "${PROFILE}"
echo "Exited with status: $?"
echo "$(date) =============================== TEST RUN COMPLETE ==============================="

set +o pipefail

sleep 10

echo "$(date) =============================== COPY COVERAGE DATA ${PROFILE} ==============================="
"${PKG_BASE_DIR}/go-tools/gocov convert" "${PROFILE}" | "${PKG_BASE_DIR}/go-tools/gocov-xml" > "${APPLICATION_LOGS_DIR}/${APPLICATION_NAME}-coverage.xml"
cp "${PROFILE}" "${TEST_LOGS_DIR}/"

echo "$(date) =============================== TEST COMPLETE ==============================="