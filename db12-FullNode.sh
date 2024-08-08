
exe=`which db12`
prefix=db12


echo Starting at `date`

./measure_power.sh 5 "db12_ALL" > measure_db12_ALL.csv &
totmpid=$!

executor="./exec_multiple.sh"
threads=`nproc`


for optth in 'single' 'wholenode'
do
	echo executing db12 with parameter ${optth}  at `date`  `date '+%s'`
	./measure_power.sh 1 "db12_${optth}" > measure_db12_${optth}.csv &
	mpid=$!
	if [[ "${optth}" == "single" ]]
	then
		th=1
	fi
	if [[ "${optth}" == "wholenode" ]]
        then
                th=$threads
        fi
	echo Measuring power with PID $mpid
	copies=$(awk "BEGIN {print ($threads / $th); exit}"|sed "s#,#.#g")
	echo Launching $copies copies of db12 with conf ${optth}
	time ${executor} $copies  ${prefix} ${exe} ${optth} >& ${prefix}_${optth}.log

	#time ${exe} ${th}  >& ${prefix}_${th}.log
	kill $mpid
done

kill $totmpid

