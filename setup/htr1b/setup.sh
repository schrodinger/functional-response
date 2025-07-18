#
# Sets up ABFEP job directories for all the ligands to active and inactive HTR1B, 
# restrained to each conformational cluster identified in template MD simulations.
#
# To submit a job after running this script, cd into the directory and run the bash file there.
#
# This script assumes use of the Ada cluster by a dev team member.
# If you use it somewhere else, adapt the options: host, subhost, ffhost, account
#

REPO="/home/voegele/dev/fep-restraints"
# chain: S for active, A for inactive 
RESRANGE="( res. 50 - 149 or res. 166 - 183 or res. 205 - 236 or res. 309 - 334 or res. 350 - 372 )"
SCALING=0.4

# Cluster 0, active
$SCHRODINGER/run $REPO/setup_restrained_abfep.py poses/htr1b-a_poses.mae \
	-r restraints/pca-kmeans_n03_s42_k05_cluster00_rmsf_avg.cms \
	-j htr1b_n03_s42_k05_cluster00-a \
	--scaling-factor $SCALING --md-force-const 0.1 --fep-force-const 1.0 \
	--asl "protein and chain S and at.ptype CA and ${RESRANGE}" \
	--md-sim-time 2000 --fep-sim-time 10000 \
	--host driver --subhost gpu --account dev --maxjob 0 --retries 5 \
	--ffbuilder --ffhost cpu 

# Cluster 1, active
$SCHRODINGER/run $REPO/setup_restrained_abfep.py poses/htr1b-a_poses.mae \
        -r restraints/pca-kmeans_n03_s42_k05_cluster01_rmsf_avg.cms \
        -j htr1b_n03_s42_k05_cluster01-a \
        --scaling-factor $SCALING --md-force-const 0.1 --fep-force-const 1.0 \
        --asl "protein and chain S and at.ptype CA and ${RESRANGE}" \
        --md-sim-time 2000 --fep-sim-time 10000 \
        --host driver --subhost gpu --account dev --maxjob 0 --retries 5 \
        --ffbuilder --ffhost cpu

# Cluster 2, inactive
$SCHRODINGER/run $REPO/setup_restrained_abfep.py poses/htr1b-i_poses.mae \
        -r restraints/pca-kmeans_n03_s42_k05_cluster02_rmsf_avg.cms \
        -j htr1b_n03_s42_k05_cluster02-i \
        --scaling-factor $SCALING --md-force-const 0.1 --fep-force-const 1.0 \
        --asl "protein and chain A and at.ptype CA and ${RESRANGE}" \
        --md-sim-time 2000 --fep-sim-time 10000 \
        --host driver --subhost gpu --account dev --maxjob 0 --retries 5 \
        --ffbuilder --ffhost cpu

# Cluster 3, active
$SCHRODINGER/run $REPO/setup_restrained_abfep.py poses/htr1b-a_poses.mae \
        -r restraints/pca-kmeans_n03_s42_k05_cluster03_rmsf_avg.cms \
        -j htr1b_n03_s42_k05_cluster03-a \
        --scaling-factor $SCALING --md-force-const 0.1 --fep-force-const 1.0 \
        --asl "protein and chain S and at.ptype CA and ${RESRANGE}" \
        --md-sim-time 2000 --fep-sim-time 10000 \
        --host driver --subhost gpu --account dev --maxjob 0 --retries 5 \
        --ffbuilder --ffhost cpu

# Cluster 4, inactive
$SCHRODINGER/run $REPO/setup_restrained_abfep.py poses/htr1b-i_poses.mae \
        -r restraints/pca-kmeans_n03_s42_k05_cluster04_rmsf_avg.cms \
        -j htr1b_n03_s42_k05_cluster04-i \
        --scaling-factor $SCALING --md-force-const 0.1 --fep-force-const 1.0 \
        --asl "protein and chain A and at.ptype CA and ${RESRANGE}" \
        --md-sim-time 2000 --fep-sim-time 10000 \
        --host driver --subhost gpu --account dev --maxjob 0 --retries 5 \
        --ffbuilder --ffhost cpu


