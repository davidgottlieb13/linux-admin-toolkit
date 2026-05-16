#!/bin/bash

# =========================================================
# Script Name: create_user.sh
# Description: Automated Linux user creation script
# Author: David Gottlieb SITTI
# Project: Linux Server Administration & Automation Toolkit
# =========================================================


SCRIPT_DIR="$(dirname "$(realpath "$0")")"
LOG_DIR="$SCRIPT_DIR/../../logs"
LOG_FILE="$LOG_DIR/user_management.log"

# Check if script is executed with sudo privileges
if [[ $EUID -ne 0 ]]; then
    echo "[-] Please run this script with sudo privileges."
    exit 1
fi

# Validate arguments
if [[ $# -ne 2 ]]; then
    echo "Usage: sudo ./create_user.sh <username> <group>"
    exit 1
fi

USERNAME=$1
GROUPNAME=$2

# Check if user already exists
if id "$USERNAME" &>/dev/null; then
    echo "[-] User already exists."
    exit 1
fi

# Create group if it does not exist
if ! getent group "$GROUPNAME" > /dev/null; then
    echo "[+] Creating group: $GROUPNAME"
    groupadd "$GROUPNAME"
fi

# Generate random password
PASSWORD=$(openssl rand -base64 12)

# Create user
useradd -m -s /bin/bash -G "$GROUPNAME" "$USERNAME"

# Set password
echo "${USERNAME}:${PASSWORD}" | chpasswd

# Force password change on first login
passwd -e "$USERNAME"

# Logging
echo "$(date) - User $USERNAME created and added to group $GROUPNAME" >> "$LOG_FILE"

# Display summary
echo ""
echo "========================================="
echo " User successfully created"
echo "========================================="
echo "Username : $USERNAME"
echo "Password : $PASSWORD"
echo "Group    : $GROUPNAME"
echo ""
