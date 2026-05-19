#!/bin/bash

# =========================================================
# Script Name: process_monitor.sh
# Description: Linux process monitoring script
# Author: David Gottlieb SITTI
# Project: Linux Server Administration & Automation Toolkit
# =========================================================

SCRIPT_DIR="$(dirname "$(realpath "$0")")"
LOG_DIR="$SCRIPT_DIR/../../logs"
LOG_FILE="$LOG_DIR/monitoring.log"

TOTAL_PROCESSES=$(ps -e --no-headers | wc -l)

echo ""
echo "========================================="
echo "      PROCESS MONITOR REPORT"
echo "========================================="
echo "Total Running Processes : $TOTAL_PROCESSES"
echo ""

echo "---------- TOP CPU PROCESSES ----------"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -6

echo ""

echo "---------- TOP MEMORY PROCESSES ----------"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -6

echo ""

# Logging
echo "$(date) - Process monitoring executed" >> "$LOG_FILE"
