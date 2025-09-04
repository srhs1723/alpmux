#!/bin/bash

# Alpmux - Start the Alpine environment

echo "Starting Alpine Linux..."

# Change to the Alpine directory
cd $HOME/alpine-linux

# Start QEMU from the disk image
qemu-system-x86_64 -smp 2 -m 2048 \
  -drive file=alpine.qcow2,if=virtio \
  -netdev user,id=n1,hostfwd=tcp::2222-:22 \
  -device virtio-net,netdev=n1 \
  -nographic -boot c
