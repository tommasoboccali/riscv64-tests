#!/bin/bash
#
# Parameters: EXE delay 'comment' 
#
measure_host=192.168.1.1

command="wget -qO- http://${measure_host}/status | jq '.meters[0].power'"

delay=$1
comment=$2

command='echo pippo'
#echo $command
#
echo COMMENT $comment START

while [ True ]
do
	echo `date` `date "+%s"` `$command` W
	sleep $delay
done	
