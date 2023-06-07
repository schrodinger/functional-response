#!/bin/bash

#$ -P dev_CPU
#$ -l cpuonly
#$ -pe one_node 1
#$ -R y
#$ -cwd
#$ -j y  # merge stderr and stdout
#$ -S /bin/bash
#$ -N analysis_ADORA1
#$ -m n

for RAND in 42 21 84; do
for N_PC in 4 3 2; do 

$S/run ~/dev/fep-restraints/analyze_cluster_rmsf.py \
	-i input_ADORA1.csv -o 'results_ADORA1' \
	-s selections.csv -n $N_PC -k $(seq 1 8) -r $RAND \
	--showstart

done
done

