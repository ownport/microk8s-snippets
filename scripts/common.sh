#!/bin/bash

# colors for printing
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

function help() {
    echo "./manage.sh <command>"
    echo "  help            - this help"
    echo "  upgrade         - upgrade Ubuntu packages"
    echo "  install         - install apt package(-s)"
    echo "  console         - install console tools"
    echo "  server          - install server tools"
}

function upgrade() {
    info "Upgrade Ubuntu packages" && \
        sudo apt update && sudo apt upgrade -y 
}

function apt_install() {
    sudo apt install -y --no-install-recommends $@
}

function console() {
    info "Install console tools" && \
        apt_install \
            git tilix
}

function server() {
    info "Install OpenSSH server" && \
        apt_install openssh-server
}
