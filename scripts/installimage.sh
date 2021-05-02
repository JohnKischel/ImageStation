#!/bin/sh

get_logtime(){
	LOGTIME=$(date +%d.%h_%H:%M:%S)
	echo $LOGTIME
}

DEVPATH="$1"
SCRIPTROOT=$(dirname $0)
LOGPATH=$(realpath $SCRIPTROOT/../log/)
IMAGEPATH=$(realpath $SCRIPTROOT/../currentiso/*.iso)
echo "$(get_logtime)> Script was triggered by udev and started." >> $LOGPATH/install.log
echo "$(get_logtime)> DEVPATH=$DEVPATH" >> $LOGPATH/install.log 


if [ -e $IMAGEPATH ]
then
	# Delete the mbr.
	dd if="/dev/zero" of=$DEVPATH count=1 bs=512 && echo "$(get_logtime)> Deleted MBR of $DEVPATH" >> $LOGPATH/install.log && sudo dd if=$IMAGEPATH of=$DEVPATH bs=1M & 

	# Start the copy job and export the process id for later usage.
	export APP_PID=$!
	if [ ! -z "$APP_PID" ]
	then
		echo "$(get_logtime)> Starting installation to $DEVPATH with image $IMAGEPATH" >> $LOGPATH/install.log
		echo "$(get_logtime)> Process id of dd: $APP_PID" >> $LOGPATH/install.log
		while [ -e "/proc/$APP_PID" ]
		do
			$(echo "$(get_logtime)> Process id: $APP_PID" >> $LOGPATH/install.log)
			sleep 5s
			if [ ! -e /proc/$APP_ID ]
			then
				$(echo "----- Script finished -----" >> $LOGPATH/install.log)
			fi
		done
	fi	
	$(echo "----- Script finished -----" >> $LOGPATH/install.log)
	$(sync)
else
	$(echo "No iso detected exiting script." >> $LOGPATH/install.log)
fi

