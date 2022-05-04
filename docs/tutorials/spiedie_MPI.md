---
title: MPI on Spiedie (advanced)
layout: default 
images: [] 
tags: [tutorial, mpi, multinode, MVAPICH2, SBATCH]
description: How to run a multi node MPI program on Spiedie.
category: tutorial
prev: Quick Start Tutorial - Python
--- 


One of the advantages of Spiedie is the high performing computing hardware available for each user. In this tutorial, we will be running an MPI Hello World program on Spiedie. 

Covered in this guide:

1. [Compiling a MPI program](#mpi_run)
2. [Run script for MPI](#mpi_sbatch)


## <a name="mpi_run"></a> Compiling a MPI Program

Massage Passing Interface (MPI) is a standardized massage-passing standard used for high performance parallel computing on a distributed network. Spiedie supports the following standards implementations:

1. <a href="https://www.mpich.org/" target="_blank">MPICH</a>
2. <a href="http://mvapich.cse.ohio-state.edu/" target="_blank">MVAPICH(2)</a>
3. <a href="https://www.open-mpi.org/" target="_blank">OPENMPI</a>
4. <a href="https://www.intel.com/content/www/us/en/developer/tools/oneapi/mpi-library.html#gs.zgnm9c" target="_blank">INTEL MPI</a>

We will be using mvapich2 implementation of MPI. We will be using the MPI Hello World Example from Wes Kendall <a href="https://mpitutorial.com/tutorials/mpi-hello-world/" target="_blank"> from here</a>. 

You can download the <a href="code/mpi.c" download> code from here.</a>

### <a name="environment_setup"></a> Set up the Environment

Similar to the previous tutorials, its best to keep our file system organized, so lets create a new directory called *mpi-tutorial*.

```bash
mkdir mpi-tutorial
```

Now exit out of spiedie or open a new terminal window on your local machine. If you haven't downloaded the *mpi.c* file yet, do so now. Once you have the *mpi.c* file, secure copy it to your new folder in spiedie.

```bash
scp path/to/mpi.c username@spiedie.binghamton.edu:mpi-tutorial
```

Back in your spiedie terminal you can verify you have the file in the right place by changing into to *mpi-tutorial* directory and usung ```ls```.

```bash
[spiedie81 ~]$ cd mpi-tutorial/
[spiedie81 mpi-tutorial]$ ls
mpi.c
```

You can use ```cat``` or a text editor to view the contents of *mpi.c*.

mpi.c: 

``` c
#include <mpi.h>
#include <stdio.h>

#include <mpi.h>
#include <stdio.h>

int main(int argc, char** argv) {
    // Initialize the MPI environment
    MPI_Init(NULL, NULL);

    // Get the number of processes
    int world_size;
    MPI_Comm_size(MPI_COMM_WORLD, &world_size);

    // Get the rank of the process
    int world_rank;
    MPI_Comm_rank(MPI_COMM_WORLD, &world_rank);

    // Get the name of the processor
    char processor_name[MPI_MAX_PROCESSOR_NAME];
    int name_len;
    MPI_Get_processor_name(processor_name, &name_len);

    // Print off a hello world message
    printf("Hello world from processor %s, rank %d out of %d processors\n",
           processor_name, world_rank, world_size);

    // Finalize the MPI environment.
    MPI_Finalize();
}
```

The code will print out the name of the compute node, and the rank of the processor. 

We will need the MPI-wrapper for gcc in order to compile the code. 




## <a name="mpi_sbatch"></a> Run script for MPI


#### Preliminaries

In order to set up the necessary dependencies and run our program we need to create a run script and can call it *mpi_run.sh*. You can use whichever text editor you're most comfortable with, however we will be using **emacs**. While in the tutorial folder, type

```bash
emacs mpi_run.sh
```

We have to add the shebang at the beginning of the run script. It is also good practice to name our job so we can add: 
```bash
#!/bin/bash
#
#SBATCH --job-name=MPI_TEST
```

We can pipe our output to a log file with: 

```bash
#SBATCH --output=mpi_out.log
```

#### Resource Allocation 

We will be asking for multiple nodes in our test program with:

```bash
#SBATCH -N 2
```

This asks for 2 compute nodes which will allow us to fully take advantage of the multiple node infrastructure. 

We will also run the program on the quick partition with; 

```bash
#SBATCH --partition=quick
```


There are more sbatch options you can add here, for a more detailed list you can visit the <a href="https://slurm.schedmd.com/sbatch.html" target="_blank">slurm documentation</a>.

#### Running the Program 

Once weve finished defining the sbatch options, we want to set up our runtime environment and then run our program.

Firstly, in order to utilize mpi, we must add the MPI library with:

```bash
module load mvapich2/gcc/64/2.3.2
```
***NOTE: At the time of this writing, the mvapich2 version install on spiedie is 2.3.2. This may change in the future so it is important that you find the currently installed version and use that library.***

After we've loaded the MPI library, we need to compile our source code with:

```bash
mpicc -o mpi_test mpi.c 
```

Since MVAPICH2 is built with Slurm support on Spiedie, it is best practice to let slurm spin up the processes on the multiple nodes, and so we will use srun to run our program. 

```bash
srun ./mpi_test
```

The final run script can be downloaded <a href="code/mpi_run.sh" download> here</a> :

```bash
#!/bin/bash
#
#SBATCH --job-name=MPI_TEST
#SBATCH --output=mpi_out.log
#
#SBATCH -N 2
#SBATCH --partition=quick
#

module load mvapich2/gcc/64/2.3.2

mpicc -o mpi_test mpi.c

srun ./mpi_test 
```


We can simply run the job with: 
```bash
sbatch mpi_run.sh
```

This should submit the job on Spiedie, and once finished create a log file,  ```mpi_out.log```

We can quickly check the output by running: 

```bash
cat mpi_out.log
```

We expect an output such as,

```bash
Hello world from processor compute030, rank 0 out of 1 processors
Hello world from processor compute031, rank 0 out of 1 processors
```

Thats it, you've run a MPI program!


