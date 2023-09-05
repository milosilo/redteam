#!/bin/bash
# Bash History copy Script
# This script detects the location of a user's Bash history file and copies it to a specified destination.
# Usage: bash BashHistoryBackup.sh /path/to/backup/folder

destination_path="$1"
current_user=$(whoami)
history_path="$HOME/.bash_history"

if [ -f "$history_path" ]; then
    cp "$history_path" "$destination_path"
    echo "Bash history copied to $destination_path"
else
    echo "Bash history file not found for user $current_user"
fi
