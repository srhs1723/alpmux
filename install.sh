#!/bin/bash

# Alpmux - Termux with emulated Alpine environment
# Installation script

echo "Starting Alpmux installation..."

# Update Termux packages
echo "Updating Termux packages..."
pkg update -y
pkg upgrade -y

# Install dependencies
echo "Installing dependencies (QEMU)..."
pkg install qemu-system-x86-64-headless qemu-utils -y

# Create directory for Alpine
echo "Creating Alpine directory..."
mkdir -p $HOME/alpine-linux
cd $HOME/alpine-linux

# Download Alpine ISO
echo "Downloading Alpine Linux ISO..."
# Using a recent version, but you can change this URL to a different version if needed
wget https://dl-cdn.alpinelinux.org/alpine/v3.16/releases/x86_64/alpine-virt-3.16.2-x86_64.iso

# Create disk image
echo "Creating disk image..."
qemu-img create -f qcow2 alpine.qcow2 15G

echo "Installation complete!"
echo "Next, run start-alpine.sh to begin the Alpine Linux setup."
