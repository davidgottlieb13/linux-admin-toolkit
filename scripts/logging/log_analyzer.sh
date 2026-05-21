#!/bin/bash

# =========================================================
# Script Name: log_analyzer.sh
# Description: Linux system log analysis script
# Author: David Gottlieb SITTI
# Project: Linux Server Administration & Automation Toolkit
# =========================================================

SCRIPT_DIR="$(dirname "$(realpath "$0")")"
LOG_DIR="$SCRIPT_DIR/../../logs"
LOG_FILE="$LOG_DIR/log_analysis.log"

SYSLOG="/var/log/syslog"

# Verify syslog exists
if [[ ! -f "$SYSLOG" ]]; then
    echo "[-] System log file not found."
    exit 1
fi

ERROR_COUNT=$(grep -i "error" "$SYSLOG" | wc -l)
WARNING_COUNT=$(grep -i "warning" "$SYSLOG" | wc -l)

echo ""
echo "========================================="
echo "         SYSTEM LOG ANALYSIS"
echo "========================================="
echo "Errors Detected   : $ERROR_COUNT"
echo "Warnings Detected : $WARNING_COUNT"
echo ""

echo "---------- LAST 10 SYSLOG EVENTS ----------"
tail -10 "$SYSLOG"
echo ""

# Show last 10 errors
if [[ $ERROR_COUNT -gt 0 ]]; then
    echo "---------- LAST 10 ERRORS ----------"
    grep -i "error" "$SYSLOG" | tail -10
    echo ""
fi

# Show last 10 warnings
if [[ $WARNING_COUNT -gt 0 ]]; then
    echo "---------- LAST 10 WARNINGS ----------"
    grep -i "warning" "$SYSLOG" | tail -10
    echo ""
fi

# Logging
echo "$(date) - Log analysis executed (Errors: $ERROR_COUNT, Warnings: $WARNING_COUNT)" >> "$LOG_FILE"
