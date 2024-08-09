RootPrefix=/cvmfs/datacloud.infn.it/repo/riscv64-pioneer/root/
BenchPrefix=/cvmfs/datacloud.infn.it/repo/riscv64-pioneer/rootbench/root/

source ${RootPrefix}/bin/thisroot.sh

prefix=RootBenchmark
benchmarks="./math/mathcore/TRandomBenchmarks ./interpreter/InterpreterBenchmarks ./tmva/tmva/CrossValidationBenchmarks ./math/vecops/VecOpsRVec ./tree/treeplayer/TTreeReaderBenchmarks ./math/vecops/VecOpsRVec ./roofit/histfactory/benchHistFactory ./roofit/roofit/benchRooFitUnbinned ./roofit/roofit/benchRooFitBackends ./roofit/roofit/benchCodeSquashAD ./hist/hist/RHistBenchmarks ./io/io/TFile_RDFSnapshot ./tree/tree/TTreeBenchmarks"

echo Starting at `date`

./measure_power.sh 1 "RootBenchmark" > measure_RootBenchmark.csv &
totmpid=$!
rm -f ${prefix}.log

for exe in $benchmarks
do

echo Executing $exe .....  >> ${prefix}.log
time ${BenchPrefix}/$exe >> ${prefix}.log 2>&1

done

kill $totmpid

