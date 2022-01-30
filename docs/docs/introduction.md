--- 
title: A Quick Introduction to Spiedie
layout: default 
images: []
tags: [New_User]
description: Welcome to Spiedie and Binghamton University. Glance through here to learn about computer clusters and Spiedie's computing capabilities. 
category: getting-started
---

### Table of Contents 
1. [What is a Cluster?](#cluster-info)
    1. [What is a node? ](#node-info)
2. [Running jobs on a Cluster](#cluster-programs)
3. [Best practices](#best-practices)  


## <a name="cluster-info"></a> What is a cluster?
A cluster is a group of computers or "node"  interconnected through hardware, networks and software to behave as if they were a single system. Some of the advantages of having a high performance clusters are high availability, load balancing, parallel processing, systems management and scalability. 

#### <a name="node-info"></a> What is a node?


A node is the name usually used for one unit (usually one computer) in a computer cluster. Generally, this computer will have one or two CPUs, each normally with more than one core. The memory is always shared between cores on the same CPU, but generally not between the CPUs. This means programs using only multi-threaded, shared memory programming interfaces, like OpenMP, is not generally suited for clusters, unless there are many cores per CPU and much memory per CPU.

## <a name="cluster-programs"></a> Running jobs on a cluster?


In general, jobs are run with a batch- or queuing system. There are several variants of these, with the most common working by the user logging into a "login node" and then putting together and submitting their jobs from there.

In order to start the job, a "job script" will usually be utilized. In short, it is a list of commands to the batch system, telling it things like: how many nodes to use, how many processors, how much memory, how long to run, program name, any input data, etc. When the job has finished running, it will have produced a number of files, like output data, perhaps error messages, etc.

#### <a name="slurm-info">What is SLURM?</a>

The Simple Linux Utility for Resource Management (SLURM) is an open source, highly-scalable resource management and job scheduling system for submitting, executing, monitoring, and managing batch jobs (typically, parallel jobs) on high-performance Linux clusters.

Slurm has three key functions. First, it allocates exclusive and/or non-exclusive access to resources (compute nodes) to users for some duration of time so they can perform work. Second, it provides a framework for starting, executing, and monitoring work (normally a parallel job) on the set of allocated nodes. Finally, it arbitrates contention for resources by managing a queue of pending work.

## <a name="best-practices">Best practices</a>	

1. Don't run programs on the head node
2. Request appropriate resources for your job 
