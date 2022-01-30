---
title: Spiedie Modules
layout: default 
images: [] 
tags : [partitions, features, memory management, modules]
description: Learn about the different specialized partitions set up on Spiedie and best practices to improve Spiedie usage.  
category: getting-started
--- 

***

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

#### <a name="avail"></a> Available Modules 
To view all available modules run: 

``` bash 
module avail 
```

#### <a name="load"></a> Loading a Module

To load a module to your current environment run: 

``` bash 
module load module_name
```

or 

``` bash 
module add module_name
```

***Note: Loaded modules are available on your path for your current session. So jobs queued with srun will have access to them. Jobs queued with sbatch will need to load the modules again in order to have access to them***

#### <a name="unload"></a> Unloading a Module 

To unload a module from your environment runL 

``` bash 
module unload module_name
```

or 

``` bash 
module rm module_name
```

#### <a name="switch"></a> Switch Module files

To switch module_file1 with module_file2, run: 

``` bash 
module switch  module_file1 module_file2
```

#### <a name="view"></a> View Loaded Modules

To view the modules currently loaded, run:

```bash 
module list 
```

#### <a name="reload"></a> Reload all Modules
To reload the loaded files and reset the PATH run: 

``` bash 
module reload 
```
 or 


```bash
module refresh 
```
#### <a name="collections"></a> Module Collections

To save the current set of loaded modules to a collection to be used later, run: 

```bash
module save filename
```

To restore modules from the saved collection, run: 

```bash
module restore collection_name
```

To see all available collections, run: 

```bash
module saveshow
```


#### <a name="login"></a> Load Modules at Log in 

You can set up your environment such that modules are automatically loaded when you log in everytime. To add module to the initial list of loaded modules, run: 

```bash
module initadd module_name 
```

#### <a name="help">Further Uses</a>

For further options for the module command, run:

``` bash
module help
```
