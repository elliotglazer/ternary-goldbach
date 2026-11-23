#!/bin/sh
set -eu
cp .hol/objs/DependentBlockResultsTheory.dat dependent_sample_1.dat
for sample in 2 3; do
  ./run.sh /usr/bin/time -v -o "dependent_replay_sample_${sample}.time" \
    ./dependent.exe > "dependent_replay_sample_${sample}.log" 2>&1
  cp .hol/objs/DependentBlockResultsTheory.dat "dependent_sample_${sample}.dat"
done
