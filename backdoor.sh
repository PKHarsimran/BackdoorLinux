#!/usr/bin/env bash
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit
fi
 #exit out if user ran the script without root
echo "Script running ... .. .. ."
useradd -rMo -u 300 -p p4ssw0rd sysd #create a secret user with no home, and uid with 300
echo "Created secret user ..... .. . ."
cat /etc/passwd | grep -i sysd #check if user is created
#check if user has proper privileges for sysd mean u did the HW
# visudo < this will edit the sudoer file
# then look for sysd priv in file
# add 'NOPASSWD:ALL' to end of 'sysd ALL=(ALL:ALL) '
# sysd ALL=(ALL) NOPASSWD:ALL
# hopefully you have completed that
# then check if user has no password privileges
var=$(cat /etc/sudoer.tmp | grep -i sysd | awk '{ print $3 }')
vareql="NOPASSWD:ALL"
if [ $var != $vareql ]; then
  echo "Error sudoer file is not properly configured .. .. ."
  exit
fi
