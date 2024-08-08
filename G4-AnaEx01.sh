G4Prefix=/cvmfs/datacloud.infn.it/repo/riscv64-pioneer/geant4
#G4Prefix=/scratch/G4/INSTALL
#
source ${G4Prefix}/bin/geant4.sh

exe=${G4Prefix}/share/Geant4/examples/extended/analysis/AnaEx01/AnaEx01
prefix=G4_Ana01

events_per_thread=20000
config=run_ana01.mac

echo Starting at `date`

for th in 1 2 4 8 16 32 64
do
	export G4FORCENUMBEROFTHREADS=${th}
	nevents=$(($events_per_thread * $th))
        echo executing Ana01  at ${th} threads and $nevents events at `date`  `date '+%s'`
       	./measure_power.sh 1 "AnaEx01_${th}" > measure_AnaEx01_${th}.csv &
        mpid=$!
	echo Measuring power with PID $mpid
        cat $config | sed "s#NEVENTS#$nevents#g" > macro.run
        time ${exe} macro.run >& ${prefix}_${th}.log
	kill $mpid

done

