#!/bin/bash

set -e

source $(pwd)/common.sh

MICROK8S_CHANNEL="1.18/stable"


function help() {
    echo "./manage.sh <command>"
    echo "  help                        - this help"
    echo "  create_aliases              - create aliases: kubectl"
    echo "  fix_flannel_subnet_conf     - fix flannel subnet configuration"
    echo "  install                     - install microk8s"
}


function create_aliases() {
    if [ -f ~/.bash_aliases ]; then
        [ -z "$(cat ~/.bash_aliases | grep kubectl)" ] && {
            echo "alias kubectl='microk8s kubectl'" >> ~/.bash_aliases
        }
    else
        echo "alias kubectl='microk8s kubectl'" > ~/.bash_aliases
    fi
    source ~/.bash_aliases
}


function fix_flannel_subnet_conf() {
    FLANNEL_SUBNET_CONF="/var/snap/microk8s/common/run/flannel/subnet.env"
    sudo mkdir -p /var/snap/microk8s/common/run/flannel/ && \
    echo "FLANNEL_NETWORK=10.5.0.0/16" | sudo tee ${FLANNEL_SUBNET_CONF} && \
    echo "FLANNEL_SUBNET=10.5.72.1/24" | sudo tee -a ${FLANNEL_SUBNET_CONF} && \
    echo "FLANNEL_MTU=1450" | sudo tee -a ${FLANNEL_SUBNET_CONF} && \
    echo "FLANNEL_IPMASQ=false" | sudo tee -a ${FLANNEL_SUBNET_CONF}
}


function install() {
    info "Install microk8s, 1.18/stable" && \
        sudo snap install microk8s --classic --channel ${MICROK8S_CHANNEL} && \
    info "Update user rights/permissions for local use" && \
        sudo usermod -a -G microk8s drey && \
        sudo chown -f -R drey ~/.kube
        
    info "Activate microk8s plugins" && \
        sudo microk8s enable \
            dns helm3 storage registry 
}

$@

