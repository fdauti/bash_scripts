#!/bin/bash
if [ $USER != "root" ]
then
   echo "You must be logged in as root to run the command."
   echo "Either login as root or issue command as sudo"
   exit 1
fi

read -p "Update Host? (y|n):" answer # prompt if all VMs to be backed-up

if [ "$answer" = "y" ] 
then
 echo -e "\e[32m Updating Host \e[0m"
 yum update

else

read -p "Update all VMs? (y|n):" answer # prompt if all VMs to be backed-up

if [ "$answer" = "y" ] # Backup all VMs if answer is yes
then

for i in {1..3}
do
 echo ''
 echo -e "\e[32m Updating VM$i \e[0m"
 ssh root@192.168.92.$(($i+1)) yum update
done

echo ''
echo -e "\e[32m All updates done! \e[0m"

elif [ "$answer" = "n" ]
then
 read -p "Which VM should be updated? (1/2/3): " numanswer
 
 until echo $numanswer | grep "^[123]$" >> /dev/null # Look for match of single digit: 1,2, or 3
 do
  read -p "Invalid Selection. Select 1, 2, or 3: " numanswer
 done
 echo "Updating VM #$numanswer"
 ssh root@192.168.92.$(($numanswer+1)) yum update
 echo "VM$numanswer BACKUP DONE"

else
 echo "Invalid Selection... Aborting program"
 exit 2
fi

fi
