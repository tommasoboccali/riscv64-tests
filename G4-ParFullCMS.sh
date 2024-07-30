G4Prefix=/cvmfs/datacloud.infn.it/repo/riscv64-pioneer/geant4/
#G4Prefix=/scratch/G4/INSTALL

${G4Prefix}/bin/geant4.sh

exe=/cvmfs/datacloud.infn.it/repo/riscv64-pioneer/parfullcms//ParFullCMS
prefix=G4_ParFullCMS

events_per_thread=100
config=parfullcms.mac

echo Starting at `date`

for th in 1 2 4 8 16 32 64
do
	export G4FORCENUMBEROFTHREADS=${th}
	nevents=$(($events_per_thread * $th))
	echo executing ParFullCMS at ${th} threads and $nevents events at `date`  `date '+%s'`
	cat $config | sed "s#NEVENTS#$nevents#g" > macro.run 
	time ${exe} macro.run >& ${prefix}_${th}.log
done

