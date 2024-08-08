exe=/usr/bin/sleep
events_per_thread=100
prefix=G4_NullTest

echo Starting at `date`

for th in 1 
do
	echo executing NullTest \(sleep\) ParFullCMS at ${th} threads and $events_per_thread events at `date`  `date '+%s'`
	./measure_power.sh 1 "NullTest_${th}" > measure_NullTest_${th}.csv &
	mpid=$!
	echo Measuring power with PID $mpid
	time  $exe $events_per_thread>& ${prefix}_${th}.log
	kill $mpid
done

