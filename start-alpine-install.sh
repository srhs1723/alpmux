#!/bin/bash

# Alpmux - Start Alpine for the first time to install it.

echo "Starting Alpine Linux for installation..."

# Change to the Alpine directory
cd $HOME/alpine-linux

# Get the ISO file name
ISO_FILE=$(ls *.iso)

if [ -z "$ISO_FILE" ]; then
    echo "Error: Alpine ISO file not found. Please run install.sh first."
    exit 1
fi

# Start QEMU for installation
qemu-system-x86_64 -smp 2 -m 2048 \
  -drive file=alpine.qcow2,if=virtio \
  -netdev user,id=n1,hostfwd=tcp::2222-:22 \
  -device virtio-net,netdev=n1 \
  -cdrom "$ISO_FILE" -boot d \
  -nographic

echo "After installation, run 'poweroff' in the Alpine VM."
echo "Then you can start the VM with start-alpine.sh"
