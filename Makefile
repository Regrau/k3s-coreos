.PHONY: release

release: download-coreos ignite-butane customize-metal-iso


download-coreos:
	test -d ./build || mkdir build
	podman run --security-opt label=disable --pull=always --rm -v .:/data -w /data/build \
		quay.io/coreos/coreos-installer:release download -s next -p metal -f iso

ignite-butane:
	podman run --rm -v .:/data -w /data \
		quay.io/coreos/butane:latest butane/dest.bu -d butane/resources --pretty > ./build/ignition.ign

iso = $(notdir $(wildcard build/fedora*.iso))
customize-metal-iso:
	podman run --security-opt label=disable --rm -v ./:/data -w /data \
		quay.io/coreos/coreos-installer:release iso customize \
		--dest-ignition build/ignition.ign \
		--pre-install butane/resources/pre-install.sh \
		-o build/custom.iso build/$(iso)
