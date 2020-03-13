#!/usr/bin/env bash

# Absolute path to entrypoint.sh
export ENTRYPOINT_SH=/code/entrypoint.sh

# Load BATS extensions (installed in ./tests/Dockerfile)
load "${BATS_TEST_HELPERS}/bats-support/load.bash"
load "${BATS_TEST_HELPERS}/bats-assert/load.bash"

function setup() {
    # Set all input parameter defaults
    export INPUT_ALL_VERSIONED_PATHS=false
    export INPUT_DOMAIN=gh_actions_host
    export INPUT_INDEX=false
    export INPUT_PATH=/v0
    export INPUT_PROTOCOL=http
    export INPUT_VALIDATOR_VERSION=latest
    export INPUT_VERBOSITY=1

    rm -f /code/tests/.entrypoint-run_validator.txt
}

function teardown() {
    if [ "${TEST_FINAL_RUN_VALIDATOR}" = "default" ] || [ -z "${TEST_FINAL_RUN_VALIDATOR}" ]; then
        TEST_FINAL_RUN_VALIDATOR="optimade_validator --verbosity 1 http://gh_actions_host/v0"
    fi
    run cat /code/tests/.entrypoint-run_validator.txt
    assert_output "run_validator: ${TEST_FINAL_RUN_VALIDATOR}"

    rm -f /code/tests/.entrypoint-run_validator.txt
}