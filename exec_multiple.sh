#!/bin/bash

# executes N copies of the same file and waits for all of them

N=$1
prefix=$2
exe=$3
param=$4

pids=()

based=`mktemp -d -p . -t ${prefix}`
cd $based

for i in $(seq 1 $N)
do
    dir=`mktemp -d -p .`
    cd $dir
    cp ../${params} .
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
