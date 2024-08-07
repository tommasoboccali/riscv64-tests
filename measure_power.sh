#!/bin/bash
#
# Parameters: EXE delay 'comment' 
#
measure_host=192.168.139.121

command="wget -qO- http://${measure_host}/rpc/Shelly.GetStatus|sed 's#switch:0#switch0#g'|jq '.switch0.apower'"
command2="wget -qO- http://${measure_host}/rpc/Shelly.GetStatus|sed 's#switch:0#switch0#g'|jq '.switch0.aenergy.total'"
#reset counters
wget -qO- "http://${measure_host}/rpc/Switch.ResetCounters?id=0" >& /dev/null

delay=$1
comment=$2
starttime=`date +%s`
echo COMMENT $comment START

while [ True ]
do
        pw=$(eval $command)
        en=$(eval $command2)
        curtime=`date +%s`
        runtime=$((curtime-starttime))
        j=$(awk "BEGIN {print $en*3600; exit}"|sed "s#,#.#g")
	echo `date` `date "+%s"` $runtime s $pw  W $en Wh $j J
	sleep $delay
done	
