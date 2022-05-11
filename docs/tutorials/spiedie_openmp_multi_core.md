---
title: Multi-Core Processing (C++/OpenMP)
layout: default 
images: [] 
tags : [tutorial, multicore]
description: How to run a multi-threaded program to take advantage of Spiedie's many-core nodes
category: tutorial
prev: MPI on Spiedie (C/MPI)
next: GPU on Spiedie (CUDA)
--- 


Things covered in this tutorial:

1. [Writing batch scripts for multi-core programs](#sbatch_omp)
3. [Suitable Partitions for job requirements](../docs/spiedie_partitions.html) 
2. [Compiling and linking on the fly](../docs/spiedie_modules.html)

We assume you have familiarity with the OpenMP interface. 

<a href="http://www.openmp.org" target="_blank"> Click here if you would like to learn more</a>


## <a name="getting_started"></a> Getting Started with OpenMP

We are going to run a multi-core program which will utilize shared memory parallelism in a single node for high performance computing.

***Note: If you would like to utilize parallelization using multiple nodes, checkout the MPI tutorial [here](spiedie_MPI.html)***

We've provided a simple openMP program source code <a href="code/open_mp.c" download> here</a>. 

### <a name="environment_setup"></a> Set up the Environment

Similar to the previous tutorials, lets create a new directory called *openMP-tutorial*.

```bash
mkdir openMP-tutorial
```

Now exit out of spiedie or open a new terminal window on your local machine. If you haven't downloaded the *open_mp.c* file yet, do so now. Once you have the *open_mp.c* file, secure copy it to your new folder in spiedie.

```bash
scp path/to/open_mp.c <username>@spiedie.binghamton.edu:openMP-tutorial
```

Back in your spiedie terminal you can verify you have the file in the right place by changing into to *openMP-tutorial* directory and using ```ls```.

```bash
[spiedie81 ~]$ cd openMP-tutorial/
[spiedie81 openMP-tutorial]$ ls
open_mp.c
```
open_mp.c:

```cpp
#include <stdio.h>
#include <omp.h>
 
int main() {
  #pragma omp parallel
  {
    int id = omp_get_thread_num();
    int total = omp_get_num_threads();
    printf("Greetings from process %d out of %d \n", id, total);
  }
  printf("parallel for ends.\n");
  return 0;
}
``` 

The simple program prints out a message for each active thread.

## <a name="openmp_sbatch"></a> Creating the Run Script for OpenMP

Let's write a run script *omp_run.sh* to run our program using a text editor, for this tutorial we use **emacs**. 

First of all, we will include the shebang, as usual,

```bash
#!/bin/bash
```
#### Resource Allocation

Next we will give our job a name:

```bash
#!/bin/bash
#SBATCH --job-name=OMP_TEST
```

Also, we can assign our output file name:

```bash
#!/bin/bash
#SBATCH --job-name=OMP_TEST
#SBATCH --output=omp_output.log
```

Since we are using OpenMP and shared memory parallelism, we will only be using a single compute node: 

```bash
#!/bin/bash
#SBATCH --job-name=OMP_TEST
#SBATCH --output=omp_output.log
# Number of processors
#SBATCH -N 1
```

We will set the number of cores to 4 with:
```bash
#!/bin/bash
#SBATCH --job-name=OMP_TEST
#SBATCH --output=omp_output.log
# Number of processors
#SBATCH -N 1
# Number of cores
#SBATCH -c 4
```

Depending on the number of cores being used, it is a good idea to consider with partition would be the suitable for our program. The details for the partitions and the number of cores available per compute node can be found [here](../docs/spiedie_partitions.html)

If you are using more thant 20 cores, it is recommended to assign the partition to KNL nodes. 

In our test, we will use the standard partition due to our relatively small number of cores. 

```bash
#!/bin/bash
#SBATCH --job-name=OMP_TEST
#SBATCH --output=omp_output.log
# Number of processors
#SBATCH -N 1
# Number of cores
#SBATCH -c 4
#SBATCH --partition=Standard
```


We are now going to dynamically assign the number of OpenMP threads the program utilizes depending on the -c parameter we used above. 

We'll add a line which sets the OMP_NUM_THREADS to the same values as -c: 

```bash
#!/bin/bash
#SBATCH --job-name=OMP_TEST
#SBATCH --output=omp_output.log
# Number of processors
#SBATCH -N 1
# Number of cores
#SBATCH --c 4
#SBATCH --partition=Standard

# Set OMP_NUM_THREADS to the same value as -c
# with a fallback in case it isn't set.
# SLURM_CPUS_PER_TASK is set to the value of -c, but only if -c is explicitly set
if [ -n "$SLURM_CPUS_PER_TASK" ]; then
  omp_threads=$SLURM_CPUS_PER_TASK
```

In case the -c is not set, we fall back to 1 core (as is the default):

```bash
#!/bin/bash
#SBATCH --job-name=OMP_TEST
#SBATCH --output=omp_output.log
# Number of processors
#SBATCH -N 1
# Number of cores
#SBATCH -c 4
#SBATCH --partition=Standard

# Set OMP_NUM_THREADS to the same value as -c
# with a fallback in case it isn't set.
# SLURM_CPUS_PER_TASK is set to the value of -c, but only if -c is explicitly set
if [ -n "$SLURM_CPUS_PER_TASK" ]; then
  omp_threads=$SLURM_CPUS_PER_TASK
else
  omp_threads=1
fi
```

Export the value to complete the process:


```bash
#!/bin/bash
#SBATCH --job-name=OMP_TEST
#SBATCH --output=omp_output.log
# Number of processors
#SBATCH -N 1
# Number of cores
#SBATCH -c 4
#SBATCH --partition=Standard

# Set OMP_NUM_THREADS to the same value as -c
# with a fallback in case it isn't set.
# SLURM_CPUS_PER_TASK is set to the value of -c, but only if -c is explicitly set
if [ -n "$SLURM_CPUS_PER_TASK" ]; then
  omp_threads=$SLURM_CPUS_PER_TASK
else
  omp_threads=1
fi

export OMP_NUM_THREADS=$omp_threads
```
#### Loading the Modules

It is good practice to clear the environment from any previously loaded modules

```bash
#!/bin/bash
#SBATCH --job-name=OMP_TEST
#SBATCH --output=omp_output.log
# Number of processors
#SBATCH -N 1
# Number of cores
#SBATCH -c 4
#SBATCH --partition=Standard

# Set OMP_NUM_THREADS to the same value as -c
# with a fallback in case it isn't set.
# SLURM_CPUS_PER_TASK is set to the value of -c, but only if -c is explicitly set
if [ -n "$SLURM_CPUS_PER_TASK" ]; then
  omp_threads=$SLURM_CPUS_PER_TASK
else
  omp_threads=1
fi

export OMP_NUM_THREADS=$omp_threads

# Clear the environment from any previously loaded modules
module purge > /dev/null 2>&1

``` 

It is also good practice to compile and link custom code during your run, in order to make sure the programs run correctly. 

So we can load the gcc module:
```bash
#!/bin/bash
#SBATCH --job-name=OMP_TEST
#SBATCH --output=omp_output.log
# Number of processors
#SBATCH -N 1
# Number of cores
#SBATCH -c 4
#SBATCH --partition=Standard

# Set OMP_NUM_THREADS to the same value as -c
# with a fallback in case it isn't set.
# SLURM_CPUS_PER_TASK is set to the value of -c, but only if -c is explicitly set
if [ -n "$SLURM_CPUS_PER_TASK" ]; then
  omp_threads=$SLURM_CPUS_PER_TASK
else
  omp_threads=1
fi

export OMP_NUM_THREADS=$omp_threads

# Clear the environment from any previously loaded modules
module purge > /dev/null 2>&1

module load gcc
``` 

We can call the compiler as usual:

```bash
#!/bin/bash
#SBATCH --job-name=OMP_TEST
#SBATCH --output=omp_output.log
# Number of processors
#SBATCH -N 1
# Number of cores
#SBATCH -c 4
#SBATCH --partition=Standard

# Set OMP_NUM_THREADS to the same value as -c
# with a fallback in case it isn't set.
# SLURM_CPUS_PER_TASK is set to the value of -c, but only if -c is explicitly set
if [ -n "$SLURM_CPUS_PER_TASK" ]; then
  omp_threads=$SLURM_CPUS_PER_TASK
else
  omp_threads=1
fi

export OMP_NUM_THREADS=$omp_threads

# Clear the environment from any previously loaded modules
module purge > /dev/null 2>&1

module load gcc

gcc -o spiedie_omp open_mp.c -fopenmp
```

and finally, we can instruct the script to run the program: 

```bash
#!/bin/bash
#SBATCH --job-name=OMP_TEST
#SBATCH --output=omp_output.log
# Number of processors
#SBATCH -N 1
# Number of cores
#SBATCH -c 4
#SBATCH --partition=Standard

# Set OMP_NUM_THREADS to the same value as -c
# with a fallback in case it isn't set.
# SLURM_CPUS_PER_TASK is set to the value of -c, but only if -c is explicitly set
if [ -n "$SLURM_CPUS_PER_TASK" ]; then
  omp_threads=$SLURM_CPUS_PER_TASK
else
  omp_threads=1
fi

export OMP_NUM_THREADS=$omp_threads

# Clear the environment from any previously loaded modules
module purge > /dev/null 2>&1

module load gcc

gcc -o spiedie_omp open_mp.c -fopenmp

./spiedie_omp
```
The final run script can be downloaded <a href="code/omp_run.sh" download> here</a>

## <a name="mpi_submit"></a> Submitting the Run Script for OpenMPI

We can submit our script by simply using: 

```bash
sbatch omp_run.sh
```
The job should run pretty quickly, but since we are running on the Standard compute nodes the time may vary depending on their current load.

You can monitor the job status but running

```bash
squeue | grep username
```
replacing *username* with your username.

Once the job is complete you can view the output by using ```cat```. You should expect to see an output like this:

```bash
[spiedie81 openMP-tutorial]$ cat omp_output.log 
Greetings from process 1 out of 4 
Greetings from process 0 out of 4 
Greetings from process 3 out of 4 
Greetings from process 2 out of 4 
parallel for ends.
```

We can also change the number of cores being assigned by using:

```bash
sbatch -c 2 omp_run.sh
```
The output for this should be:

```bash
[spiedie81 openMP-tutorial]$ cat omp_output.log 
Greetings from process 0 out of 2 
Greetings from process 1 out of 2 
parallel for ends.
```

Congratulations, you've run your first openMP script!



