
exe=`which db12`
prefix=db12


echo Starting at `date`

./measure_power.sh 5 "db12_ALL" > measure_db12_ALL.csv &
totmpid=$!


for th in 'single' 'wholenode'
do
	echo executing db12 with parameter ${th}  at `date`  `date '+%s'`
	./measure_power.sh 1 "db12_${th}" > measure_db12_${th}.csv &
	mpid=$!
	echo Measuring power with PID $mpid
	time ${exe} ${th}  >& ${prefix}_${th}.log
	kill $mpid
done

kill $totmpid

