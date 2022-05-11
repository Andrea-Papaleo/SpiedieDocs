#!/bin/bash
#SBATCH --job-name=CUBLASTEST
#SBATCH --output=cuda_output.log
#
#SBATCH --partition=gpucompute
#SBATCH --ntasks=1
#SBATCH --gres=gpu:1

module load cuda10.0/blas/10.0.130
module load cuda10.0/toolkit/10.0.130
nvcc simpleCUBLAS.cpp -c simpleCUBLAS.o
nvcc simpleCUBLAS.o -o simpleCUBLAS -lcublas
./simpleCUBLAS