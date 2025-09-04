#!/bin/bash

# Alpmux - Setup autostart for the Alpine environment

BASHRC_FILE="$HOME/.bashrc"
AUTOSTART_LINE="sh $HOME/Alpmux/start-alpine.sh"

# Check if autostart is already enabled
if grep -q "$AUTOSTART_LINE" "$BASHRC_FILE"; then
    echo "Autostart is already enabled."
    exit 0
fi

echo "Enabling autostart..."
# Add the autostart line to .bashrc
echo "" >> "$BASHRC_FILE"
echo "# Alpmux autostart" >> "$BASHRC_FILE"
echo "$AUTOSTART_LINE" >> "$BASHRC_FILE"

echo "Autostart enabled. The Alpine environment will start automatically with new Termux sessions."
echo "To disable autostart, edit your .bashrc file and remove the Alpmux autostart lines."
