#!/bin/bash

# =========================================================
# Script Name: auth_failure_detector.sh
# Description: SSH authentication failure detection script
# Author: David Gottlieb SITTI
# Project: Linux Server Administration & Automation Toolkit
# =========================================================

SCRIPT_DIR="$(dirname "$(realpath "$0")")"
LOG_DIR="$SCRIPT_DIR/../../logs"
LOG_FILE="$LOG_DIR/log_analysis.log"

AUTH_LOG="/var/log/auth.log"

# Verify auth log exists
if [[ ! -f "$AUTH_LOG" ]]; then
    echo "[-] Authentication log file not found."
    exit 1
fi

FAILED_ATTEMPTS=$(grep "Failed password" "$AUTH_LOG" | wc -l)

echo ""
echo "========================================="
echo "     AUTHENTICATION FAILURE REPORT"
echo "========================================="
echo "Failed SSH Attempts : $FAILED_ATTEMPTS"
echo ""

echo "---------- TOP SUSPICIOUS IPs ----------"
grep "Failed password" "$AUTH_LOG" | awk '{print $(NF-3)}' | sort | uniq -c | sort -nr | head

echo ""

echo "---------- LAST 10 FAILED ATTEMPTS ----------"
grep "Failed password" "$AUTH_LOG" | tail -10

echo ""

# Logging
echo "$(date) - Authentication failure analysis executed" >> "$LOG_FILE"
