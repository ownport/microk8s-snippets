#!/bin/bash

# exit immediately on error
set -e
# fail on undeclared variables
set -u 

# Grab the directory of the scripts, in case the script is invoked from a different path
SCRIPTS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

# ====================================================
#   Colors for printing
# ----------------------------------------------------
RED='\033[1;31m'
BLUE='\033[0;36m'
NC='\033[0m' # No Color

# ====================================================
#   Common Functions
# ----------------------------------------------------
function info() {
    printf "${BLUE}[INFO] ${@}${NC}\n"
}

function error() {
    printf "${RED}[ERROR] ${@}${NC}\n"
}

# Print the error and exit with status code 1
function error_and_exit() {
    error ${@}
    exit 1
}

# ====================================================
#   Help screen
# ----------------------------------------------------
function help() {
    echo "./manage.sh <command>"
    echo "  help            - this help"
    echo "  upgrade         - upgrade Ubuntu packages"
    echo "  install         - install apt package(-s)"
    echo "  console         - install console tools"
    echo "  server          - install server tools"
}

# ====================================================
#   Upgrade system
# ----------------------------------------------------
function upgrade() {
    info "Upgrade Ubuntu packages" && \
        sudo apt update && sudo apt upgrade -y 
}

# ====================================================
#   apt install
# ----------------------------------------------------
function apt_install() {
    sudo apt install -y --no-install-recommends $@
}

# ====================================================
#   Install console tools
# ----------------------------------------------------
function console() {
    info "Install console tools" && \
        apt_install \
            git tilix
}

# ====================================================
#   Install server tools
# ----------------------------------------------------
function server() {
    info "Install OpenSSH server" && \
        apt_install openssh-server
}
