#!/bin/bash

# =========================================================
# Script Name: delete_user.sh
# Description: Automated Linux user deletion script
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
    echo "Usage: sudo ./delete_user.sh <username>"
    exit 1
fi

USERNAME=$1

# Check if user exists
if ! id "$USERNAME" &>/dev/null; then
    echo "[-] User does not exist."
    exit 1
fi

# Prevent deletion of critical accounts
if [[ "$USERNAME" == "root" ]]; then
    echo "[-] Root account cannot be deleted."
    exit 1
fi

# Delete user and home directory
userdel -r "$USERNAME"

# Logging
echo "$(date) - User $USERNAME deleted from the system" >> "$LOG_FILE"

# Display summary
echo ""
echo "========================================="
echo " User successfully deleted"
echo "========================================="
echo "Username : $USERNAME"
echo ""
