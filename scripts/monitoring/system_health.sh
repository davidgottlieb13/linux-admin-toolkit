#!/bin/bash

# =========================================================
# Script Name: system_health.sh
# Description: Linux system health monitoring script
# Author: David Gottlieb SITTI
# Project: Linux Server Administration & Automation Toolkit
# =========================================================

SCRIPT_DIR="$(dirname "$(realpath "$0")")"
LOG_DIR="$SCRIPT_DIR/../../logs"
LOG_FILE="$LOG_DIR/monitoring.log"

HOSTNAME=$(hostname)
UPTIME=$(uptime -p)
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
MEMORY_USAGE=$(free | awk '/Mem:/ {printf("%.2f"), $3/$2 * 100}')
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}')
IP_ADDRESS=$(hostname -I)

echo ""
echo "========================================="
echo "      SYSTEM HEALTH REPORT"
echo "========================================="
echo "Hostname       : $HOSTNAME"
echo "Uptime         : $UPTIME"
echo "CPU Usage      : $CPU_USAGE%"
echo "Memory Usage   : $MEMORY_USAGE%"
echo "Disk Usage     : $DISK_USAGE"
echo "IP Address     : $IP_ADDRESS"
echo ""

# Logging
echo "$(date) - System health check executed" >> "$LOG_FILE"
