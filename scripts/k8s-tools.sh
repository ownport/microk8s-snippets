#!/bin/bash

# exit immediately on error
set -e
# fail on undeclared variables
set -u 

# Grab the directory of the scripts, in case the script is invoked from a different path
SCRIPTS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

# Useful routines in common.sh
. "${SCRIPTS_DIR}/common.sh"

# ====================================================
#   Install k8s tools
# ----------------------------------------------------
function k8s_tools() {
    echo "[INFO] Install k8s tools" && \
        sudo snap install helm3
}

$@
