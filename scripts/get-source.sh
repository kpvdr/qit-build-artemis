#! /bin/bash

. ./scripts/common.sh

function git_clone_or_update {
    get_dir_name $1
    if [[ -d $2 ]]; then
        cd $2
        git pull $1
    else
        git clone $1
    fi
}

git_clone_or_update "${GIT_REPO}"
