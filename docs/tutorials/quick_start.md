---
title: Quick Start Tutorial - Python
layout: default
images: []
tags: [Tutorial, Python, SLURM, Submit Job, New_User]
description: A walkthrough on how to submit your first job on Spiedie!
category: tutorial
prev: Setting Up a Python Environment
next: MPI on Spiedie (C/MPI)
---

This tutorial is designed to get you up and running on Spiedie as quickly as possible. You should be able to run simple programs on the Spiedie cluster by the end of this guide. 

Things covered in this guide:

1. [Logging on to Spiedie](../docs/connect-to-spiedie.html)
2. [Transferring files to the cluster](../docs/data_transfer.html)
3. [Running SLURM jobs](../docs/submitting_jobs.html)  

Requirements to complete the guide:
1. A Spiedie user account and password
2. Computer connected to the internet 
3. SSL VPN (Pulse) (if not connected to the school internet)
4. Familiarity with programming and [basic command-line experience](../docs/basic_linux_commands.md)

## Log in
***

After acquiring your username and password, you should be able to log in to the Spiedie cluster following the steps listed [here](../docs/login.html). 


You will be logged in at your home directory. You can add modules and quickly prototype the code you with to run here. You should ***note*** run any lengthy programs in the log in node as it may cause disruptions for other users. You should only run programs using `srun` and `sbatch`, which will be explained these tutorials. 

Once logged in you can create a new directory by running 

``` bash
mkdir quick_start
```

This will create a new directory called quick_start in your Home directory. You can quickly verify by typing `ls`.


## Transfer files to Cluster 

***

Before we go further, [download](code/quick_start.py) the python script we will be running. [There are various ways to transfer data to and from cluster.](../docs/data_transfer.html)

In this example we will be using SCP to transfer the data from our local machine to the quick_start directory located on the Spiedie server. 

Exit the Spiedie cluster or open a new terminal on your local machine and `cd` into the directory of the downloaded python script and run 

``` bash 
scp quick_start.py username@spiedie.binghamton.edu:quick_start/
```
replace username with your username and fill in your password when prompted. This should place the *quick_start.py* file on the quick_start directory on Spiedie.

To verify the transfer, go back to your logged in  spiedie session and run 

``` bash
[spiedie81 ~]$ cd quick_start/
[spiedie81 quick_start]$ ls
quick_start.py
```
You should see the python file listed on your screen. 


## Run the program 

Since this is a small prototype program we believe will finish quickly, we will run it interactively using `srun`. For larger programs we usually need to write a batch script and use `sbatch`. Running more complex jobs and `srun` and `sbatch` are covered here and [here](../docs/submitting_jobs.md)

Go back to your logged in Spiedie session and make sure you are in the directory of the *quick_start.py*. 

We can take a quick look at the python file by using the `cat` command.

``` bash
[watson@spiedie81 quick_start]$ cat quick_start.py 
import random 
import time 

def rand(start, end, length):
    ret = []
    for i in range(length):
        ret.append(random.randint(start,end))
    return ret

def main():

    start_time = time.clock()
    for i in range (100):
        unsorted_list = rand(0,100000,1000)
        sorted_list = unsorted_list.sort()

    end_time = time.clock()
    print("Welcome to Spiedie!")
    print("You are running the quick start python tutorial.")
    print ("Soritng done")
    print(" I ran for " + str(end_time-start_time) + " s")

main()
[watson@spiedie81 quick_start]$ 
```
A full breakdown of this script is outside the scope of this documentation, but the gist is that it sorts an array of *1000* elements *100* times, measures the time necessary to complete the task, and prints a message to the specified output.

We will interactively run the quick_start.py on Spiedie by using the `srun` command. `srun` will submit our job to the SLURM queue to be allocated, and the output will be printed to the terminal. 

You should familiarize with the different partitions and compute capabilities of Spiedie, as different partitions may be more well suited depending on the task. 

You can get a quick overview of the cluster by running the `sinfo` command.

We'll be using the *quick* partition as it is used mostly for rapid prototyping. You'll notice quick has a time cutoff of 10 minutes, so jobs are automatically cleared after 10 minutes. This makes sure we don't have to wait too long for allocation. Before we ask for allocation on the cluster, we can check how busy the system is by running `squeue`.


This will list all jobs currently running and waiting to be allocated. 
<a href="http://www.ceci-hpc.be/slurm_prio.html" target="_blank">You can learn more about how SLURM priorities work here</a>


Let's run the quick_start.py program. Run 

``` bash 
srun --partition=quick python3 quick_start.py 1>quick_start.log 2>quick_start_error.log &
```

This will send your job to the SLURM daemon to be allocated and then run on a quick partition node. We have chosen to use default parameters for srun such number of nodes (1) and number of tasks (1) and number of CPU's (1). 

It isn't necessary to include the content after you specify the python file. We included the `1>quick_start.log 2>quick_start_error.log` here for convenience as it will direct the outputs of the program to the quick_start.log and quick_start_error.log.

The `&` ant the end of the command will run the process in the background, allowing us to continue using the terminal.

<a href="https://explainshell.com/explain?cmd=srun+--partition%3Dquick+python3+quick_start.py+1%3Equick_start.log+2%3Equick_start_error.log+%26" target="_blank">You can see a full explanation of the shell command here</a>



## Checking job status

Since we retained the control of the terminal we can check the allocation status of the job by running 

``` bash 
squeue -u username
```

Replace `username` with your user name and you should see your job listed as either pending or active and on which node it has been allocated to. 

You can also check your account status using 

``` bash 
sacct 
```
[Click here for a list of other basic SLURM commands.](basic_slurm_commands.html) 

Once the program has finished running, you can view the  output by running 

``` bash 
cat quick_start.log
```

And check for any error messages using 

``` bash 
cat quick_start_error.log 
```


