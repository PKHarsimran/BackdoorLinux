#!/usr/bin/env bash

echo "Start listening..."

# Define variables
username="user"
TARGET_IP="192.168.7.141"
ssh_password="password"

# Install sshpass if not already installed
if ! command -v sshpass &> /dev/null; then
    sudo apt-get install sshpass -y
fi

# Try SSH connection
echo "Attempting SSH connection..."
if sshpass -p "$ssh_password" ssh -o StrictHostKeyChecking=no -o ConnectTimeout=5 "$username@$TARGET_IP" -p 22 "echo connected"; then
    echo "PWNED! SSH is good."
else
    echo "No SSH access."
fi

# Try Socat access
echo "Trying Socat access..."
if echo | socat STDIO TCP4:"$TARGET_IP":3177; then
    echo "PWNED! Socat is good."
else
    echo "No Socat access."
fi
