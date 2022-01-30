---
title: OpenMP on Spiedie (advanced)
layout: default 
images: [] 
tags : [tutorial, multicore]
description: How to run a multi-threaded program to take advantage of Spiedie's many-core nodes
category: tutorial
--- 


***

Things covered in this tutorial:

1. [Writing batch scripts for multi-core programs](#sbatch_omp)
3. [Suitable Partitions for job requirements](../docs/spiedie_partitions.html) 
2. [Compiling and linking on the fly](../docs/spiedie_modules.html)

We assume you have familiarity with the OpenMP interface. 

<a href="http://www.openmp.org" target="_blank"> Click here if you would like to learn more</a>


## <a name="sbatch_omp">Writing batch scripts for multi-core programs</a>

We are going to run a multi-core program which will utilize shared memory parallelism in a single node for high performance computing.

***Note: If you would like to utilize parallelization using multiple nodes, checkout the MPI tutorial [here](spiedie_MPI.html)***

We've provided a simple openmp program source code <a href="code/open_mp.c" download> here</a>. 

The simple program prints out a message for each active thread: 

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

Let's write a run script omp_run.sh to run our program.

First of all, we will include the shebang, as usual,

```bash
#!/bin/bash
```

Let's name our job with 

```bash
#SBATCH --job-name=OMP_TEST
```

Also, we can assign our output file name with: 

```bash
#SBATCH --output=omp_output.log
```

Since we are using OpenMP and shared memory parallelism, we will only be using a single compute node: 

```bash
#SBATCH -N 1
```

We will set the number of cores to 4 with:
```bash
#SBATCH -c 4
```


It is good practice to clear the environment from any previously loaded modules
```bash
module purge > /dev/null 2>&1
```

The following line sets
We are now going to dynamically assign the number of OpenMP threads the program utilizes depending on the -c parameter we used above. 

The following line sets the OMP_NUM_THREADS to the same values as -c: 

```bash
if [ -n "$SLURM_CPUS_PER_TASK" ]; then
  omp_threads=$SLURM_CPUS_PER_TASK
```

In case the -c is not set, we fall back to 1 core (as is the default):

```bash
else
  omp_threads=1
```

Export the value to complete the process:
```bash
export OMP_NUM_THREADS=$omp_threads
```
## Suitable Partitions for job requirements

Depending on the number of cores being used, it is a good idea to consider with partition would be the suitable for our program. [The details for the partitions and the number of cores available per compute node can be found here](../docs/spiedie_partitions.html)

If you are using more thant 20 cores, it is recommended to assign the partition to KNL nodes. 

In our test, we will use the standard partition due to our relatively small number of cores. 

```bash
#SBATCH --partition-standard
```

## Compiling and linking on the fly

It is good practice to compile and link custom code during your run, in order to make sure the programs run correctly. 

So we can load the gcc module with:
```bash
module load gcc
``` 

We can call the compiler as usual:

```bash
gcc -o spiedie_omp open_mp.c -fopenmp
```
and, run the program: 

```bash
./spiedie_omp
```


##  Submitting the job

We can submit our script by simply using: 

```bash
sbatch omp_run.sh
```

We can also change the number of cores being assigned by using:

```bash
sbatch -c 2 omp_run.sh
```


