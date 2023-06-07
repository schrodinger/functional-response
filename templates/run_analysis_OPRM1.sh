#!/bin/bash

#$ -P dev_CPU
#$ -l cpuonly
#$ -pe one_node 1
#$ -R y
#$ -cwd
#$ -j y  # merge stderr and stdout
#$ -S /bin/bash
#$ -N analysis_OPRM1
#$ -m n

for RAND in 42; do
for N_PC in 4 3; do 

$S/run ~/dev/abfep-restraints/analyze_cluster_rmsf.py \
	-i input_OPRM1.csv -o 'results_OPRM1' \
	-s selections.csv -n $N_PC -k $(seq 1 8) -r $RAND \
	--showstart

done
done

