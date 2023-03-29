.PHONY: release

release: download-coreos ignite-butane build-server-iso build-agent-iso

clean:
	rm -rf build

download-coreos:
	test -d ./build || mkdir build
	podman run --security-opt label=disable --pull=always --rm -v .:/data -w /data/build \
		quay.io/coreos/coreos-installer:release download -s next -p metal -f iso

ignite-butane:
	podman run --rm -v .:/data -w /data \
		quay.io/coreos/butane:latest butane/dest.bu -d butane/resources --pretty > ./build/ignition.ign

server_iso = "k3s-server.iso"
iso = $(notdir $(wildcard build/fedora*.iso))
build-server-iso:
	rm -f build/$(server_iso) || echo "No need to clean up"
	podman run --security-opt label=disable --rm -v ./:/data -w /data \
		quay.io/coreos/coreos-installer:release iso customize \
		--network-nmstate butane/resources/static.nmstate.yml \
		--dest-ignition build/ignition.ign \
		--pre-install butane/resources/pre-install.sh \
		-o build/$(server_iso) build/$(iso)

agent_iso = "k3s-agent.iso"
build-agent-iso:
	rm -f build/$(agent_iso) || echo "No need to clean up"
	podman run --security-opt label=disable --rm -v ./:/data -w /data \
		quay.io/coreos/coreos-installer:release iso customize \
		--dest-ignition build/ignition.ign \
		--pre-install butane/resources/pre-install.sh \
		-o build/$(agent_iso) build/$(iso)