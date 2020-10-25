#!/bin/bash

set -e

source $(pwd)/common.sh

function k8s_tools() {
    echo "[INFO] Install k8s tools" && \
        sudo snap install helm3
}

$@
