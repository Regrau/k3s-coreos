#!/usr/bin/bash

set -x

INSTALLATION_KIND="server"
SERVER_HOST=10.0.0.101


install_server() {
    export K3S_KUBECONFIG_MODE="644"
    export K3S_CLUSTER_INIT="true"
    export K3S_AGENT_TOKEN_FILE=/usr/local/etc/k3s-agent-key
    export INSTALL_K3S_EXEC=" --disable servicelb --disable traefik"
    curl -sfL https://get.k3s.io | sh -
    k3s token create $(cat $K3S_AGENT_TOKEN_FILE)
    return 0
}

install_agent() {
    export K3S_KUBECONFIG_MODE="644"
    export K3S_URL=https://$SERVER_HOST:6443
    export K3S_TOKEN_FILE=/usr/local/etc/k3s-agent-key
    curl -sfL https://get.k3s.io | sh -
    return 0
}

if curl -sL $SERVER_HOST:6443; then
   INSTALLATION_KIND="agent"
fi

if [[ "$INSTALLATION_KIND" == "server" ]]; then
    install_server
elif [[ "$INSTALLATION_KIND" == "agent" ]]; then
    install_agent
else
echo "Could not decide on installation method. Aborting"
fi
