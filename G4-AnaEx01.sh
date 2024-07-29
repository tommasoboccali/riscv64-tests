#G4Prefix=/cvmfs/datacloud.infn.it/repo/riscv64-pioneer/G4
G4Prefix=/scratch/G4/INSTALL
${G4Prefix}/bin/geant4.sh
exe=${G4Prefix}/share/Geant4/examples/extended/analysis/AnaEx01/AnaEx01
prefix=G4_Ana01


echo Starting at `date`

for th in 1 2 4 8 16 32 64
do
	export G4FORCENUMBEROFTHREADS=${th}
	echo executing Ana01 at ${th} threads at `date`  `date '+%s'`
	time ${exe} run_ana01.mac >& ${prefix}_${th}.log
done

