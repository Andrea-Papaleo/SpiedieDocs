#!/bin/bash
#SBATCH --job-name=sbatch_example
#SBATCH --output=file_name.out
#
#The following are some example flags you should use when you are
#running your program. Replace <> with valid values as needed. If
#the flags are deleted, the Slurm will use the defaults
#
# Number of cores (default: 1)
#SBATCH --cpus-per-task=<>
# Number of Nodes (default: 1)
#SBATCH -N <>
# Allocate memory in Megabytes (default 1GB)
#SBATCH --mem=<>
