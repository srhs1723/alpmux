#!/bin/bash

# Alpmux - Build modified Alpine ISO
# This script downloads an official Alpine ISO, modifies the initramfs to add a
# custom banner and enables the community repository, then repacks it into a
# new ISO.

set -e # Exit on any error

# --- Configuration ---
ALPINE_VERSION="3.16.2"
ALPINE_ARCH="x86_64"
ALPINE_FLAVOR="virt"
ALPINE_ISO="alpine-${ALPINE_FLAVOR}-${ALPINE_VERSION}-${ALPINE_ARCH}.iso"
MODIFIED_ISO="alpmux-alpine.iso"
WORK_DIR="alpine_build"

# --- Banner ---
ALPMUX_BANNER_TEXT="
  ___   _   _  __  __  _   _  ____
 / _ \\ | | | | \\ \\/ / | | | |/ ___|
| | | || | | | | \\  /  | | | |\\___ \\
| |_| || |_| | | |  |  | |_| | ___) |
 \\___/  \\___/  |_|__|   \\___/ |____/

Welcome to Alpmux - Alpine Linux on Termux!
"

# --- Functions ---
check_dependencies() {
    echo "Checking for dependencies..."
    for cmd in wget xorriso cpio gzip; do
        if ! command -v "$cmd" &> /dev/null; then
            echo "Error: Command '$cmd' not found. Please install it."
            exit 1
        fi
    done
}

download_iso() {
    if [ ! -f "$ALPINE_ISO" ]; then
        echo "Downloading Alpine ISO..."
        wget "https://dl-cdn.alpinelinux.org/alpine/v${ALPINE_VERSION%.*}/releases/${ALPINE_ARCH}/${ALPINE_ISO}"
    else
        echo "Alpine ISO already downloaded."
    fi
}

extract_iso() {
    echo "Extracting ISO contents..."
    rm -rf "$WORK_DIR"
    mkdir -p "$WORK_DIR/iso_contents"
    xorriso -osirrox on -indev "$ALPINE_ISO" -extract / "$WORK_DIR/iso_contents"
}

modify_initramfs() {
    echo "Modifying initramfs..."
    cd "$WORK_DIR/iso_contents/boot"

    # Unpack initramfs
    gunzip < "initramfs-${ALPINE_FLAVOR}" > initramfs.cpio
    mkdir initramfs_contents
    cd initramfs_contents
    cpio -id < ../initramfs.cpio

    # Add banner
    echo "$ALPMUX_BANNER_TEXT" > etc/alpmux-banner
    echo 'cat /etc/alpmux-banner' > etc/profile.d/alpmux-banner.sh
    chmod +x etc/profile.d/alpmux-banner.sh

    # Enable community repository
    sed -i 's/^#\(.*\/community\)$/\1/' etc/apk/repositories

    # Repack initramfs
    find . | cpio -o -H newc | gzip > "../initramfs-${ALPINE_FLAVOR}-new.gz"
    cd .. # back to boot/
    mv "initramfs-${ALPINE_FLAVOR}-new.gz" "initramfs-${ALPINE_FLAVOR}"
    rm initramfs.cpio
    rm -rf initramfs_contents
    cd ../../.. # back to root
}

repack_iso() {
    echo "Repacking ISO..."
    cd "$WORK_DIR/iso_contents"

    # Get boot info from original ISO
    boot_info=$(xorriso -indev "../../${ALPINE_ISO}" -report_el_torito as_mkisofs)

    xorriso -as mkisofs \
        -o "../../${MODIFIED_ISO}" \
        $boot_info \
        -graft-points \
        /boot=./boot \
        /apks=./apks \
        /.alpine-release=./.alpine-release

    cd ../.. # back to root
}

cleanup() {
    echo "Cleaning up..."
    rm -rf "$WORK_DIR"
}

# --- Main ---
check_dependencies
download_iso
extract_iso
modify_initramfs
repack_iso
cleanup

echo "Modified ISO created successfully: $MODIFIED_ISO"
