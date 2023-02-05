ssh-backdoor

This script is a backdoor for SSH connections. It changes the default SSH port and starts a listener on a different port.
Prerequisites

    The script should be run as a root user.
    You need to have socat installed on the target machine. If not, the script will automatically install it.

Usage

    Run the script as a root user
    Check if the SSH port is changed to 2222 by using the command cat /etc/ssh/ssh_config
    Check if the listener is running on port 3177 using socat
    Connect to the target machine using the following command: socat STDIO TCP4:TARGET_IP:3177

Security Warning

This script is provided for educational purposes only. The use of this script in any unauthorized or malicious way is strictly prohibited. The script creates a security vulnerability on the target machine and should be used with caution.
