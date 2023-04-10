# What is this
## Goal
This repository will provide a way to  deploy a k3s cluster node for node.
It will have all the necessary files to create an installable `.iso` image for
a bare metal install of core os.
Based on a config file the iso will either install a server or an agent of
an already existing cluster.

It is intended for homelab use on machines like the Beelink Mini S where only
one single drive is provided. This drive will be completely wiped during the
installation process.


Cluster Network
10.0.0.0/24

dependencies:
- podman
- taskfile
- gomplate
