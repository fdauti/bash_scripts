#!/bin/bash

#if [ $PWD != "/root/bin" ] # only runs if in root's directory
#then
# echo "You must be located in /root" >&2
# exit 1
#fi

read -p "Backup all VMs? (y|n):" answer # prompt if all VMs to be backed-up

if [ "$answer" = "y" ] # Backup all VMs if answer is yes
then
 for num in 1 2 3 # Determinant loop for 3 arguments: 1, 2, and 3
 do
  echo "Backing up VM #$num"
  gzip < /var/lib/libvirt/images/vm$num.qcow2 > /backup/full/vm$num.qcow2.bak.gz
  echo "VM #$num BACKUP DONE"
 done

elif [ "$answer" = "n" ]
then
 read -p "Which VM should be backed up? (1/2/3): " numanswer
 
 until echo $numanswer | grep "^[123]$" >> /dev/null # Look for match of single digit: 1,2, or 3
 do
  read -p "Invalid Selection. Select 1, 2, or 3: " numanswer
 done
 echo "Backing up VM #$numanswer"
 gzip < /var/lib/libvirt/images/vm$numanswer.qcow2 > /backup/full/vm$numanswer.qcow2.bak.gz
 echo "VM #$numanswer BACKUP DONE"

else
 echo "Invalid Selection... Aborting program"
 exit 2
fi

