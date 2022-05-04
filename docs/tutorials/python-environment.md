--- 
title: Setting Up a Python Environment
layout: default
images: []
tags: [Python, Conda, Python Program, VirtualEnv]
description: Setting up local python environments for compartmentalizing code
category: tutorial
next: Quick Start Tutorial - Python
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
Upon entering the new environment, we see that `(base)` changed to `(new_env)`, and by deactivating "new_env" we return to the base environment.

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

## <a name="alrernatives"></a> Conda Alternatives

Similar to Conda, using virtual environment alternatives creates a separate workspace for you to install packages and run your python scripts. One main reason why you would choose to use an alternative is that installed packages come from the <a href="https://pypi.org/" target="_blank">Python Package Index</a> (PyPI), which contains more than 350,000 packages. In contrast, the Anaconda package repository has just over 1,500. However, the Anaconda package repository is geared toward scientific computing, and will most likely contain the most used packages for scientific computing with python.

If you find that you need to use a package not included in the Anaconda repository, you can follow the instructions below for alternative environments.

### <a name="virtual-env-whatis"></a> Python Virtualenv

#### <a name="virtualenv_activate"></a> Creating Virtual Environments on Spiedie

Using virtualenv works similarly to conda, the difference is that when you create the virtual environment in the command line, you call virtualenv from python.

The default installation of python3 on the cluster may throw an error when creating the environment, therefore you should install python37 module first, and confirm the python3 command calls the correct interpreter.

```bash
[username@spiedie81 ~]$ module add python37
[username@spiedie81 ~]$ which python
/cm/local/apps/python37/bin/python
```

Once you have the correct version of python, you can create the virtual environment by typing 

```bash
[username@spiedie81 ~]$ python3 -m venv /path/to/env
```

The `-m` here stands for module name, which in this case is the `venv` module. Then the `/path/to/env/` will be a directory which you create that stores the information needed for you python environment in addition to the executable. If the directory doesn't already exist then one will be created.

The created directory will have a structure similar to this

```bash
├── bin
│   ├── activate
│   ├── activate.csh
│   ├── activate.fish
│   ├── easy_install
│   ├── easy_install-3.5
│   ├── pip
│   ├── pip3
│   ├── pip3.5
│   ├── python -> python3.5
│   ├── python3 -> python3.5
│   └── python3.5 -> /Library/Frameworks/Python.framework/Versions/3.5/bin/python3.5
├── include
├── lib
│   └── python3.5
│       └── site-packages
└── pyvenv.cfg
```
An explanation of the folders is below

| **Folder** | **Description**|
|---|---|
|bin| Contains files that interact with the virtual environment|
|include| Contains the C headers that compile the python packages|
|lib| Contains a copy of the Python version along with a site-packages folder where each dependency is installed|


#### <a name="virtualenv_activate"></a> Activating Environment 

Inside the bin directory are the activate scripts. These are used to set up your shell to use the environment's python interpreter and site-packages. Start the environment by typing,

``` bash 
[username@spiedie81 ~]$ source /path/to/env/bin/activate
```

So for example creating and running a new python environment would look something like this.

```bash
[username@spiedie81 ~]$ python3 -m venv new-env

[username@spiedie81 ~]$ source new-env/bin/activate

(new-env)[username@spiedie81 ~]$
```
Just like with Conda, the command line is prefixed with the environment name.

#### <a name="virtualenv_deactivate"></a> Deactivate environment

To exit the environment, run:
``` bash
(new-env)[username@spiedie81 ~]$ deactivate
```

#### <a name="virtualenv_install"></a> Installing packages

As mentioned, packages can be install from the PyPI repository using the `pip` command.

``` bash
pip install package_name
```
#### <a name="virtualenv_list"></a> Viewing installed packages

To list all the installed packages in the current environment, run: 

```bash
pip list
```


### <a name="virtualenv_doc"></a> Virtualenv External Resources and Documentation

For more information on using virtualenv and documentation, <a href="https://docs.python.org/3/library/venv.html" target="_blank"> click here </a>.

For an expanded tutorial, <a href="https://realpython.com/python-virtual-environments-a-primer/" target="_blank">click here</a>.

