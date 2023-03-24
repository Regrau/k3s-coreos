#!/usr/bin/bash

set -x

main() {
        export K3S_KUBECONFIG_MODE="644"
        export INSTALL_K3S_EXEC=" --disable servicelb --disable traefik"
        curl -sfL https://get.k3s.io | sh -
        return 0
}

main
