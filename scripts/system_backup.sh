#!/bin/bash

if [ "$(id -u)" != "0" ]; then
	echo 'ERROR: Script must be run as root'
	exit 1
fi

SYSTEM_DRIVE='mmcblk0'
DATA_DRIVES=('sda')
MODEL='Mass-Storage'
SERIAL='Generic_Mass-Storage-0:0'

BACKUP_DRIVE=`lsblk -i -o kname,model,serial | grep "$MODEL" | grep "$SERIAL" | awk '{ print $1 }'`

if ! [ "$BACKUP_DRIVE" ]; then
	echo 'ERROR: no backup drive, aborting'
	exit 1
fi
if [ "$BACKUP_DRIVE" == "$SYSTEM_DRIVE" ]; then
	echo 'ERROR: backup drive equals system drive, aborting'
	exit 1
fi
for drive in "${DATA_DRIVES[@]}"; do
	if [ "$BACKUP_DRIVE" == "$drive" ]; then
		echo 'ERROR: backup drive is listed as data drive, aborting'
		exit 1
	fi
done

echo "INFO: about to backup $SYSTEM_DRIVE into $BACKUP_DRIVE"

dd if="/dev/$SYSTEM_DRIVE" of="/dev/$BACKUP_DRIVE" bs=1M status=progress

exit 0
