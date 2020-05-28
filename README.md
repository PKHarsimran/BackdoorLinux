# BackdoorLinux
Instructions
Get started by logging into the VM as root.

In this step, you'll create a "secret" user named sysd. Anyone examining /etc/passwd will assume this to be a service account, but in fact, you'll be using it to reconnect to the machine for further exploitation.
Make sure to give your sysd user:

A password
A System UID (i.e., UID < 1000)
A GID equal to this UID
Full, password-less sudo access

In addition, minimize exposure by ensuring that your secret user does not have a home folder.
Test that your sysd user can execute commands with sudo access without a password before moving on.

Smooth Sailing
In this step, you'll allow SSH access via port 2222. SSH usually runs on port 22, but opening port 2222 will allow you to log in as your secret user without connecting to the standard (and well-guarded) port 22.
This will require some research. Start by examining /etc/ssh/sshd_config and using Google or the man pages to learn more about the available configuration options.
When you think you've configured things properly, test your solution by:

Noting the IP address of the system
Exiting the root account, and logging off of the machine
Using your local command line to SSH into the system as your sysd user

Use Git bash for this on Windows, and Terminal on OS X.



Once you are connected over SSH, use sudo to switch back to the root user.
Note that this was an important step. You were able to log out of your root account, and then reestablish a session with escalated privileges.
The ensuing steps will make this backdoor even subtler and, therefore, more effective.

Two doors are better than one.
What happens if someone discovers the sysd account and removes it? For this reason, hackers often install more than one backdoor.
Next, you will use a program called socat to create a second backdoor. Socat allows you to easily connect to a machine and can provide a bash shell without using ssh.
Use this article Socat: The General Bidirectional Pipe Handler to learn more about it and what it can do.
After reading the article, install socat and use the following command to open a Listener: socat TCP4-Listen:3177,fork EXEC:/bin/bash

A socat listener is a process that runs continuously and listens for connections. Once the process is running, you can send it commands and interact directly with the server from another machine.
Study the above command and use google to learn what each part is doing. In your solutions submission.md file, describe what each part of this command does.

After you start the listener, exit your ssh session and test that you can run socat commands from your local machine's command line.

Run socat STDIO TCP4:<Your-VM-IP-address>:3177 on your local machine.
The cursor should return to the next line and appear as if nothing has happened.

$ socat STDIO TCP4:<Your-VM-IP-address>:3177
|
From here you should be able to type standard bash commands.


Try a few commands like ls and cd


Once you confirm that the connection is working, exit the socat connection.


Note that as long as the socat process is running, you will be able to connect to the system. This serves as a great second backdoor incase your hidden user is compromised.
If the machine is restarted, the process will stop. To take this attack to the next level, we could create a script that continually runs a process like this in the background. That way, this connection is always available, even if the machine restarts. Furthermore, we could include scripts that hide the process from utilities like ps.
Attacks like this will be further explored in the pentesting weeks of class, so for now it's enough to understand how this works and confirm the connection is operational.

Crack all the things
Next, to strengthen our foothold on this system, we will attempt to crack as many passwords as we can.
Having access to all the accounts will also allow us to access the system if our other backdoors are closed.


SSH back to the system using your sysd account.


Escalate your privileges to the root user.


Use John to crack the entire /etc/shadow file.


Note that the reality of cracking passwords is that the process just takes time. Now might be a good opportunity to grab some coffee or take a break and let the computer do the work for you.

Cover your tracks
At this point, we own this system. We have the passwords for all the users, including the root user. We have a secret user in case the other users change their passwords. We have a socat process running that allows connections.
From here, we want to hide as much evidence that we were ever on this system as we can .
We know that Linux keeps logs of everything that happens, leaving a trail for a system administrator to figure out everything you have done. Our last step? Clear the logs.

Use socat with a for loop to clear all system logs.
