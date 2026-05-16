#!/bin/bash

# =========================================================
# Script Name: backup.sh
# Description: Automated Linux backup script
# Author: David Gottlieb SITTI
# Project: Linux Server Administration & Automation Toolkit
# =========================================================

SOURCE_DIR="/opt/backup-sources"
BACKUP_DIR="/opt/backups"
SCRIPT_DIR="$(dirname "$(realpath "$0")")"
LOG_DIR="$SCRIPT_DIR/../logs"
LOG_FILE="$LOG_DIR/backup.log"

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_NAME="backup_$TIMESTAMP.tar.gz"

# Verify source directory
if [[ ! -d "$SOURCE_DIR" ]]; then
    echo "[-] Source directory does not exist."
    exit 1
fi

# Verify backup directory
if [[ ! -d "$BACKUP_DIR" ]]; then
    echo "[-] Backup directory does not exist."
    exit 1
fi

# Create compressed archive
tar -czf "$BACKUP_DIR/$BACKUP_NAME" "$SOURCE_DIR"

# Verify backup success
if [[ $? -eq 0 ]]; then
    echo "$(date) - Backup successful: $BACKUP_NAME" >> "$LOG_FILE"

    echo ""
    echo "========================================="
    echo " Backup successfully created"
    echo "========================================="
    echo "Backup Name : $BACKUP_NAME"
    echo "Location    : $BACKUP_DIR"
    echo ""
else
    echo "$(date) - Backup failed" >> "$LOG_FILE"

    echo "[-] Backup operation failed."
    exit 1
fi
