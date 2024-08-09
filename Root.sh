RootPrefix=/cvmfs/datacloud.infn.it/repo/riscv64-pioneer/root/

source ${RootPrefix}/bin/thisroot.sh

exe="root.exe -b -q $ROOTSYS/tutorials/legacy/benchmarks.C"
prefix=RootBenchmark

echo Executing dry run to load from cvmfs

$exe >& /dev/null

echo Starting at `date`

./measure_power.sh 5 "RootBenchmark" > measure_RootBenchmark.csv &
totmpid=$!

time $exe >& ${prefix}.log


kill $totmpid

