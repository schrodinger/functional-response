#
# Sets up ABFEP job directories for all the ligands to active and inactive ADORA1, 
# restrained to each conformational cluster identified in template MD simulations.
#
# To submit a job after running this script, cd into the directory and run the bash file there.
#
# This script assumes use of the Ada cluster by a dev team member.
# If you use it somewhere else, adapt the options: host, subhost, ffhost, account
#

REPO="/home/voegele/dev/fep-restraints"
RESRANGE="( res. 1 - 158 or res. 172 - 228 )"
SCALING=0.4

# Cluster 0, active
$SCHRODINGER/run $REPO/setup_restrained_abfep.py poses/adora1-a_poses.mae \
	-r restraints/pca-kmeans_n04_s42_k04_cluster00_rmsf_avg.cms \
	-j adora1_n04_s42_k04_cluster00-a \
	--scaling-factor $SCALING --md-force-const 0.1 --fep-force-const 1.0 \
	--asl "protein and chain R and at.ptype CA and ${RESRANGE}" \
	--md-sim-time 2000 --fep-sim-time 10000 \
	--host driver --subhost gpu --account dev --maxjob 0 --retries 5 \
	--ffbuilder --ffhost cpu

# Cluster 1, inactive
$SCHRODINGER/run $REPO/setup_restrained_abfep.py poses/adora1-i_poses.mae \
        -r restraints/pca-kmeans_n04_s42_k04_cluster02_rmsf_avg.cms \
        -j adora1_n04_s42_k04_cluster01-i \
        --scaling-factor $SCALING --md-force-const 0.1 --fep-force-const 1.0 \
        --asl "protein and at.ptype CA and ${RESRANGE}" \
        --md-sim-time 2000 --fep-sim-time 10000 \
        --host driver --subhost gpu --account dev --maxjob 0 --retries 5 \
        --ffbuilder --ffhost cpu

# Cluster 2, inactive
$SCHRODINGER/run $REPO/setup_restrained_abfep.py poses/adora1-i_poses.mae \
        -r restraints/pca-kmeans_n04_s42_k04_cluster02_rmsf_avg.cms \
        -j adora1_n04_s42_k04_cluster02-i \
        --scaling-factor $SCALING --md-force-const 0.1 --fep-force-const 1.0 \
        --asl "protein and at.ptype CA and ${RESRANGE}" \
        --md-sim-time 2000 --fep-sim-time 10000 \
        --host driver --subhost gpu --account dev --maxjob 0 --retries 5 \
        --ffbuilder --ffhost cpu

# Cluster 3, active
$SCHRODINGER/run $REPO/setup_restrained_abfep.py poses/adora1-a_poses.mae \
        -r restraints/pca-kmeans_n04_s42_k04_cluster03_rmsf_avg.cms \
        -j adora1_n04_s42_k04_cluster03-a \
        --scaling-factor $SCALING --md-force-const 0.1 --fep-force-const 1.0 \
        --asl "protein and chain R and at.ptype CA and ${RESRANGE}" \
        --md-sim-time 2000 --fep-sim-time 10000 \
        --host driver --subhost gpu --account dev --maxjob 0 --retries 5 \
        --ffbuilder --ffhost cpu


