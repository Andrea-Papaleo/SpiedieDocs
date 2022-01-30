---
title: GPU on Spiedie (advanced)
layout: default
images: []
tags: [CUDA, CUBLAS, GPU, BLAS, GEMM, SBATCH]
description: How to run specialzied GPU-accelerated on the GPU partition on Spiedie.
category: tutorial
---

***

In this tutorial, we will be running the BLAS sample test on a GPU compute node on Spiedie. 

Covered in this guide: 

1. [Writing batch script and using sbatch](../docs/submitting_jobs.html)
2. [Loading modules on Spiedie](../docs/spiedie_modules.html)
3. [Requesting specific partitions](../docs/spiedie_partitions.html)

## Using sbatch and writing a batch script 

In this tutorial, we will be using a batch script to submit our job to Spiedie and we will be using the sbatch command. [For more examples on submitting jobs, click here](../docs/submitting_jobs.html)

We will be using the BLAS and CUDA to run a general matrix-matrix multiplication (GEMM) test code available from Nvidia for this example. GEMM operations are fundamental for many scientific, engineering and deep leanring applications and are well suited for GPU-based programming. You can download the [source code](code/simpleCUBLAS.cpp)

For more CUDA examples checkout <a href="https://github.com/NVIDIA/cuda-samples" target="_blank"> this repository</a>

	
Log in to Spiedie and create a new directory: 

``` bash
mkdir CUDA_Example
```

Download the  [source code](code/simpleCUBLAS.cpp) and transfer to the directory: 

```bash
scp /path/to/simpleCUBLAS.cpp <username>@spiedie.binghamton.edu:./CUDA_Example
```

You can find other methods to transfer the file [here](../docs/data_transfer.html).

Once the source code is uploaded, we can write the batch script to submit our job request. 

Create a new file in the same directory called, cuda_blas_test.sh.
``` bash 
touch cuda_blas_test.sh
```
Using your preferred editor such as nano, emacs, or vim, edit the new file.

The first line in the batch script must be the shebang. So we must have, 
```bash
#!/bin.bash
```
Next, we will name our job so we are able to monitor it if we wish to on the slurm queue. To assign a job name add : 

```bash
#SBATCH --job-name=CUBLASTEST
```

This will name the job CUBLASTEST.

Next, we will assign output file to log all the standard output from our program. 

```bash
#SBATCH --output=cuda_output.log
```

This will direct the output of the program to the cuda_out.log file.

Next, we must request the correct partition for our program to properly run and have access to the P100 gpus available on Spiedie. We therefore request the gpucompute partition with:

```bash
#SBATCH --partition=gpucompute
```
We can use the default number of nodes (1) and default memory for this program.

We need to let SLURM know how many tasks we will require for our program. Since we will not be using any parallel CPU computation, we will only request one. 

``` bash
#SBATCH --ntasks=1
```
Finally, we should also let SLURM know how many GPUs we will require for our program. In this instance we are requesting 1 GPU.

``` bash
#SBATCH --gres=gpu:1
```
We've finished defining our resource allocation parameters for our job.

## Loading modules

***

Next we must make sure we have the necessary drivers and tools to run our CUDA code. To load the correct modules, we must add the following lines to our shell script.

First we must load the CUDA toolkit, which includes the CUDA compiler. 

```bash
module load cuda10.0/toolkit/10.0.130
```

***Note: We will be CUDA10.0 for this tutorial***

Since we are using the CUDA-enabled BLAS library, we must also load it.
```bash
module load cuda10.0/blas/10.0.130
```

We are now ready to write the commands to compile, link, and execute the program.


To compile the source code, add the following line:
``` bash
nvcc simpleCUBLAS.cpp -c simpleCUBLAS.o
```

To link object code with the CUBLAS library, add the following line:
```bash
nvcc simpleCUBLAS.o -o simpleCUBLAS -lcublas
```

Finally, we can run the program by adding: 
```bash
./simpleCUBLAS
```

## Submitting using SBATCH

The final cuda_blas_test.sh file should be: 

```bash
#!/bin/bash
#SBATCH --job-name=CUBLASTEST
#SBATCH --output=cuda_output.log
#
#SBATCH --partition=gpucompute
#SBATCH --ntasks=1

module load cuda10.0/blas/10.0.130
module load cuda10.0/toolkit/10.0.130
nvcc simpleCUBLAS.cpp -c simpleCUBLAS.o
nvcc simpleCUBLAS.o -o simpleCUBLAS -lcublas
./simpleCUBLAS
```

[Click here to download the complete batch file.](code/cuda_blas_test.sh)

***Note: The cuda_blas_test.sh file should be in the same directory as simpleCUBLAS.cpp file***

Since, our parameters are specified in the shell script, we just need to submit the shell script with: 

```bash
sbatch cuda_blas_test.sh 
``` 

The job should be queued and the results should be output in the cuda_output.log file once the job has been assigned and finished.
