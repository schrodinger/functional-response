#!/bin/bash

#$ -P dev_CPU
#$ -l cpuonly
#$ -pe one_node 1
#$ -R y
#$ -cwd
#$ -j y  # merge stderr and stdout
#$ -S /bin/bash
#$ -N analysis_HTR1B
#$ -m n

for RAND in 42; do
for N_PC in 4 3; do 

$S/run ~/dev/abfep-restraints/analyze_cluster_rmsf.py \
	-i input_HTR1B.csv -o 'results_HTR1B' \
	-s selections.csv -n $N_PC -k $(seq 1 8) -r $RAND \
	--showstart

done
done

