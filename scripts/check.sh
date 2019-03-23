#! /bin/bash

. ./scripts/common.sh

error_found=false
if [[ -L ${JOB_DIR}/broker ]]; then
    echo "${JOB_DIR}/broker symlink found - ok"
else
    echo "error: ${JOB_DIR}/broker symlink missing"
    error_found=true
fi
if [[ "${error_found}" = true ]]; then
    echo "ERROR: missing component(s) - exiting with error"
    exit 1
fi
