--- 
title: Conda on Spiedie (intermediate)
layout: default 
images: []
tags: [Conda, GPUCompute, Tensorflow, Tensorflow-GPU]
description: How to activate Conda on Spiedi and install new packages
category: tutorial
---

***   

This tutorial illustrates the use of the Conda environment manager along with the GPU compute node on Spiedie. 

If you'de like to run the same job, but using [Singularity](../singularity/) instead of Conda, [click here!](spiedie_singularity.html)

[Click here for more information on when to use Conda vs. Sinularity vs. Modules](../docs/conda_singularity_modules.html)

Things covered in this guide: 

1. [Enabling and using Conda](../docs/spiedie_conda.html)
2. [Accessing a GPUCompute partition](../docs/submitting_jobs.md)
3. Running a GPU-enabled workload

Requirements to complete the guide: 

1. Familiarity with Spiedie [(try the quick start if you haven't)](quick_start.md)
2. Familiarity with shell commands and python 

## Enabling Conda on Spiedie

For this tutorial, we will be enabling the Conda package and environment manager on Spiedie to set up our environment and install packages. 

In order to activate Conda at log in on Spiedie, log in and run the following command: 

``` bash
/cm/shared/apps/miniconda/bin/conda init
```

Then, close the window and log back in. 

You should see the terminal include the base environment tag like: 

```bash
(base)[username@spiedie81 ~]:
```
***NOte: You do not have to repeat this step every time you want to use Conda. This will automatically start every time you log in***

***Note: If you would like to disable Conda at log in and would like to use Conda, run:*** 



```bash 
conda config --set auto_activate_base false
```



## Install packages

We will be using GPU enabled TensorFlow to test out our python GPU code. To create a new virtual environment called spiedie_tf_gpu and install tensorflow-gpu on it, run 
``` bash
conda create --name spiedie_tf_gpu tensorflow-gpu
```



## Access GPU partition

For this tutorial, we will be accessing the interactive shell on a GPUCompute node. In order to request a shell session on SLURM, run: 

``` bash 
srun --partition=gpucompute --gres=gpu:1 --pty bash
```

Since, we will only be running a simple gpu test program, we will not request additional memory or resources. 


## Running the program

Once assigned to a GPU node, switch to the new virtual environment using:

``` bash
conda activate spiedie_tf_gpu
```

We will be running a simple 5000 element dot product on our P100 GPUs and logging the device placement.  <a href="code/tf_gpu.py">You can download here.</a> 

Download the source code and transfer it to your home directory. For instructions, [click here](../docs/data_transfer.html)


Before running the code, we must load the CUDA-toolkit drivers, by running: 

```bash
module load cuda10.1/toolkit/10.1.105
```

*** Note: We have used CUDA 10.1 for the purposes of this tutorial ***


Once, the module is loaded, we can simply run the program with: 


``` bash
python tf_gpu.py 
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

The above workflow can modified to work with [sbatch](../docs/submitting_jobs.html) and for general purpose TensorFlow GPU usage. 