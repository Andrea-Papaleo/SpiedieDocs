---
title: GPU on Spiedie (CUDA)
layout: default
images: []
tags: [CUDA, CUBLAS, GPU, BLAS, GEMM, SBATCH]
description: How to run specialized GPU-accelerated on the GPU partition on Spiedie.
category: tutorial
prev: Multi-Core Processing (C++/OpenMP)
---


In this tutorial, we will be running the BLAS sample test on a GPU compute node on Spiedie. 

Covered in this guide: 

1. [Writing batch script and using sbatch](../docs/submitting_jobs.html)
2. [Loading modules on Spiedie](../docs/spiedie_modules.html)
3. [Requesting specific partitions](../docs/spiedie_partitions.html)

## Using sbatch and writing a batch script 

In this tutorial, we will be using a batch script to submit our job to Spiedie and we will be using the sbatch command. For more examples on submitting jobs, [click here](../docs/submitting_jobs.html)

We will be using the BLAS and CUDA to run a general matrix-matrix multiplication (GEMM) test code available from Nvidia for this example. GEMM operations are fundamental for many scientific, engineering and deep learning applications and are well suited for GPU-based programming.

You can download the source code for this tutorial <a href="code/simpleCUBLAS.cpp" download>here</a>.

For more CUDA examples checkout <a href="https://github.com/NVIDIA/cuda-samples" target="_blank"> this repository</a>

### <a name="environment_setup"></a> Set up the Environment

Similar to the previous tutorials, its best to keep our file system organized, so lets create a new directory called *CUDA-tutorial*.

```bash
[spiedie81 ~]$ mkdir CUDA-tutorial
```

Now exit out of spiedie or open a new terminal window on your local machine. If you haven't downloaded the *simpleCUBLAS.cpp* file yet, do so now. Once you have the *simpleCUBLAS.cpp* file, secure copy it to your new folder in spiedie.

```bash
scp path/to/mpi.c <username>@spiedie.binghamton.edu:CUDA-tutorial
```

Back in your spiedie terminal you can verify you have the file in the right place by changing into to *CUDA-tutorial* directory and using ```ls```.

```bash
[spiedie81 ~]$ cd CUDA-tutorial/
[spiedie81 CUDA-tutorial]$ ls
simpleCUBLAS.cpp
```

You can use ```cat``` or a text editor to view the contents of *simpleCUBLAS.cpp*. 

Once the source code is uploaded, we can write the batch script to submit our job request. 

## <a name="cuda_sbatch"></a> Creating the Run Script for CUDA

Create a new file in the same directory called, cuda_blas_test.sh.
``` bash 
[spiedie81 CUDA-tutorial]$ emacs cuda_blas_test.sh
```

The first line in the batch script must be the shebang. So we must have, 
```bash
#!/bin.bash
```

#### Resource Allocation

Next, we will name our job so we are able to monitor it if we wish to on the slurm queue. To assign a job name use ```--job-name```: 

```bash
#!/bin/bash
#SBATCH --job-name=CUBLASTEST
```


Next, we will assign output file to log all the standard output from our program. 

```bash
#!/bin/bash
#SBATCH --job-name=CUBLASTEST
#SBATCH --output=cuda_output.log
```

Next, we must request the correct partition for our program to properly run and have access to the P100 gpus available on Spiedie. We therefore request the gpucompute partition with the ```--partition``` option:

```bash
#!/bin/bash
#SBATCH --job-name=CUBLASTEST
#SBATCH --output=cuda_output.log
#
#SBATCH --partition=gpucompute
```
We can use the default number of nodes (1) and default memory for this program.

We need to let SLURM know how many tasks we will require for our program. Since we will not be using any parallel CPU computation, we will only request one. 

``` bash
#!/bin/bash
#SBATCH --job-name=CUBLASTEST
#SBATCH --output=cuda_output.log
#
#SBATCH --partition=gpucompute
#SBATCH --ntasks=1
```
Finally, we should also let SLURM know how many GPUs we will require for our program. In this instance we are requesting 1 GPU.

``` bash
#!/bin/bash
#SBATCH --job-name=CUBLASTEST
#SBATCH --output=cuda_output.log
#
#SBATCH --partition=gpucompute
#SBATCH --ntasks=1
#SBATCH --gres=gpu:1
```

We've finished defining our resource allocation parameters for our job.

#### Loading modules


Next we must make sure we have the necessary drivers and tools to run our CUDA code. To load the correct modules, we must add the following lines to our shell script.

First we must load the CUDA toolkit, which includes the CUDA compiler. 

```bash
#!/bin/bash
#SBATCH --job-name=CUBLASTEST
#SBATCH --output=cuda_output.log
#
#SBATCH --partition=gpucompute
#SBATCH --ntasks=1
#SBATCH --gres=gpu:1

module load cuda10.0/blas/10.0.130
```

***Note: We will be CUDA10.0 for this tutorial***

Since we are using the CUDA-enabled BLAS library, we must also load it.
```bash
#!/bin/bash
#SBATCH --job-name=CUBLASTEST
#SBATCH --output=cuda_output.log
#
#SBATCH --partition=gpucompute
#SBATCH --ntasks=1
#SBATCH --gres=gpu:1

module load cuda10.0/blas/10.0.130
module load cuda10.0/toolkit/10.0.130
```

We are now ready to write the commands to compile, link, and execute the program using ```nvcc```.

``` bash
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
```

To link object code with the CUBLAS library, add ```nvcc simpleCUBLAS.o -o simpleCUBLAS -lcublas```:
```bash
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
```

Finally, we can run the program by adding ```./simpleCUBLAS```: 
```bash
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
#SBATCH --gres=gpu:1

module load cuda10.0/blas/10.0.130
module load cuda10.0/toolkit/10.0.130
nvcc simpleCUBLAS.cpp -c simpleCUBLAS.o
nvcc simpleCUBLAS.o -o simpleCUBLAS -lcublas
./simpleCUBLAS
```

Click <a href="code/cuda_blas_test.sh" download>here</a> to download the complete batch file.


Since, our parameters are specified in the shell script, we just need to submit the shell script with: 

```bash
[spiedie81 CUDA-tutorial]$ sbatch cuda_blas_test.sh 
``` 

The job should be queued and the results should be output in the cuda_output.log file once the job has been assigned and finished.

```bash
[spiedie81 CUDA-tutorial]$ cat cuda_output.log 
GPU Device 0: "Tesla P100-PCIE-12GB" with compute capability 6.0

simpleCUBLAS test running..
simpleCUBLAS test passed.
[spiedie81 CUDA-tutorial]$ 
```

