VERSION 0.8

download-iso:
    FROM netdata/wget@sha256:b367d0f3c65320eac0d574d4219c6c7c5be8d45863b9875d815e2f77d678e4a3
    # NOTE: Since nixos uses channels, after the installation new package versions etc will be downloaded.
    # So it is not that important to update this ISO base version that frequently!
    ARG NIXOS_ISO_VERSION=24.11
    RUN wget -O isofile https://channels.nixos.org/nixos-${NIXOS_ISO_VERSION}/latest-nixos-gnome-x86_64-linux.iso
    SAVE ARTIFACT isofile isofile AS LOCAL build/isofile

extract-iso:
    BUILD +download-iso
    FROM debian:12.8
    WORKDIR /workdir
    USER root
    COPY build/isofile /workdir/isofile
    RUN mkdir /mnt/extract
    RUN ls -la isofile && mount -o loop /workdir/isofile /mnt/extract
    RUN ls -la /mnt/extract

all:
    BUILD +download-iso
    BUILD +extract-iso
