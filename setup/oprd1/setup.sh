#
# Sets up ABFEP job directories for all the ligands to active and inactive OPRD1, 
# restrained to each conformational cluster identified in template MD simulations.
#
# To submit a job after running this script, cd into the directory and run the bash file there.
#
# This script assumes use of the Bolt cluster by a dev team member.
# If you use it somewhere else, adapt the options: host, subhost, ffhost, project
#

REPO="/home/voegele/dev/fep-restraints"
RESCHAIN="A" # here: same in both templates
RESRANGE="( res. 54 - 75 or res. 86 - 148 or res. 165 - 240 or res. 254 - 282 or res. 298 - 320 )"
SCALING=0.5

# Cluster 0, active
$SCHRODINGER/run $REPO/setup_restrained_abfep.py poses/oprd1-a_poses.mae \
	-r restraints/pca-kmeans_n04_s42_k05_cluster00_rmsf_avg.cms \
	-j oprd1_n04_s42_k05_cluster00-a \
	--scaling-factor $SCALING --md-force-const 0.1 --fep-force-const 1.0 \
	--align-sel "protein and chain ${RESCHAIN} and at.ptype CA and ${RESRANGE}" \
	--md-sim-time 2000 --fep-sim-time 10000 \
	--host bolt_cpu --subhost bolt_gpu --project dev_GPU --maxjob 0 --retries 5 \
	--ffbuilder --ffhost bolt_cpu 

# Cluster 1, active
$SCHRODINGER/run $REPO/setup_restrained_abfep.py poses/oprd1-i_poses.mae \
        -r restraints/pca-kmeans_n04_s42_k05_cluster01_rmsf_avg.cms \
        -j oprd1_n04_s42_k05_cluster01-i \
        --scaling-factor $SCALING --md-force-const 0.1 --fep-force-const 1.0 \
        --align-sel "protein and chain ${RESCHAIN} and at.ptype CA and ${RESRANGE}" \
        --md-sim-time 2000 --fep-sim-time 10000 \
        --host bolt_cpu --subhost bolt_gpu --project dev_GPU --maxjob 0 --retries 5 \
        --ffbuilder --ffhost bolt_cpu

# Cluster 2, active
$SCHRODINGER/run $REPO/setup_restrained_abfep.py poses/oprd1-a_poses.mae \
        -r restraints/pca-kmeans_n04_s42_k05_cluster02_rmsf_avg.cms \
        -j oprd1_n04_s42_k05_cluster02-a \
        --scaling-factor $SCALING --md-force-const 0.1 --fep-force-const 1.0 \
        --align-sel "protein and chain ${RESCHAIN} and at.ptype CA and ${RESRANGE}" \
        --md-sim-time 2000 --fep-sim-time 10000 \
        --host bolt_cpu --subhost bolt_gpu --project dev_GPU --maxjob 0 --retries 5 \
        --ffbuilder --ffhost bolt_cpu

# Cluster 3, active
$SCHRODINGER/run $REPO/setup_restrained_abfep.py poses/oprd1-i_poses.mae \
        -r restraints/pca-kmeans_n04_s42_k05_cluster03_rmsf_avg.cms \
        -j oprd1_n04_s42_k05_cluster03-i \
        --scaling-factor $SCALING --md-force-const 0.1 --fep-force-const 1.0 \
        --align-sel "protein and chain ${RESCHAIN} and at.ptype CA and ${RESRANGE}" \
        --md-sim-time 2000 --fep-sim-time 10000 \
        --host bolt_cpu --subhost bolt_gpu --project dev_GPU --maxjob 0 --retries 5 \
        --ffbuilder --ffhost bolt_cpu

# Cluster 4, active
$SCHRODINGER/run $REPO/setup_restrained_abfep.py poses/oprd1-a_poses.mae \
        -r restraints/pca-kmeans_n04_s42_k05_cluster04_rmsf_avg.cms \
        -j oprd1_n04_s42_k05_cluster04-a \
        --scaling-factor $SCALING --md-force-const 0.1 --fep-force-const 1.0 \
        --align-sel "protein and chain ${RESCHAIN} and at.ptype CA and ${RESRANGE}" \
        --md-sim-time 2000 --fep-sim-time 10000 \
        --host bolt_cpu --subhost bolt_gpu --project dev_GPU --maxjob 0 --retries 5 \
        --ffbuilder --ffhost bolt_cpu


