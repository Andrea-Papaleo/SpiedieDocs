--- 
title: Setting Up a Python Environment
layout: default
images: []
tags: [Python, Conda, Python Program, VirtualEnv]
description: Setting up local python environments for compartmentalizing code
category: tutorial
---

### Table of Contents  

 1. [Why use Python Environments](#why-use)
 2. [Conda on Spiedie](#conda)  
      * [What is Conda](#conda_intro)
      * [Activating Conda on Spiedie](#conda_activate)
      * [Using Conda](#conda_use)
          * [Creating a Conda environment](#conda_venv)
          * [Viewing available environments](#conda_list)
          * [Activating environment](#conda_env_activate)
          * [Deactivating environment](#conda_env_deactivate)
          * [Installing packages](#conda_install)
          * [Viewing installed packages](#conda_env_list)
      * [Conda Documentation](#conda_doc) 


## <a name="why-use"></a> Why Use Python Environments?

 The main purpose of python environments is to keep your Python projects separated. This is done by isolating the individual environment of your particular project. By setting up different environments, each project can have its own dependencies, completely separated from the dependencies or other projects. This is useful if you need to work with a specific version of a python module, for example.

There are multiple ways to isolate python environments, we go over two popular uses below.

## <a name="conda"></a> Conda on Spiedie

### <a name="conda_intro"></a> What is Conda?

Conda is an open-source package management and environment system. It allows you create isolated virtual environments and install software packages without requiring root access. If a program or package is not available as a [module](spiedie_modules.html), we highly recommend you use Conda to install it and all it's required dependencies. 

### <a name="conda_activate"></a> Enabling Conda on Spiedie

In order to activate Conda at log in on Spiedie, log in and run the following command: 

``` bash
/cm/shared/apps/miniconda/bin/conda init
```

This will make the `conda` command available and it will activate the "base" environment automatically upon log-in.

To see the changes that were made you will need to close the window and log back in. 

You should see the terminal include the base environment tag like: 

```bash
(base)[username@spiedie81 ~]:
```

If you would not like to activate automatically at log in run the following command: 

``` bash 
conda config --set auto_activate_base false
```
One thing to note when using the Conda environment is that installing python modules from PyPi repository (using `pip install ...`) may cause errors, and it it suggested that you use the correct `conda install ...` command.

### <a name="conda_use"></a> Using Conda

#### <a name="conda_venv"></a> Creating a Conda environment

To create a new Conda environment, run: 

```bash
conda create --name environment_name
```

#### <a name="conda_list"></a> Viewing available environments 

To view all the available Conda environments, run: 

``` bash
conda info --env
```

#### <a name="conda_env_activate"></a> Activating environment 

To activate an environment currently created on your system, run: 

``` bash 
conda activate environment_name
```
#### <a name="conda_env_deactivate"></a> Deactivate environment

To exit the environment, run:
``` bash
conda deactivate
```
Note that you can activate Conda environments from within other Conda environments as well, for example 

``` bash
[username@spiedie81 ~]$ conda activate base
(base) [username@spiedie81 ~]$ conda activate new_env
(new_env) [username@spiedie81 ~]$ conda deactivate
(base) [username@spiedie81 ~]$ conda deactivate
[username@spiedie81 ~]$ 
```
Upone entering the new environment, we see that `(base)` changed to `(new_env)`, and by deactivating "new_env" we return to the base environment.

#### <a name="conda_install"></a> Installing packages

``` bash
conda install package_name
```
#### <a name="conda_env_list"></a> Viewing installed packages

To list all the installed packages in the current environment, run: 

```bash
conda list
```


### <a name="conda_doc"></a> Conda External Resources and Documentation

For more information on using Conda and documentation, <a href="https://docs.conda.io/projects/conda/en/latest/user-guide/overview.html" target="_blank"> click here </a>.

To download a quick cheat for Conda, <a href="https://docs.conda.io/projects/conda/en/latest/user-guide/cheatsheet.html" target="_blank">click here</a>.