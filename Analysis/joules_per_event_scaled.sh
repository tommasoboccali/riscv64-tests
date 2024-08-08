#!/bin/bash

files_pattern=measure_ParFullCMS_THREADS.csv_example

filename=`sed "s/THREADS/1/g" <<< $files_pattern`
tot_1=`tail -1 $filename | cut -d, -f 5`

echo Threads 1 Scaled Energy 1

for th in 2 4 8 16 32 64
do
    filename=`sed "s/THREADS/$th/g" <<< $files_pattern`
    echo $filename
    tot_j=`tail -1 $filename | cut -d, -f 5`
#    echo $tot_1 $tot_j
    scaled_tot_j=$(awk "BEGIN {print $tot_j/${th}/$tot_1; exit}"|sed "s#,#.#g")
    echo Threads ${th} Scaled Energy Per Event ${scaled_tot_j}

done