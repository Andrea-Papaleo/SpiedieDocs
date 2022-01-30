---
title: Conda vs. Singularity vs. Modules
layout: default 
images: []
tags: [Conda, Singularity, Modules, Workflow]
description: Identifying which environment solution works best for your workload on Spiedie. 
category: getting-started
---

***

### Table of Contents

1. [Solutions available on Spiedie](#avail_app_solutions)
2. [When to use Modules](#module_uses)
3. [When to use Singularity](#singularity_uses)
4. [When to use Conda](#conda_uses)


***

### <a name="avail_app_solutions"></a> Solution available on Spiedie

Spiedie provides different approaches to load third pirty programs and libraries. 

We have a choice between using 
- [Modules](spiedie_modules.html)
- [Singularity containers](../singularity/)
- [Conda](spiedie_conda.html)

Depending on your workload dependencies, one of the above solutions should get you up and running on Spiedie. 

Here are a few suggestions to help you choose the best solutions. 

***

### <a name="module_uses"></a> When to Use the Modules

***

##### Using a pre-installed scientific software like VASP, Wien2k, or Gaussian without modification? Use Modules if available.


- For third-party scientific software which require little to no modification, if it is available as a module, use it. 
- The system admin has already properly installed and configured the software to run on Spiedie. Simply loading the module 
is the quickest and most efficient solution. 

***


### <a name="singularity_uses"></a> When to Use Singularity

***

##### Need reproducibility? Multiple users working on same project? Use Singularity. 

- Singularity is a container framework that is specifically created for HPC workloads and natively supports GPUs, Infiniband, and MPI etc. 

- The Singularity Image Format (SIF) is a single executable file that can be cryptographically verified, giving you  100% reproducibility for your projects 
and experiments, Since Singularity has drop-in compatibility with nearly environment, the SIF can be shared freely across users and platforms for ease 
of use and collaboration. 

***

##### Need exact versions and every specific environment? Use Singularity.

- The Singularity base image is also immutable. So the version of each package and library get 'locked in' once you have generated your image. 

***

### <a name="conda_uses"></a>When to Use Conda

***



##### Latest supported library and packages? Use Conda. 

- Conda package and environment manager makes is simple to install the latest packages and set up your libraries and environment paths. Conda installs 
all the dependencies required for the package automatically making installing third-packages easier. 

***


##### Writing a quick test program and need unavailable packages? Use Conda. 

- Conda simplifies creating virtual environments and makes creating isolated environments much simpler. The turnaround time for creating a conda environment with all 
desired packages versus building from source or building a new container is much lower. Conda evnironments are available for reuse and can be quickly updated and modified. 


***


##### Wnat to use Intel Math Kernel Library (MKL) accelerated Python and packages? Use Conda

- If you would like to use the MKL accelerated version of Python, Numpy, Scipy and other available packages, it is recommended to use Conda, rather than building each package and python from source. 
