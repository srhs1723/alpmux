#!/bin/bash

# Alpmux - Start the Alpine environment

echo "Starting Alpine Linux..."

qemu-system-x86_64 -smp 2 -m 2048 \
  -drive file=alpine.qcow2,if=virtio,index=0 \
  -drive file=userdata.qcow2,if=virtio,index=1 \
  -netdev user,id=n1,hostfwd=tcp::2222-:22 \
  -device virtio-net,netdev=n1 \
  -nographic -boot c
