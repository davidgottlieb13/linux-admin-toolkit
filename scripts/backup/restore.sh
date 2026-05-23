#!/bin/bash

# =========================================================
# Script Name: restore.sh
# Description: Linux backup restoration script
# Author: David Gottlieb SITTI
# Project: Linux Server Administration & Automation Toolkit
# =========================================================

BACKUP_DIR="/opt/backups"
RESTORE_DIR="/opt/restore"

SCRIPT_DIR="$(dirname "$(realpath "$0")")"
LOG_DIR="$SCRIPT_DIR/../../logs"
LOG_FILE="$LOG_DIR/backup.log"

# Validate arguments
if [[ $# -ne 1 ]]; then
    echo "Usage: ./restore.sh <backup_file.tar.gz>"
    exit 1
fi

BACKUP_FILE=$1

# Verify backup archive exists
if [[ ! -f "$BACKUP_DIR/$BACKUP_FILE" ]]; then
    echo "[-] Backup archive not found."
    exit 1
fi

# Verify restore directory exists
if [[ ! -d "$RESTORE_DIR" ]]; then
    echo "[-] Restore directory does not exist."
    exit 1
fi

# Extract archive
tar -xzf "$BACKUP_DIR/$BACKUP_FILE" -C "$RESTORE_DIR"

# Verify restore success
if [[ $? -eq 0 ]]; then
    echo "$(date) - Restore successful: $BACKUP_FILE" >> "$LOG_FILE"

    echo ""
    echo "========================================="
    echo " Restore successfully completed"
    echo "========================================="
    echo "Archive : $BACKUP_FILE"
    echo "Location: $RESTORE_DIR"
    echo ""
else
    echo "$(date) - Restore failed: $BACKUP_FILE" >> "$LOG_FILE"

    echo "[-] Restore operation failed."
    exit 1
fi
