G4Prefix=/cvmfs/datacloud.infn.it/repo/riscv64-pioneer/geant4/
#G4Prefix=/scratch/G4/INSTALL

source ${G4Prefix}/bin/geant4.sh

exe=/cvmfs/datacloud.infn.it/repo/riscv64-pioneer/parfullcms//ParFullCMS
prefix=G4_ParFullCMS

executor="./exec_multiple.sh"

events_per_thread=100
config=parfullcms.mac

threads=`nproc`

echo Starting at `date`

./measure_power.sh 5 "ParFullCMS_ALL" > measure_ParFullCMS_ALL.csv &
totmpid=$!


for th in 1 2 4 8 16  32 64
do
	export G4FORCENUMBEROFTHREADS=${th}
	nevents=$(($events_per_thread * $th))
	echo executing ParFullCMS at ${th} threads and $nevents events at `date`  `date '+%s'`
	./measure_power.sh 1 "ParFullCMS_${th}" > measure_ParFullCMS_${th}.csv &
	mpid=$!
	echo Measuring power with PID $mpid
	cat $config | sed "s#NEVENTS#$nevents#g" > macro.run 
	copies=$(awk "BEGIN {print ($threads / $th); exit}"|sed "s#,#.#g")
	echo Launching $copies copies of ParFullCMS at ${th} threads
	time ${executor} $copies  ${prefix} ${exe} macro.run cms.gdml >& ${prefix}_${th}.log
	kill $mpid
done

kill $totmpid

