#!/bin/bash
BASHRC_FILE="$HOME/.bashrc"
AUTOSTART_LINE="sh $PWD/start-alpine.sh"
if grep -q "$AUTOSTART_LINE" "$BASHRC_FILE"; then
    echo "Autostart is already enabled."
else
    echo "" >> "$BASHRC_FILE"
    echo "# Alpmux autostart" >> "$BASHRC_FILE"
    echo "$AUTOSTART_LINE" >> "$BASHRC_FILE"
    echo "Autostart enabled."
fi
