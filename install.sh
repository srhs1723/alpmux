#!/bin/bash

# Alpmux - Installation script

set -euo pipefail

echo "Starting Alpmux installation..."

# --- Dependencies ---
echo "Installing dependencies..."
pkg update -y && pkg upgrade -y
pkg install qemu-system-x86-64-headless qemu-utils wget xorriso cpio gzip -y

# --- Build Modified ISO ---
echo "Building modified Alpine ISO..."
chmod +x build-iso.sh
./build-iso.sh

# --- Create Virtual Disks ---
echo "Creating virtual disks..."
# Main disk for Alpine Linux
qemu-img create -f qcow2 alpine.qcow2 15G
# User data disk
qemu-img create -f qcow2 userdata.qcow2 5G

echo "Installation of Alpmux components complete."
echo "Next, run start-alpine-install.sh to begin the Alpine Linux installation."
echo "During the installation, you will need to format the user data disk."
echo "Please refer to the README.md for instructions."
