#!/bin/bash

# executes N copies of the same file and waits for all of them

N=$1
prefix=$2
exe=$3
param=$4
files_to_be_copied=$5

pids=()

based=`mktemp -d -p . -t ${prefix}.XXX`
cd $based

for i in $(seq 1 $N)
do
    dir=`mktemp -d -p .`
    cd $dir
    ls
    if [ ! -z $4 ] 
    then
       cp ../../${param} .
    fi
    if [ ! -z $5 ]
    then
        cp ../../${files_to_be_copied} .
    fi
    time ${exe} ${param} >& ${prefix}.log &
    pids[${i}]=$!
    cd ..
done    

# wait for all pids
for pid in ${pids[*]}; do
    wait $pid
done
cd ..
rm -rf $based
