#G4Prefix=/cvmfs/datacloud.infn.it/repo/riscv64-pioneer/G4
G4Prefix=/scratch/G4/INSTALL

${G4Prefix}/bin/geant4.sh

exe=/scratch/parfullcms/ParFullCMS
prefix=G4_ParFullCMS


echo Starting at `date`

for th in 1 2 4 8 16 32 64
do
	export G4FORCENUMBEROFTHREADS=${th}
	echo executing ParFullCMS at ${th} threads at `date`  `date '+%s'`
	time ${exe} parfullcms.mac >& ${prefix}_${th}.log
done

