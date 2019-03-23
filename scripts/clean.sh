#! /bin/bash

. ./scripts/common.sh

rm_dir() {
    if [[ -n $1 ]] && [[ -d $1 ]]; then
        echo "rm -rf $1"
        rm -rf $1
    else
        echo "Parameter \"$1\" is not a directory"
    fi
}

rm_dir ${GIT_DIR}
if [[ -L broker ]]; then
  rm broker
fi
