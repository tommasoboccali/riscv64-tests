#G4Prefix=/cvmfs/datacloud.infn.it/repo/riscv64-pioneer/G4
G4Prefix=/scratch/G4/INSTALL
${G4Prefix}/bin/geant4.sh
exe=${G4Prefix}/share/Geant4/examples/extended/analysis/AnaEx01/AnaEx01
prefix=G4_Ana01

events_per_thread=4000
config=run_ana01.mac

echo Starting at `date`

for th in 1 2 4 8 16 32 64
do
	export G4FORCENUMBEROFTHREADS=${th}
	nevents=$(($events_per_thread * $th))
        echo executing Ana01  at ${th} threads and $nevents events at `date`  `date '+%s'`
        cat $config | sed "s#NEVENTS#$nevents#g" > macro.run
	time ${exe} macro.run >& ${prefix}_${th}.log
done

