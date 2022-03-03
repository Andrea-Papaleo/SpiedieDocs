---
title: Spiedie Modules
layout: default 
images: [] 
tags : [partitions, features, memory management, modules]
description: Learn about the different specialized partitions set up on Spiedie and best practices to improve Spiedie usage.  
category: getting-started
prev: Submitting Jobs on Spiedie
next: Compiling Source Code on Spiedie
--- 

### Table of Contents

1. [Available Modules](#avail)
2. [Loading a Module](#load)
3. [Unloading a Module](#unload)
4. [Switch Module Files](#switch)
5. [View loaded Modules](#view)
6. [Reload all Modules](#reload)
7. [Module Collections](#collections)
8. [Load Module at log in](#login)
9. [Further uses](#help)


## <a name="module_intro"></a> Spiedie Modules

Spiedie uses a module system to load software into a user's environment. With the exception of some (i.e. python), software on Spiedie is not accessible by sefault, and must be loaded through the module system. The reason for this is to accommodate as many users as possible, as specific versions of software may be needed for different users. The module system enables users to easily switch between different software versions depending on individual need.

### <a name="avail"></a> Available Modules 

To see what modules are available to load, type:

``` bash 
module avail 
```

This command returns a list of modules available to be loaded into the user's environment. You can use the arrow keys to scroll the list if necessary and you can type **q** to exit.

### <a name="list"></a> Listing Modules

You can check which modules you currently have installed in your environment by typing:

``` bash
module list
```
You can see here that there are a few modules loaded by default, it's best to leave these as they are. Any module you load moving foward will show up here until you end your current session.

## <a name="load_unload"></a> Loading and Unloading Modules

Modules can be loaded on login if necessary, however it may be cleaner and more efficient to load modules inside of job scripts or interactive jobs. This compartmentalizing will ensure that your jobs always have the necessary resources to run.

### <a name="load"></a> Loading a Module

To load a module to your current environment, type: 

``` bash 
module load module_name

# example: "module load python"
```

or 

``` bash 
module add module_name

# example: "module add python"
```

For modules that have more than one version, you can specify the exact version by appending a `/` with the version number:

``` bash 
module load module_name/version

# example: "module load python/3.7"
```

***Note: Loaded modules are available on your path for your current session. So jobs queued with srun will have access to them. Jobs queued with sbatch will need to load the modules again in order to have access to them***

### <a name="load_in_script"></a> Loading Modules in a Job Script

Modules loaded in a job script exist only in the environment created by the submission script, meaning that you wont have access to the modules in your normal environment. The modukes in a job script can be loaded after your `#SBATCH` directives and before your actual executable is called. For example, a script that loads the Python module into the environment would look like the following:

``` bash
#!bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=python-job
#SBATCH --output=python-job.%j.out

module load python/3.7.0

python3 test-program.py
```

### <a name="unload"></a> Unloading a Module 

To unload a module from your environment run

``` bash 
module unload module_name
```

or 

``` bash 
module rm module_name
```

### <a name="switch"></a> Switch Module files

The switch/swap subcommand is essentially a combination of the `module load` and `module unload` commands. You can switch out a module by typing: 

``` bash 
module switch  module_file1 module_file2

# example "module switch python/2.7.0 python/3.7.0"
```
or 

``` bash 
module swap  module_file1 module_file2

# example "module swap python/2.7.0 python/3.7.0"
```

### <a name="reload"></a> Reload all Modules
To reload the loaded files and reset the PATH run: 

``` bash 
module reload 
```
 or 


```bash
module refresh 
```
### <a name="collections"></a> Module Collections

Module collections is a feature which comes in handy when you have a set of modules which are frequently loaded together. Instead of loading them individually, you can create a store which can be loaded at another time. To save the current set of loaded modules to a collection to be used later, run: 

```bash
module save collection_name
```

To restore modules from the saved collection, run: 

```bash
module restore collection_name
```

To see all available collections, run: 

```bash
module saveshow
```


### <a name="help"></a>Further Uses

For further options for the module command, run:

``` bash
module help
```
