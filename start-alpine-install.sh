#!/bin/bash

# Alpmux - Start Alpine for the first time to install it.

set -euo pipefail

echo "Starting Alpine Linux for installation..."

ISO_FILE="alpmux-alpine.iso"
MAIN_DISK="alpine.qcow2"
USER_DISK="userdata.qcow2"

if [ ! -f "$ISO_FILE" ]; then
    echo "Error: Modified Alpine ISO not found. Please run install.sh first." >&2
    exit 1
fi

if [ ! -f "$MAIN_DISK" ] || [ ! -f "$USER_DISK" ]; then
    echo "Error: Virtual disks not found. Please run install.sh first." >&2
    exit 1
fi

qemu-system-x86_64 -smp 2 -m 2048 \
  -drive file="$MAIN_DISK",if=virtio,index=0 \
  -drive file="$USER_DISK",if=virtio,index=1 \
  -netdev user,id=n1,hostfwd=tcp::2222-:22 \
  -device virtio-net,netdev=n1 \
  -cdrom "$ISO_FILE" -boot d \
  -nographic

echo "After installation, run 'poweroff' in the Alpine VM."
echo "Then you can start the VM with start-alpine.sh"
