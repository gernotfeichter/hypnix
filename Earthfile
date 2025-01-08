VERSION 0.8

download-iso:
    FROM netdata/wget@sha256:b367d0f3c65320eac0d574d4219c6c7c5be8d45863b9875d815e2f77d678e4a3
    WORKDIR /workdir
    # NOTE: Since nixos uses channels, after the installation new package versions etc will be downloaded.
    # So it is not that important to update this ISO base version that frequently!
    ARG NIXOS_ISO_VERSION=24.11
    RUN wget -O isoFileInput https://channels.nixos.org/nixos-${NIXOS_ISO_VERSION}/latest-nixos-gnome-x86_64-linux.iso
    SAVE ARTIFACT /workdir/isoFileInput AS LOCAL build/isoFileInput
extract-iso:
    BUILD +download-iso
    FROM backplane/7z:latest@sha256:cfa611d18f31d823db7bfe2efddeb8b8dc6d83d9785a15cde03bf995f3dc604f
    WORKDIR /workdir
    USER root
    COPY +download-iso/isoFileInput /workdir/isoFileInput
    RUN rm -rf /workdir/isoFolder && 7zz x -tiso -y /workdir/isoFileInput -o/workdir/isoFolder
    SAVE ARTIFACT isoFolder AS LOCAL build/isoFolder
extract-squash-fs:
    BUILD +extract-iso
    FROM linuxkit/mkimage-squashfs:a61fd76227ab4998d6c1ba17229cd8bd749e8f13
    WORKDIR /workdir/input
    COPY +extract-iso/isoFolder/nix-store.squashfs /workdir/input/nix-store.squashfs
    WORKDIR /workdir/output
    RUN unsquashfs /workdir/input/nix-store.squashfs
    SAVE ARTIFACT /workdir/output/squashfs-root AS LOCAL build/squashfs-root
patch-squash-fs:
    BUILD +extract-squash-fs
    FROM linuxkit/mkimage-squashfs:a61fd76227ab4998d6c1ba17229cd8bd749e8f13
    WORKDIR /workdir
    COPY +extract-squash-fs/squashfs-root /workdir/squashfs-root-patched
    COPY src/calamares-nixos-extensions/config/ /workdir/squashfs-root-patched/vxzvcmrq3ljxwa5qb3jb5aqq2mvhb23x-calamares-nixos-extensions-0.3.19/share/calamares/config/
    COPY src/calamares-nixos-extensions/modules/ /workdir/squashfs-root-patched/vxzvcmrq3ljxwa5qb3jb5aqq2mvhb23x-calamares-nixos-extensions-0.3.19/lib/calamares/modules/
    SAVE ARTIFACT /workdir/squashfs-root-patched/ AS LOCAL build/squashfs-root-patched
pack-squash-fs:
    BUILD +patch-squash-fs
    FROM linuxkit/mkimage-squashfs:a61fd76227ab4998d6c1ba17229cd8bd749e8f13
    WORKDIR /workdir
    COPY +patch-squash-fs/squashfs-root-patched /workdir/squashfs-root-patched
    RUN mksquashfs /workdir/squashfs-root-patched /workdir/nix-store.squashfs
    SAVE ARTIFACT /workdir/nix-store.squashfs AS LOCAL build/nix-store.squashfs

all:
    BUILD +pack-squash-fs