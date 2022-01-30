---
title: FAQs
layout: default
images: [] 
tags: [New_User, FAQ]
description: Freqeuntly Asked Questions on how to get access to and use Spiedie
category: getting-started
---

***

## FAQs

### Questions
1. [How do I get a Spiedie account?](#get_spiedie)
2. [What are the available resources?](#spiedie_resources)
3. [Why can't I log in from my laptop?](#remote_login)
4. [Why can't I use the sudo command?](#no_sudo)
5. [How do I run a program?](#run_program)
6. [How do I install new programs?](#install_question)
7. [When will my program run?](#wait_times)
8. [Why did my job abruptly finish?](#job_failures)

##### <a name="get_spiedie"></a> How do I get a Spiedie account?

- A faculty member can request access through the system admin. 
<a href="gain_access.html" target="_blank">You can learn more about the subscription policies and request forms here </a> 

##### <a name="spiedie_resources"></a> What are the available resources?

- Spiedie currently has 166 Compute Nodes with 512 Knights Landing Cores, 9 nVidia p100 GPUs, and 292 TB of Infiniband connected NFS Storage. 

[Learn more about the various partitions and features here](spiedie_partitions.html) 

##### <a name="remote_login"></a> Why can't I log in from my laptop?

- You must be assigned a Spiedie account in order to gain access to Spiedie. You ***cannot*** use your PODS account. You can only log in through the school internet connection or through a vpn if you are off-campus. [Follow the instructions here to log in](login.html)

##### <a name="no_sudo"></a> Why can't I use the sudo command?

- All users have super user privileges revoked by default and will not be given root access.  

##### <a name="run_program"></a> How do I run a program?

- Spiedie uses SLURM workload manager to run the job queue and schedule users jobs. You can learn about SLURM and how submitting jobs work [here](basic_slurm_commands.html) and [here](submitting_jobs.html)

##### <a name="install_question"></a> How do I install new programs?

- Since you will not have root privileges, you must either build from source (custom code should be always compiled on Spiedie prior to running),or use Conda or Singularity. 

##### <a name="wait_times"></a> When will my program run?

- The job queue is managed by SLURM and depends on the job size, current availability, job and user priority. 

- If you wish to run a quick test file, it is recommended you use the quick partition which has a run time of 10 minutes per job. 

##### <a name="job_failures"></a> Why did my job abruptly finish?

- Job failures are often associated with mis-configured run parameters. Exceeding memory allocation, or time allocation will result a failed job. Only certain partitions can handle high memory, or high CPU jobs and exceeding node allocations will result in a job failure. 

- For GPU-accelerated programs, it is recommended to use double the video memory allocation for memory allocation, in order to make sure the program is not canceled. 
