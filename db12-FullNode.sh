
exe=`which db12`
prefix=db12


echo Starting at `date`

./measure_power.sh 5 "db12_ALL" > measure_db12_ALL.csv &
totmpid=$!

executor="./exec_multiple.sh"
threads=`nproc`


for th in 'single' 'whole'
do
	echo executing db12 with parameter ${th}  at `date`  `date '+%s'`
	./measure_power.sh 1 "db12_${th}" > measure_db12_${th}.csv &
	mpid=$!
	echo Measuring power with PID $mpid
	copies=$(awk "BEGIN {print ($threads / $th); exit}"|sed "s#,#.#g")
	echo Launching $copies copies of db12 with conf ${th}
	time ${executor} $copies  ${prefix} ${exe} ${th} >& ${prefix}_${th}.log

	#time ${exe} ${th}  >& ${prefix}_${th}.log
	kill $mpid
done

kill $totmpid

