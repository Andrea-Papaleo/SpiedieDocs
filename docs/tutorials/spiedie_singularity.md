---
title: Singularity Containers on Spiedie (advanced)
layout: default 
images: [] 
tags : [tutorial]
description: How to use Singularity containers to run jobs on spiedie.
category: tutorial
--- 

This guide illustrates the use of Singularity containers to run a job on the GPU compute node on Spiedie. 

If you'de like to run the same job, but using [Conda](../docs/spiedie_conda.html) instead of Singularity, [click here!](spiedie_conda.html)

[Click here for more information on when to use Conda vs. Sinularity vs. Modules](../docs/conda_singularity_modules.html)

Things covered in this guide: 

1. [Creating or pulling Singularity containers](../singularity/singularity_commands.md)
2. Binding module directories to container environment 
3. Running a GPU-enabled workload

Requirements to complete this guide: 

1. Familiarity with Spiedie [(try the quick start if you haven't)](quick_start.md)
2. Local installation of Singularity 
	- [Github account (to create image on syhub)](../singularity/syhub-create.html)
3. Familiarity with shell commands and python 

## Creating or Pulling Singularity Containers

For this tutorial, we will be using a custom singularity image to run gpu-enabled Tensorflow on a GPU-compute node.

 We have a few options for creating our container image. We can either create the image on a local machine and transfer it to Spiedie or we can generate the image on the <a href="https://singularity-hub.org/" targer="_blank">singularity-hub </a> container repository.  

#### Creating Singularity Containers 

If you would like to create the image locally first, [you must install Singularity on a machine in which you have root access.](../singularity/install-singularity.html)

We will use the verified  <a href="recipes/spiedie_tensorflow_gpu.def" download>TensorFlow-GPU recipe</a> available on the [Singularity Recipe Hub.](../singularity/recipe-hub.html)

Once you have downloaded the recipe, build the image by simply running: 

```bash
sudo singularity build spiedie_tf_gpu.simg spiedie_tensorflow_gpu.def 
```

*** Note: This may take a few minutes depending on the speed of your machine. The resulting .simg file may >3 GB ***

Once the container image is created, we will need to transfer image to Spiedie. 

Log in to Spiedie and create a new directory for our new project.

```bash
mkdir GPU_Compute_Example
```

Transfer the image using scp from your local machine: 

```bash 
scp spiedie_tf_gpu.simg username@spiedie.binghamton.edu:./GPU_Compute_Example/
```

For more data transer instructions, [click here](../docs/data_transfer.html)


We will be running a simple 5000 element dot product on our P100 GPUs and logging the device placement.  <a href="code/tf_gpu.py">You can download here.</a> 

Download the source code and transfer it to the project directory from your local machine with:

```bash
scp tf_gpu.py username@spiedie.binghamton.edu:./GPU_Compute_Example/
```

Once the source code is uploaded, we can write the batch script to submit our job request. 

Create a new file in the same directory on Spiedie called, singularity_gpu_test.sh.
``` bash 
touch singularity_gpu_test.sh
```
Using your preferred editor such as nano, emacs, or vim, edit the new file directly on Spiedie. 

You can also locally write the script and transfer it once you are done. 

The first line in the batch script must be the shebang. So we must have, 
```bash
#!/bin.bash
```

Next, we will name our job so we are able to monitor it if we wish to on the slurm queue. To assign a job name add : 

```bash
#SBATCH --job-name=SINGULARITY_GPU_TEST
```

This will name the job CUBLASTEST.

Next, we will assign output file to log all the standard output from our program. 

```bash
#SBATCH --output=tf_gpu_output.log
```

This will direct the output of the program to the cuda_out.log file.

Next, we must request the correct partition for our program to properly run and have access to the P100 gpus available on Spiedie. We therefore request the gpucompute partition with:

```bash
#SBATCH --partition-gpucompute
```
We can use the default number of nodes (1) and default memory for this program.

Finally, we should also let SLURM know how many tasks we will require for our program. Since we will not be using any parallel CPU computation, we will only request one. 

``` bash
#SBATCH --ntasks=1
```

We've finished defining our resource allocation parameters for our job.

## Binding Module Directories

We must first load the Singularity module installed on Spiedie. Append the following line to the batch scrip: 

```bash
module load singularity/3.1.1
```

We need the CUDA drivers available on Spiedie to succesfully have access to the GPUs. 

We must load the CUDA toolkit, and associated driver with. 

```bash 
module load cuda10.0/toolkit/10.0.130
```

The loaded library will not be available to the container automatically, so before we run the container, we must expose the module directory to the container. 

We can add additional directories to the container, by simply binding those directories. We add additional paths by updating the SINGULARITY_BINDPATH variable. 

We can also bind paths using the -B/--bind flag. <a href="https://singularity.lbl.gov/docs-mount" target="_blank">click here for more details</a>

```bash 
export SINGULARITY_BINDPATH="/cm/shared/apps/cuda10.0/toolkit/current/lib64/,/cm/local/apps/cuda-driver/libs/418.40.04/lib64/"
```

## Running a GPU-enabled Workload

Finally our environment is set up and we can run our test file. Add the line 

```bash 
singulariy run  spiedie_tf_gpu.simg python3.6 tf_gpu.py
```

The complete singularity_gpu_test.sh file: 

```bash 
#!/bin.bash
#SBATCH --job-name=SINGULARITY_GPU_TEST
#SBATCH --output=tf_gpu_output.log
#
#SBATCH --partition-gpucompute
#SBATCH --ntasks=1

module load singularity/3.1.1
module load cuda10.0/toolkit/10.0.130
export SINGULARITY_BINDPATH="/cm/shared/apps/cuda10.0/toolkit/current/lib64/,/cm/local/apps/cuda-driver/libs/418.40.04/lib64/"
singulariy run  spiedie_tf_gpu.simg python3.6 tf_gpu.py
```

[Click here to download the complete batch file.](code/singularity_gpu.sh)

We can now queue the job to SLURM with: 

```bash
sbatch singularity_cpu_test.sh
```

The job should be queued and the output logged in tf_gpu_output.log. 

You can run:

```bash 
cat tf_gpu_output.log
```

You should see the following output: 

``` bash 
Device mapping:
/job:localhost/replica:0/task:0/device:XLA_CPU:0 -> device: XLA_CPU device
/job:localhost/replica:0/task:0/device:GPU:0 -> device: 0, name: Tesla P100-PCIE-12GB, pci bus id: 0000:82:00.0, compute capability: 6.0
/job:localhost/replica:0/task:0/device:GPU:1 -> device: 1, name: Tesla P100-PCIE-12GB, pci bus id: 0000:83:00.0, compute capability: 6.0
/job:localhost/replica:0/task:0/device:XLA_GPU:0 -> device: XLA_GPU device
/job:localhost/replica:0/task:0/device:XLA_GPU:1 -> device: XLA_GPU device
2019-07-15 13:42:49.767029: I tensorflow/core/common_runtime/direct_session.cc:317] Device mapping:
/job:localhost/replica:0/task:0/device:XLA_CPU:0 -> device: XLA_CPU device
/job:localhost/replica:0/task:0/device:GPU:0 -> device: 0, name: Tesla P100-PCIE-12GB, pci bus id: 0000:82:00.0, compute capability: 6.0
/job:localhost/replica:0/task:0/device:GPU:1 -> device: 1, name: Tesla P100-PCIE-12GB, pci bus id: 0000:83:00.0, compute capability: 6.0
/job:localhost/replica:0/task:0/device:XLA_GPU:0 -> device: XLA_GPU device
/job:localhost/replica:0/task:0/device:XLA_GPU:1 -> device: XLA_GPU device

MatMul: (MatMul): /job:localhost/replica:0/task:0/device:GPU:0
2019-07-15 13:42:49.768241: I tensorflow/core/common_runtime/placer.cc:1059] MatMul: (MatMul)/job:localhost/replica:0/task:0/device:GPU:0
a: (Const): /job:localhost/replica:0/task:0/device:GPU:0
2019-07-15 13:42:49.768275: I tensorflow/core/common_runtime/placer.cc:1059] a: (Const)/job:localhost/replica:0/task:0/device:GPU:0
b: (Const): /job:localhost/replica:0/task:0/device:GPU:0
2019-07-15 13:42:49.768300: I tensorflow/core/common_runtime/placer.cc:1059] b: (Const)/job:localhost/replica:0/task:0/device:GPU:0
```
