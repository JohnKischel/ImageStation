#!/bin/sh
DEVPATH="$1"
SCRIPTROOT=$(dirname $0)
IMAGEPATH=$(realpath $SCRIPTROOT/../currentiso/*.iso)
LOGPATH=$(realpath $SCRIPTROOT/../log/)

sudo dd if="/dev/zero" of=$DEVPATH count=1 bs=512 && echo "Deleted MBR of $DEVPATH" >> $LOGPATH/install.log

sudo dd if=$IMAGEPATH of=$DEVPATH bs=1M & 
export APP_PID=$!
if [ ! -z "$APP_PID" ]
then
	echo "Starting installation to $DEVPATH with image $IMAGEPATH" >> $LOGPATH/install.log
	echo "Process id of dd: $APP_PID" >> $LOGPATH/install.log
	while [ -e "/proc/$APP_PID" ]
	do
		LOGTIME=$(date +%d.%h_%H:%M:%S)
		$(echo "$LOGTIME > Process id: $APP_PID" >> $LOGPATH/install.log)
		sleep 5s
		if [ ! -e /proc/$APP_ID ]
		then
			$(echo "----- Script finished -----" >> $LOGPATH/install.log)
		fi
	done
fi	
$(echo "----- Script finished -----" >> $LOGPATH/install.log)
