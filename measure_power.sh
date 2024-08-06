#!/bin/bash
#
# Parameters: EXE delay 'comment' 
#
measure_host=192.168.139.121

command="wget -qO- http://${measure_host}/rpc/Shelly.GetStatus|sed 's#switch:0#switch0#g'|jq '.switch0.apower'"

delay=$1
comment=$2

echo COMMENT $comment START

while [ True ]
do
        pw=$(eval $command)
	echo `date` `date "+%s"` $pw  W
	sleep $delay
done	
