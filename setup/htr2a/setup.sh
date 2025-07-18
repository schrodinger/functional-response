#
# Sets up ABFEP job directories for all the ligands to active and inactive HTR2A, 
# restrained to each conformational cluster identified in template MD simulations.
#
# To submit a job after running this script, cd into the directory and run the bash file there.
#
# This script assumes use of the Ada cluster by a dev team member.
# If you use it somewhere else, adapt the options: host, subhost, ffhost, account
#

REPO="/home/voegele/dev/fep-restraints"
RESCHAIN="A" # here: same in both templates
RESRANGE="( res 85 - 98 or res. 111 - 136 or res. 149 - 176 or res. 192 - 215 or res. 234 - 260 or res. 320 - 345 or res. 357 - 382 )"
SCALING=0.4

# Cluster 0, active
$SCHRODINGER/run $REPO/setup_restrained_abfep.py poses/htr2a-a_poses.mae \
	-r restraints/pca-kmeans_n03_s42_k03_cluster00_rmsf_avg.cms \
	-j htr2a_n03_s42_k03_cluster00-a \
	--scaling-factor $SCALING --md-force-const 0.1 --fep-force-const 1.0 \
	--asl "protein and chain ${RESCHAIN} and at.ptype CA and ${RESRANGE}" \
	--md-sim-time 2000 --fep-sim-time 10000 \
	--host driver --subhost gpu --account dev --maxjob 0 --retries 5 \
	--ffbuilder --ffhost cpu 

# Cluster 1, active
$SCHRODINGER/run $REPO/setup_restrained_abfep.py poses/htr2a-a_poses.mae \
        -r restraints/pca-kmeans_n03_s42_k03_cluster01_rmsf_avg.cms \
        -j htr2a_n03_s42_k03_cluster01-a \
        --scaling-factor $SCALING --md-force-const 0.1 --fep-force-const 1.0 \
        --asl "protein and chain ${RESCHAIN} and at.ptype CA and ${RESRANGE}" \
        --md-sim-time 2000 --fep-sim-time 10000 \
        --host driver --subhost gpu --account dev --maxjob 0 --retries 5 \
        --ffbuilder --ffhost cpu

# Cluster 2, inactive
$SCHRODINGER/run $REPO/setup_restrained_abfep.py poses/htr2a-i_poses.mae \
        -r restraints/pca-kmeans_n03_s42_k03_cluster02_rmsf_avg.cms \
        -j htr2a_n03_s42_k03_cluster02-i \
        --scaling-factor $SCALING --md-force-const 0.1 --fep-force-const 1.0 \
        --asl "protein and chain ${RESCHAIN} and at.ptype CA and ${RESRANGE}" \
        --md-sim-time 2000 --fep-sim-time 10000 \
        --host driver --subhost gpu --account dev --maxjob 0 --retries 5 \
        --ffbuilder --ffhost cpu


