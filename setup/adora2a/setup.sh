#
# Sets up ABFEP job directories for all the ligands to active and inactive ADORA2A, 
# restrained to each conformational cluster identified in template MD simulations.
#
# To submit a job after running this script, cd into the directory and run the bash file there.
#
# This script assumes use of the Bolt cluster by a dev team member.
# If you use it somewhere else, adapt the options: host, subhost, ffhost, project
#

REPO="/home/voegele/dev/fep-restraints"
RESCHAIN="A" # here: same in both templates
RESRANGE="( res. 8 - 140 or res. 170 - 200 or res. 228 - 245 or res. 276 - 300 )"
SCALING=0.5

# Cluster 0, inactive
$SCHRODINGER/run $REPO/setup_restrained_abfep.py poses/adora2a-i_poses.mae \
	-r restraints/pca-kmeans_n04_s42_k04_cluster00_rmsf_avg.cms \
	-j adora2a_n04_s42_k04_cluster00-i \
	--scaling-factor $SCALING --md-force-const 0.1 --fep-force-const 1.0 \
	--align-sel "protein and chain ${RESCHAIN} and at.ptype CA and ${RESRANGE}" \
	--md-sim-time 2000 --fep-sim-time 10000 \
	--host bolt_cpu --subhost bolt_gpu --project dev_GPU --maxjob 0 --retries 5 \
	--ffbuilder --ffhost bolt_cpu

# Cluster 1, active
$SCHRODINGER/run $REPO/setup_restrained_abfep.py poses/adora2a-a_poses.mae \
        -r restraints/pca-kmeans_n04_s42_k04_cluster01_rmsf_avg.cms \
        -j adora2a_n04_s42_k04_cluster01-a \
        --scaling-factor $SCALING --md-force-const 0.1 --fep-force-const 1.0 \
        --align-sel "protein and chain ${RESCHAIN} and at.ptype CA and ${RESRANGE}" \
        --md-sim-time 2000 --fep-sim-time 10000 \
        --host bolt_cpu --subhost bolt_gpu --project dev_GPU --maxjob 0 --retries 5 \
        --ffbuilder --ffhost bolt_cpu

# Cluster 2, active
$SCHRODINGER/run $REPO/setup_restrained_abfep.py poses/adora2a-a_poses.mae \
        -r restraints/pca-kmeans_n04_s42_k04_cluster02_rmsf_avg.cms \
        -j adora2a_n04_s42_k04_cluster02-a \
        --scaling-factor $SCALING --md-force-const 0.1 --fep-force-const 1.0 \
        --align-sel "protein and chain ${RESCHAIN} and at.ptype CA and ${RESRANGE}" \
        --md-sim-time 2000 --fep-sim-time 10000 \
        --host bolt_cpu --subhost bolt_gpu --project dev_GPU --maxjob 0 --retries 5 \
        --ffbuilder --ffhost bolt_cpu

# Cluster 3, inactive
$SCHRODINGER/run $REPO/setup_restrained_abfep.py poses/adora2a-i_poses.mae \
        -r restraints/pca-kmeans_n04_s42_k04_cluster03_rmsf_avg.cms \
        -j adora2a_n04_s42_k04_cluster03-i \
        --scaling-factor $SCALING --md-force-const 0.1 --fep-force-const 1.0 \
        --align-sel "protein and chain ${RESCHAIN} and at.ptype CA and ${RESRANGE}" \
        --md-sim-time 2000 --fep-sim-time 10000 \
        --host bolt_cpu --subhost bolt_gpu --project dev_GPU --maxjob 0 --retries 5 \
        --ffbuilder --ffhost bolt_cpu
