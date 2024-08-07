#!/bin/bash
#
# Parameters: EXE delay 'comment' 
#
measure_host=172.16.40.250

command="wget -qO- http://${measure_host}/rpc/Shelly.GetStatus|sed 's#switch:0#switch0#g'|jq '.switch0.apower'"
command2="wget -qO- http://${measure_host}/rpc/Shelly.GetStatus|sed 's#switch:0#switch0#g'|jq '.switch0.aenergy.total'"
#reset counters
wget -qO- "http://${measure_host}/rpc/Switch.ResetCounters?id=0" >& /dev/null

delay=$1
comment=$2
starttime=`date +%s`
startprecise=`perl -MTime::HiRes -e 'printf("%.0f\n",Time::HiRes::time()*1000)'`
echo COMMENT $comment START
np=`nproc`

while [ True ]
do
        newcpu=`head -n1 /proc/stat`
        pw=$(eval $command)
        en=$(eval $command2)
        curtime=`date +%s`
        curprecise=`perl -MTime::HiRes -e 'printf("%.0f\n",Time::HiRes::time()*1000)'`
        runtimeprecise=$((curprecise-startprecise))
        runtime=$((curtime-starttime))
        cpuusage=`printf "$prevcpu\n$newcpu"|awk '/^cpu /{u=$2-u;s=$4-s;i=$5-i;w=$6-w}END{print (0.0+100*(u+s+w)/(u+s+i+w))}'`
        j=$(awk "BEGIN {print $en*3600; exit}"|sed "s#,#.#g")
        totcpu=$(awk "BEGIN {print $np*$cpuusage; exit}"|sed "s#,#.#g")
        echo `date` `date "+%s"` $runtimeprecise ms $pw  W $en Wh $j J $totcpu cpu% `nproc` hostThreads
        prevcpu=`head -n1 /proc/stat`
	sleep $delay
done	
