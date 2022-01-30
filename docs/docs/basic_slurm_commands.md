---
title: Basic SLURM Commands
layout: default
images: []
tags: [Submit job, Run Program, Check Job Status, srun, sbatch, sacct, sinfo]
description: A walk-through of the essential slurm commands to run programs, check usage and job status, and manipulate job states on Spiedie.
category: documentation
---

***
### Table of Contents 

1. [Checking cluster info](#info)
2. [Running a program](#run)
3. [Checking the Queue](#queue)
4. [Kill, stop or restart](#ksr)
5. [Check account utilization](#util)
***

## <a name="info"></a> Checking Cluster Info

#### <a name="info"></a>sinfo

To see the status, such as availability, time limit, number of nodes of the cluster and partition run 

``` bash 
sinfo 
```

[Click here for more information on the cluster partitions and architecture](cluster_info.html)
## <a name="run"></a> Running a Program

#### Using srun 
To quickly run a program for prototyping or testing small programs run: 

``` bash 
srun -N 1 --partition=quick ./exectubale 
```  
This will allocate one node for a default amount of time on the quick partition. We suggest to use the quick partition as they are limited to 10 minutes per job and are generally easier to find allocation on.

[Click here for more information on the srun command and parameters.](submitting_jobs.html)

#### Using sbatch 
For larger and more complex jobs, it is best practice to write a run script to automate module loading, passing environment variables, generating input and output files, and then running the executable. 

[Click here for more information on writing batch scripts for sbatch.](submitting_jobs.html) 

``` bash 
sbatch run_script.sh 
```

## <a name="queue"></a>Checking the Queue 

#### squeue 

To see the entire current job queue active and pending use: 

``` bash 
squeue
```

To check a particular users job queue use: 
``` bash 
squeue -u username
```

## <a name="ksr"></a>Kill, stop or restart a job 

To kill a specific program by Job ID:

``` bash
scancel jobId
```

To kill all the jobs by a user:

```bash 
scancel -u username 
```

To kill all the pending jobs by a user:

``` bash
scancel -u username --state=pending
```

To stop a running job: 

``` bash
scancel -s SIGSTOP jobId
```

To restart a stopped job: 

``` bash
scancel -s SIGCONT jobId
```
## <a name="util"></a>Check utilization history

#### sacct 

To check the utilization of allocation: 

```bash 
sacct
``` 


