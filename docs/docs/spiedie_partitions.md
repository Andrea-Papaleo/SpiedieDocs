---
title: Spiedie Partitions and Features
layout: default 
images: [] 
tags : [partitions, features, memory management]
description: Learn about the different specialized partitions set up on Spiedie and best practices to improve Spiedie usage.  
category: documentation
--- 

***

### Table of Contents 
1. [Partitions](#partitions)
2. [Features](#features)

***

## <a name="partitions"></a> Partitions

The nodes on Spiedie are partitioned into 4 distinct sets depending on the resources available.   

#### Quick 

For programs with short run times. Ideal for testing out your code as queue remains small due to the 10 min time restriction of the partition. Use this partition for jobs that will finish immediately and you need the results right away. 


#### Standard / DefQ

Standard and Default queue are the standard compute nodes used by default. The memory and cpu allocation for this partition are restricted, as some nodes are hardware limited. If you do not need specialized hardware (i.e. GPU) or massive multi-core support and high memoery( > 16 cores), these partitions are ideal.  

#### Knights Landing 

The Knights Landing partition contains the nodes with 64 cores per socket and 4 threads per core Xeon phi cpus. The partition should be used for extremely multithreaded tasks that really on parallel computation (like openMP) and not message parsing (MPI. 

#### GPU 

THe GPU partition nodes contain NVidiaP100 GPU's for CUDA-accelerated programs. These nodes should only be primarily used for GPU-accelerated programming. Each node contains a 12 GB P100 GPU with 28 available cores and 128 or 256 GB of memory. 

Although you are able to run non-GPU accelerated code on these nodes, it is best practice to not do so in order to not bottleneck users trying to use the GPU's 

***

## <a name="features"></a>Features

Spiedie also has specific feature flags that users can use to quickly choose nodes that may fit their needs. Below are all the available features combinations users can request. 

You can select nodes by memory size, cpu architectures and GPU.


|      Features      	| Available Memory(MB) 	|             Nodelist             	| Sockets &nbsp;	| &nbsp;  CPUs per Socket  &nbsp; 	|  &nbsp; Threads per CPU &nbsp; 	|
|:------------------:	|:--------------------:	|:--------------------------------:	|:-------:	|:-------------------:	|:------------------:	|
|   X5690,SmallMem   	|        48000,        	|         compute[021-031]         	|    2    	|          6          	|          1         	|
|    E5v4,SmallMem   	|        64000+        	| compute[109-129,146-152,154-160] 	|    2    	|          8          	|          1         	|
|   X5690,LargeMem   	|        144000+       	|     compute[000-001,016-020]     	|    2    	|          6          	|          1         	|
|    X5690,MedMem    	|        96000,        	|         compute[002-015]         	|    2    	|          6          	|          1         	|
|     E5v2,MedMem    	|        96000,        	|         compute[032-059]         	|    2    	|          8          	|          1         	|
|    E5v2,LargeMem   	|        128000,       	|            compute060            	|    2    	|          8          	|          1         	|
|     E5v3,MedMem    	|        128000+       	|         compute[061-079]         	|    2    	|          8+         	|          1         	|
|     E5v4,MedMem    	|        128000,       	|         compute[080-107]         	|    2    	|          12         	|          1         	|
|  LargeMem,Scalable 	|        256000,       	|         compute[143-144]         	|    2    	|          20         	|          1         	|
|    E5v4,LargeMem   	|        128000,       	|         compute[145,153]         	|    2    	|          10         	|          1         	|
|  Scalable,LargeMem 	|        256000+       	|         compute[161-165]         	|    2    	|         14+         	|          1         	|
|  E5v4,P100,MedMem  	|        128000,       	|         compute[130-131]         	|    2    	|          14         	|          1         	|
| E5v4,P100,LargeMem 	|        256000,       	|         compute[132-133]         	|    2    	|          14         	|          1         	|
|      E5v4,P100     	|        128000,       	|            compute142            	|    2    	|          14         	|          1         	|
|         knl        	|        96000,        	|         compute[134-141]         	|    1    	|          64         	|          4         	|


***

***Legend:*** 

SmallMem: Default

MedMem: For jobs requiring > 48 GB of RAM

LargeMem: For jobs requiring > 96 GB of Ram 

P100: GPU

knl: Knights Landing CPU's
