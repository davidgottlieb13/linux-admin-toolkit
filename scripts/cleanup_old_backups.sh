#!/bin/bash

# =========================================================
# Script Name: cleanup_old_backups.sh
# Description: Automated old backup cleanup script
# Author: David Gottlieb SITTI
# Project: Linux Server Administration & Automation Toolkit
# =========================================================

BACKUP_DIR="/opt/backups"
SCRIPT_DIR="$(dirname "$(realpath "$0")")"
LOG_DIR="$SCRIPT_DIR/../logs"
LOG_FILE="$LOG_DIR/backup.log"
RETENTION_DAYS=7

# Verify backup directory exists
if [[ ! -d "$BACKUP_DIR" ]]; then
    echo "[-] Backup directory does not exist."
    exit 1
fi

# Count old backups before deletion
OLD_BACKUPS=$(find "$BACKUP_DIR" -name "*.tar.gz" -mtime +$RETENTION_DAYS | wc -l)

# Delete old backups
find "$BACKUP_DIR" -name "*.tar.gz" -mtime +$RETENTION_DAYS -exec rm -f {} \;

# Logging
echo "$(date) - Cleanup completed. Removed $OLD_BACKUPS old backup(s)." >> "$LOG_FILE"

# Display summary
echo ""
echo "========================================="
echo " Old backups cleanup completed"
echo "========================================="
echo "Retention Policy : $RETENTION_DAYS days"
echo "Deleted Backups  : $OLD_BACKUPS"
echo ""
