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
startprecise=`perl -MTime::HiRes -e 'printf("%.0f\n",Time::HiRes::time()*1000)'`
echo COMMENT $comment START

while [ True ]
do
        pw=$(eval $command)
        en=$(eval $command2)
        curtime=`date +%s`
        curprecise=`perl -MTime::HiRes -e 'printf("%.0f\n",Time::HiRes::time()*1000)'`
        runtimeprecise=$((curprecise-startprecise))
        runtime=$((curtime-starttime))
        j=$(awk "BEGIN {print $en*3600; exit}"|sed "s#,#.#g")
	echo `date` `date "+%s"` $runtimeprecise ms $pw  W $en Wh $j J
	sleep $delay
done	
