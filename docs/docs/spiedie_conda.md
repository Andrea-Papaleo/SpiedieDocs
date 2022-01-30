---
title: Conda on Spiedie
layout: default
images: []
tags: [Conda, virtual environment]
description: A quick guide on enabling and using the Conda environment manager on Spiedie. 
category: getting-started
---

### Table of Contents 
1. [What is Conda](#conda_intro)
2. [Activating Conda on Spiedie](#conda_activate)
3. [Deactivating Conda](#conda_deactivate)
4. [Using Conda](#conda_use)
    1. [Creating a Conda environment](#conda_venv)
    2. [Viewing available environments](#conda_list)
    3. [Activating environment](#conda_env_activate)
    4. [Deactivating environment](#conda_env_deactivate)
    3. [Installing packages](#conda_install)
    4. [Viewing installed packages](#conda_env_list)
5. [Conda Documentation](#conda_doc)

## <a name="conda_intro"></a> What is Conda?

Conda is an open-source package management and environment system. It allows you create isolated virtual environments and install software packages without requiring root access. If a program or package is not available as a [module](spiedie_modules.html), we highly recommend you use Conda to install it and all it's required dependencies. 

## <a name="conda_activate"></a> Activating Conda on Spiedie

---

In order to activate Conda at log in on Spiedie, log in and run the following command: 

``` bash
/cm/shared/apps/miniconda/bin/conda init
```

Then, close the window and log back in. 

You should see the terminal include the base environment tag like: 

```bash
(base)[username@spiedie81 ~]:
```

If you would like to disable Conda at log in and would like to use Conda, run: 

```bash 
conda activate 
```
## <a name="conda_deactivate"></a> Deactivating Conda

If you would not like to activate automatically at log in run the following command: 

``` bash 
conda config --set auto_activate_base false
```

## <a name="conda_use"></a> Using Conda

---

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

To return to the base environment, run:
``` bash
conda deactivate
```

#### <a name="conda_install"></a> Installing packages

``` bash
conda install package_name
```
#### <a name="conda_env_list"></a> Viewing installed packages

To list all the installed packages in the current environment, run: 

```bash
conda list
```


## <a name="conda_doc"></a> Conda External Resources and Documentation

For more information on using Conda and documentation, <a href="https://docs.conda.io/projects/conda/en/latest/user-guide/overview.html" target="_blank"> click here </a>.

To download a quick cheat for Conda, <a href="https://docs.conda.io/projects/conda/en/latest/user-guide/cheatsheet.html" target="_blank">click here</a>.