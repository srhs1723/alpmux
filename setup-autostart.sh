#!/bin/bash

set -euo pipefail

BASHRC_FILE="$HOME/.bashrc"
AUTOSTART_LINE="sh $PWD/start-alpine.sh"

touch "$BASHRC_FILE"
if grep -Fq "$AUTOSTART_LINE" "$BASHRC_FILE"; then
    echo "Autostart is already enabled."
else
    {
        echo ""
        echo "# Alpmux autostart"
        echo "$AUTOSTART_LINE"
    } >> "$BASHRC_FILE"
    echo "Autostart enabled."
fi
