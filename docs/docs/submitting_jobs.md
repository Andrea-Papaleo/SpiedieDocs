--- 
title: Submitting Jobs on Spiedie
layout: default 
images: [] 
tags: [SRUN, SBATCH, Job Submission, interactive session, memory allocation, partitions]
description: Documentation for srun and sbatch commands 
category: getting-started
---


***



### Table of Contents 

1. [Using srun](#srun)
    1. [Running a program](#srun-program) 
    2. [Interactive Session](#interactive-session)
2. [Using sbatch](#sbatch)
    1. [Writing a run script](#run-script)
        1. [Directives](#directives)
        2. [Run commands](#sbatch-program)
    2. [Job Submission](#sbatch-submit)
3. [Customizing resource allocation](#resource-alloc) 
    1. [Using Spiedie-specific Directvies or Features](#features)
    2. [Increase memory allocation](#mem-alloc)
## <a name="srun"></a> Using srun 

Both the srun and sbatch command have similar capabilities and set of parameters. srun is used to submit a job for execution in real time and blocks the terminal. You will not be able to issue other commands while the program executes and must have an open connection while the program runs. It is generally recommended to use srun for quick test runs and for simple workflows. 


#### <a name="srun-program"></a>Running simple program

To queue a quick test program use:

``` bash
srun -n4 -N1 <program run command>
``` 

here we have speciefied to allocate one node (-N1) and four tasks(cores) (-N4), and use defaults for other parameters. 

#### <a name="interactive-session"></a> Interactive Session

A common use case for srun is to open an interactive shell session on a cluster.   

To start a interaactive session run: 

```bash 
srun -n1 --partition=<partition_name> --pty bash 
```

This will allow direct access to a single node in a specific partition defined by ***parition_name*** once it is available. 

For more information on partitions, [click here.](spiedie_partitions.html)
For a list of all srun parameters, <a href="https://slurm.schedmd.com/srun.html" target="_blank">click here.</a>

## <a name="sbatch"></a> Using sbatch

The typical way to run a job on a cluster is to write a submission script and run the sbatch command. This allows for greater control and parameter passing. Also sbatch jobs are stored in internal storage awaiting to be executed and the user can log out without affecting the submitted job.

#### <a name="run-script"></a> Writing a run script 

*** Note: Take a look at <a href="https://spiediedocs.binghamton.edu/tutorials/code/example_run_script.sh">example_run_script.sh </a> for a complete run script ** 

The very first line of the script must be the shebang. Such as, 

``` bash 
#!/bin/bash
```

##### Directives 

We can include sbatch parameter directives after the shebang to specify the parameters we wish to pass to SLURM. sbatch has the same parameters as srun. For a list of all sbatch parameters <a href="https://slurm.schedmd.com/sbatch.html" target="_blank">click here</a>

Some example run script directives would be, 

``` bash 
#SBATCH --job-name=name_of_job
#SBATCH --output=output_file_name.txt
#SBATCH --error=error_file_name.log
#SBATCH --ntasks=1
```

The above directives specify the job name, standard out, standard error file names and the number of tasks. If output and error are not specified, the output and error will be written to slurm_job_name.out by default. 

##### Shell Commands

Finally, we can simply append the shell command to instruct SLURM to the desired program. 

``` bash
program_run_command program 
```

For example to run a python script we would write: 

``` bash
python python_Script.py
```

##### Parallel Programs

To run a MPI program, we would write: 

``` bash 
module load OpenMPI 
srun MPI_program.mpi 
```
It is recommended to use srun inside of the sbatch run script, as srun automatically launches the required processes. 

module load OpenMPI loads the MPI runtime library prior to running the program. [For more information on modules, click here.](spiedie_modules.html)


#### <a name="sbatch-submission"></a> Submitting the run script

To use a run script to submit a job use:

``` bash 
sbatch --partition=partition_name run_script.sh 
```

## <a name="resource_alloc"></a> Customizing resource allocation

One of the important advantages of using Spiedie is the flexibility of hardware resources available to the user. You can tailor your resource request to suit the needs of your program. 

Proper resource allocation also ensures your program runs as fast and efficiently as possibile and does not halt unexepectedly due to hardware resource shortages such as memory. It is also best practice to allocate the right amount of resources for SLURM to work as efficient as possible for the entire cluster. 


#### <a name="features"></a> Using Spiedie-specific Directvies or Features

One way to make sure your programs run properly is to run it on the correct partition, as stated above. 

You can also use the feature flag to help properly allocate resources. [For more information on partitions, click here.](spiedie_partitions.html#features)

To make use of a feature, such as the KNL nodes use:

``` bash
srun -N1 -n40 -C="knl" ./program_to_run
```

The above command requests 40 cores for the program to run, which is only available on the Knights Landing Nodes. The -C (constraint) flag ensures that the program is only run on KNL nodes. 

### <a name="memory_alloc"></a> Increase memory allocation

In order to increase the default memory allocation (2GB), you can use the --mem flag for srun and sbatch to specify the memory needed per node. 

For example: 

``` bash
srun -n1 --mem=4G ./program_to_run
```

The above job requests for 4 GB of memory for the default one node. 

 
You can also request memory per core using the --mem-per-cpu flag.  




