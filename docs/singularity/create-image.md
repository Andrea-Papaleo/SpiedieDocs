---
title: Create Singularity Images
layout: default
images: []
description: Creating your own custom container
tags: [singularity, containers, docs, custom container, create image] 
category: getting-started
---


*** 

You can build a container using five possible inputs. 

The possible type of targets for the build commands are: 

1. [URI beginning with library://](#library-link)
2. [URI beginning with docker://](#docker-link)
3. [URI beginning with shub://](#shub-link)
4. [Existing container](#existing-container)
5. [Singularity definition file or recipe](#singularity-definition)

***
***Note: The build procedure requires root access and therefore cannot be performed on Spiedie. You must build your image locally and then run it*** 

You can take advantage of all the community built containers available on various container hubs as a starting point for your image. Singularity natively supports the Singularity Cloud, Docker Hub and Singularity Hub libararies on its command line for building, pulling and executing images. 

#### <a name="library-link"></a> Build from Sylab Library Image

To use a <a href="https://cloud.sylabs.io/home" target="_blank">Singularity Cloud</a> pre-built image, run the following: 

``` bash 
sudo singularity build image_name.simg library://library/default/ubuntu
```

The above will generate a default ubuntu image downloaded from the Singularity Cloud library. 

***Note: Third-party containers may not work as expected on Spiedie***

#### <a name="docker-link"></a> Build from Docker Hub Image

You can also take advantage of docker containers on Singularity as well. You can use a docker container from [here](https://hub.docker.com/) and run: 

``` bash 
sudo singularity build image_name.simg docker://ubuntu
```

This will build an image with the official [docker image container of Ubuntu](https://hub.docker.com/_/ubuntu). 

***Note: Third-party containers may not work as expected on Spiedie***

#### <a name="shub-link"></a> Build from Singularity Hub Image

You can use pre-built images on the [Singularity Hub](https://cloud.sylabs.io/library) as a base for your local image. 

``` bash
sudo singularity build image_name.simg shub://[username]/[repo_name]
```


***Note: Third-party containers may not work as expected on Spiedie***

#### <a name="existing-container"></a> Build from an existing container

If you are more familiar with Docker and have a Docker image created locally, you can convert the image to a singularity image using: 

``` bash 
sudo singularity build image_name.simg /path/to/target/image 
```


#### <a name="singularity-definition"></a> Build from Singularity Definition File

You can also create a singularity image by writing a definition file or singularity recipe. 

<a href="https://singularity.lbl.gov/docs-recipes" target="_blank">Click here for the official documentation on creating recipes</a>

To build an image from a recipe file just use: 

``` bash 
sudo singularity build image_name.simg definition_file.def 
``` 

[Click here for a collectoin of Spiedie-tested container recipes](recipe-hub.html)


This method of creating containers is highly suggested, as it ensures maximum reproducibility. You are also able to create singularity images without ever installing it on your own machine. You can create singularity images on the hub. <a href="https://github.com/singularityhub/singularityhub.github.io/wiki/Build-A-Container">Click here for more information</a> 


