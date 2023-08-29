#!/bin/bash

if [[ -f "./yarn.lock" ]]; then
    runner="yarn"
elif [[ -f "./package-lock.json" ]]; then
    runner="npm"
elif [[ -f "./pnpm-lock.yaml" ]]; then
    runner="pnpm"
else
    echo "Din't find any lock files in this directory, which package-manager do you want to use (npm/yarn/pnpm)?"
    read -r runner
    if [ "$runner" != "npm" ] && [ "$runner" != "pnpm" ] && [ "$runner" != "yarn" ]; then
        echo "That's a invalid node package manager"
        exit 1
    fi
fi

# Install yarn or pnpm if the lock files exists
hash "$runner" 2>/dev/null || {
    echo >&2 "$runner is not installed. Installing $runner globally."
    eval "npm i -g $runner"
    echo "$runner installed globally. Running the requested command."
}

if [ "$1" = "add" ]; then
    eval "$runner add ${*:2}"
elif [ "$1" = "setup" ] || [ "$1" = "install-node-modules" ]; then
    if [ "$runner" != "yarn" ]; then
        eval "$runner install"
    else
        eval "$runner"
    fi
elif [ "$1" = "remove" ] || [ "$1" = "rm" ] || [ "$1" = "uninstall" ] || [ "$1" = "un" ]; then
    if [ "$runner" = "yarn" ]; then
        eval "$runner remove ${*:2}"
    else
        eval "$runner uninstall ${*:2}"
    fi
elif [ "$1" = "update" ] || [ "$1" = "upgrade" ] || [ "$1" = "up" ]; then
    if [ "$runner" = "yarn" ]; then
        eval "$runner upgrade ${*:2}"
    else
        eval "$runner update ${*:2}"
    fi
elif [ "$1" = "run" ]; then
    if [ "$runner" = "npm" ]; then
        eval "$runner run ${*:2}"
    else
        eval "$runner ${*:2}"
    fi
elif [ "$1" = "outdated" ]; then
    eval "$runner outdated ${*:2}"
elif [ "$1" = "list" ] || [ "$1" = "ls" ]; then
    eval "$runner list ${*:2}"
elif [ "$1" = "init" ] || [ "$1" = "new" ]; then
    eval "$runner init ${*:2}"
elif [ "$1" = "list-scripts" ]; then
    if [ "$runner" != "npm" ]; then
        eval "$runner run"
    else
        echo "$runner doesn't support listing all the scripts, please check package.json"
    fi
else
    eval "$runner ${*:1}"
fi
