#!/bin/bash
## Do not put any commands or blank lines before the #SBATCH lines
#SBATCH --nodes=9                    # Number of nodes - all cores per node are allocated to the job.
#SBATCH --time=00:35:00              # Wall clock time (HH:MM:SS) - once the job exceeds this time, the job will be terminated (default is 5 minutes)
#SBATCH --account=FY170127           # WC ID
#SBATCH --job-name=GradOpt           # Name of job
#SBATCH --partition=short,batch      # partition/queue name: short or batch
                                      #         short: 4hrs wallclock limit
                                      #         batch: nodes reserved for > 4hrs (default)
                                      #         short,batch: 4hrs wallclock limit, but can run on either partition
#SBATCH --qos=normal                  # Quality of Service: long, large, priority or normal
                                      #         normal: request up to 48hrs wallclock (default)
                                      #         long:   request up to 96hrs wallclock and no larger than 64nodes
                                      #         large:  greater than 50% of cluster (special request)
                                      #         priority: High priority jobs (special request)

# (for a list of SLURM environment variables see "man sbatch")
nodes=$SLURM_JOB_NUM_NODES           # Number of nodes - the number of nodes you have requested
                                                            # CTS1 has 36 cores per node
                                                            # TLCC2 has 16 cores per node
#cores=18                             # Number MPI processes to run on each node (a.k.a. PPN)

# Please load the module used to build the code prior to running this script
source ~/.bashrc
module purge
module load openmpi-gnu/2.0 
source /projects/netpub/OpenFOAM5/OpenFOAM-5.0/etc/bashrc WM_NCOMPPROCS=8 foamCompiler=ThirdParty WM_COMPILER=Gcc48 WM_MPLIB=SYSTEMOPENMPI

# Run the simulation
./Allmultirun

# ----------------------------------------------------------------- end-of-file

