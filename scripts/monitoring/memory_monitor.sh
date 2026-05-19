#!/bin/bash

# =========================================================
# Script Name: memory_monitor.sh
# Description: Linux memory usage monitoring script
# Author: David Gottlieb SITTI
# Project: Linux Server Administration & Automation Toolkit
# =========================================================

SCRIPT_DIR="$(dirname "$(realpath "$0")")"
LOG_DIR="$SCRIPT_DIR/../../logs"
LOG_FILE="$LOG_DIR/monitoring.log"

THRESHOLD=75

# Get memory usage percentage
MEMORY_USAGE=$(free | awk '/Mem:/ {printf("%.0f"), $3/$2 * 100}')

echo ""
echo "========================================="
echo "       MEMORY MONITOR REPORT"
echo "========================================="
echo "Current Memory Usage : $MEMORY_USAGE%"
echo "Alert Threshold      : $THRESHOLD%"
echo ""

# Compare usage against threshold
if [[ $MEMORY_USAGE -ge $THRESHOLD ]]; then
    echo "[WARNING] Memory usage exceeded threshold!"

    echo "$(date) - WARNING: Memory usage at ${MEMORY_USAGE}%" >> "$LOG_FILE"
else
    echo "[OK] Memory usage is under control."

    echo "$(date) - Memory usage healthy at ${MEMORY_USAGE}%" >> "$LOG_FILE"
fi

echo ""
