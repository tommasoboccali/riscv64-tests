G4Prefix=/cvmfs/datacloud.infn.it/repo/riscv64-pioneer/geant4
#G4Prefix=/scratch/G4/INSTALL
#
source ${G4Prefix}/bin/geant4.sh

exe=${G4Prefix}/share/Geant4/examples/extended/exoticphysics/dmparticle/dmparticle
prefix=G4_DMPARTICLE

events_per_thread=25000
config=dmparticle_test.in

echo Starting at `date`

for th in 1 2 4 8 16 32 64
do
	export G4FORCENUMBEROFTHREADS=${th}
	nevents=$(($events_per_thread * $th))
        echo executing DMPARTICLE at ${th} threads and $nevents events at `date`  `date '+%s'`
        ./measure_power.sh 1 "DMParticle_${th}" > measure_DMParticle_${th}.log &
	mpid=$!
	echo Measuring power with PID $mpid
        cat $config | sed "s#NEVENTS#$nevents#g" > macro.run
	time ${exe} macro.run  >& ${prefix}_${th}.log
	kill $mpid	
done

