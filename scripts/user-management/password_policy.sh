#!/bin/bash

# =========================================================
# Script Name: password_policy.sh
# Description: Linux password policy configuration script
# Author: David Gottlieb SITTI
# Project: Linux Server Administration & Automation Toolkit
# =========================================================

SCRIPT_DIR="$(dirname "$(realpath "$0")")"
LOG_DIR="$SCRIPT_DIR/../../logs"
LOG_FILE="$LOG_DIR/user_management.log"

# Check sudo privileges
if [[ $EUID -ne 0 ]]; then
    echo "[-] Please run this script with sudo privileges."
    exit 1
fi

# Validate arguments
if [[ $# -ne 1 ]]; then
    echo "Usage: sudo ./password_policy.sh <username>"
    exit 1
fi

USERNAME=$1

# Check if user exists
if ! id "$USERNAME" &>/dev/null; then
    echo "[-] User does not exist."
    exit 1
fi

# Apply password policy
chage -M 90 "$USERNAME"
chage -m 7 "$USERNAME"
chage -W 14 "$USERNAME"

# Logging
echo "$(date) - Password policy applied to user $USERNAME" >> "$LOG_FILE"

# Display summary
echo ""
echo "========================================="
echo " Password policy successfully applied"
echo "========================================="
echo "Username              : $USERNAME"
echo "Maximum Password Age  : 90 days"
echo "Minimum Password Age  : 7 days"
echo "Warning Period        : 14 days"
echo ""
