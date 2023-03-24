#!/usr/bin/bash

# Finds the first device on disk and sets it as the install destination for
# coreos.
set -eux


if [ -b /dev/vda ]; then
    install_device='/dev/vda'
elif [ -b /dev/sda ]; then
    install_device='/dev/sda'
elif [ -b /dev/nvme0 ]; then
    install_device='/dev/nvme0'
else
    echo "Can't find appropriate device to install to" 1>&2
    return 1
fi

echo "dest-device: ${install_device}" > /etc/coreos/installer.d/99-custom.yaml


# TODO add service discovery for the k3s cluster inside network