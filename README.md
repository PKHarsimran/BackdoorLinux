# Security Testing Scripts - Back door linux via ssh 

This repository contains two Bash scripts designed for security testing in controlled environments. These scripts should be used only with proper authorization and in compliance with all applicable laws and ethical guidelines.Prerequisites

## Scripts

1. **backdoor.sh**: This script performs various operations like creating a user, modifying SSH configurations, and setting up a `socat` listener.

2. **sessionCreator.sh**: This script attempts to establish SSH and `socat` connections to a specified target machine to test access and connectivity.


#### How to Run

    The script should be run as a root user.
    You need to have socat installed on the target machine. If not, the script will automatically install it.

Usage

    Run the script as a root user
    Check if the SSH port is changed to 2222 by using the command cat /etc/ssh/ssh_config
    Check if the listener is running on port 3177 using socat
    Connect to the target machine using the following command: socat STDIO TCP4:TARGET_IP:3177

Security Warning

This script is provided for educational purposes only. The use of this script in any unauthorized or malicious way is strictly prohibited. The script creates a security vulnerability on the target machine and should be used with caution.
