---
title: Submitting Jobs on Spiedie
layout: default
images: []
tags:
  [
    SRUN,
    SBATCH,
    Job Submission,
    interactive session,
    memory allocation,
    partitions,
  ]
description: Documentation for srun and sbatch commands
category: getting-started
prev: Viewing Spiedie Resources
next: Spiedie Modules
---

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

## <a name="creating-jobs"></a> Create and Submit a Job

When you want to run a job on the spiedie cluster, there are two main parts that need to be specified. The first of the two is **resource request**. This is when you tell the cluster what your job is going to need to run, i.e. number of nodes/CPUs, expected compute duration, amount of RAM needed, etc.. The next part is **job steps**, which describes the tasks that need to be done, essentially what it is you are truing to run.

Depending on your needs, there are a few ways to go about submitting jobs, if you need to submit a job in real time you can use the **srun** command. Or, if you have a more complex job that you want to submit to the queue and move on to other things, you would use the **squeue** command.

We will first go over submitting jobs via **srun**.

### <a name="srun"></a> Using SRUN

Using **srun** runs the job in the current terminal, blocking other terminal input. Once the job is complete, it relinquishes control of the compute node and allows you to resume input.

**srun** also has an option to run interactively, giving you access to the particular node/CPU via the command line. In this mode you can use the command line in the normal way, with any software/tasks executing on the requested node. You will remain "logged in" to the requested compute node/s until the time limit is reached, you manually exit, or an error occurs.

#### <a name="srun-program"></a> Running a Simple Program with srun

To queue a quick test program use:

```bash
srun -n4 -N1 <program run command>
```

here we have specified to allocate four tasks(cores) (-n4) and one node (-N1), using the defaults for other parameters.

For instance, if we wanted to run a python file called _run.py_ which outputs "hello!" to the screen, using one node and one core, we would type..

```bash
[watson@spiedie81 ~]$ srun -n1 -N1 python run.py
hello!
[watson@spiedie81 ~]$
```

After submitting via srun, the cluster allocated the requested resources and ran the python script. While the process is running, control of the terminal is abdicated. The output of that script is then printed to the console and control is then resumed.

Using **srun** in this way is beneficial if you need to quickly run a single script. If you would instead like to run an interactive session you can also do that.

#### <a name="interactive-session"></a> Interactive Session

A common use case for srun is to open an interactive shell session on a cluster. This allows you to run multiple scripts, get the results immediately, and continue using the current node for other tasks like analysis (if needed to be run on cluster).

To start a interactive session run:

```bash
srun -n1 --partition=<partition_name> --pty bash
```

This will allow direct access to a single node in a specific partition defined by **_parition_name_** once it is available.

Running the same python script in interactive mode would look something like this...

```bash
[watson@spiedie81 ~]$ srun -N1 --partition=quick --pty bash
[watson@compute031 ~]$ python run.py
hello!
[watson@compute031 ~]$
```

Notice how after the srun command we went from "spiedie81" to "compute031" which is a compute node in the quick partition. Once we've been given access to the node, we run the python script as we would on any other terminal, and when it is complete we still have use of the node.

As mentioned earlier, once were done using the node we can exit by typing **exit** or typing **[^d]**. This will bring us back to the head node.

**_NOTE: Its important to exit out of the node when you are done running the processes, otherwise the resource will remain held up until the time limit is reached, preventing others from using it._**

```bash
[watson@compute031 ~]$ exit
exit
[watson@spiedie81 ~]$
```

For more information on partitions, [click here.](spiedie_partitions.html)

For a list of all srun parameters, <a href="https://slurm.schedmd.com/srun.html" target="_blank">click here.</a>

### <a name="sbatch"></a> Using SBATCH

The typical way to run a job on a cluster is to write a submission script and run the sbatch command. This allows for greater control and parameter passing. Also sbatch jobs are stored in internal storage awaiting to be executed and the user can log out without affecting the submitted job.

#### <a name="run-script"></a> Writing a run script

*** Note: Take a look at <a href="https://spiediedocs.binghamton.edu/tutorials/code/example_run_script.sh">example_run_script.sh </a> for a complete run script ***

The very first line of the script must be the shebang. Such as,

```bash
#!/bin/bash
```

##### Directives

We can include sbatch parameter directives after the shebang to specify the parameters we wish to pass to SLURM. sbatch has the same parameters as srun. For a list of all sbatch parameters <a href="https://slurm.schedmd.com/sbatch.html" target="_blank">click here</a>

Some example run script directives would be,

```bash
#!/bin/bash
#SBATCH --job-name=name_of_job
#SBATCH --output=output_file_name.txt
#SBATCH --error=error_file_name.log
#SBATCH --ntasks=1
```

The above directives specify the job name, standard out, standard error file names and the number of tasks. If output and error are not specified, the output and error will be written to slurm_job_name.out by default.

##### Shell Commands

Finally, we can simply append the shell command to instruct SLURM to the desired program.

```bash
#!/bin/bash
#SBATCH --job-name=name_of_job
#SBATCH --output=output_file_name.txt
#SBATCH --error=error_file_name.log
#SBATCH --ntasks=1

program_run_command program
```

Here *program_run_command* is whatever you would use to run you program normally. For example, to run a python script *program_run_command* would instead be *python*, as shown below.

```bash
#!/bin/bash
#SBATCH --job-name=name_of_job
#SBATCH --output=output_file_name.txt
#SBATCH --error=error_file_name.log
#SBATCH --ntasks=1

python run.py
```

Now that a run script has been created, you can submit it using the **sbatch** command.

#### <a name="sbatch-submission"></a> Submitting the run script

To use a run script to submit a job use:

```bash
sbatch --partition=partition_name run_script.sh
```

Once you run the **sbatch** command, You will see your submission on the queue by using **squeue**, along with the requirements needed to be met in order to begin running.

## <a name="resource_alloc"></a> Customizing resource allocation

One of the important advantages of using Spiedie is the flexibility of hardware resources available to the user. You can tailor your resource request to suit the needs of your program.

Proper resource allocation also ensures your program runs as fast and efficiently as possible and does not halt unexpectedly due to hardware resource shortages such as memory. It is also best practice to allocate the right amount of resources for SLURM to work as efficient as possible for the entire cluster.

### <a name="features"></a> Using Spiedie-specific Directives or Features

One way to make sure your programs run properly is to run it on the correct partition, as stated above.

You can also use the feature flag to help properly allocate resources. [For more information on partitions, click here.](spiedie_partitions.html#features)

To make use of a feature, such as the KNL nodes use:

```bash
srun -N1 -n40 -C="knl" ./program_to_run
```

The above command requests 40 cores for the program to run, which is only available on the Knights Landing Nodes. The -C (constraint) flag ensures that the program is only run on KNL nodes.

### <a name="memory_alloc"></a> Increase memory allocation

In order to increase the default memory allocation (2GB), you can use the --mem flag for srun and sbatch to specify the memory needed per node.

For example:

```bash
srun -n1 --mem=4G ./program_to_run
```

The above job requests for 4 GB of memory for the default one node.

You can also request memory per core using the --mem-per-cpu flag.

Hopefully this page has helped you understand how to submit jobs to spiedie. You may have noticed that throughout this part of the documentation we have been submitting scripts which run the python program. The reason for that is that python(v2.7) is installed by default on the cluster, with no extra steps for running a python script. In the next section we will discuss spiedie modules, what they are, and how to install and use them in your scripts.


