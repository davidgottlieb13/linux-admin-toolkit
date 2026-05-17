#!/bin/bash

# =========================================================
# Script Name: disk_monitor.sh
# Description: Linux disk usage monitoring script
# Author: David Gottlieb SITTI
# Project: Linux Server Administration & Automation Toolkit
# =========================================================

SCRIPT_DIR="$(dirname "$(realpath "$0")")"
LOG_DIR="$SCRIPT_DIR/../../logs"
LOG_FILE="$LOG_DIR/monitoring.log"

THRESHOLD=80

# Get disk usage percentage
DISK_USAGE=$(df / | awk 'NR==2 {gsub("%",""); print $5}')

echo ""
echo "========================================="
echo "        DISK MONITOR REPORT"
echo "========================================="
echo "Current Disk Usage : $DISK_USAGE%"
echo "Alert Threshold    : $THRESHOLD%"
echo ""

# Compare usage against threshold
if [[ $DISK_USAGE -ge $THRESHOLD ]]; then
    echo "[WARNING] Disk usage exceeded threshold!"

    echo "$(date) - WARNING: Disk usage at ${DISK_USAGE}%" >> "$LOG_FILE"
else
    echo "[OK] Disk usage is under control."

    echo "$(date) - Disk usage healthy at ${DISK_USAGE}%" >> "$LOG_FILE"
fi

echo ""
