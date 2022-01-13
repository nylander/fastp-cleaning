#! /bin/sh
#
# Load modules on rackham.uppmax.uu.se
# Run from fastp-cleaning folder as such:
# $ bash rackham/scripts/init.sh

module load bioinfo-tools
module load conda
module load snakemake/5.30.1
mkdir -p conda_envs
export CONDA_ENVS_PATH=$PWD/conda_envs

