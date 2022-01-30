--- 
title: Generating and storing images on Sylabs Cloud
layout: default 
images: []
tags: [Singularity, Containers, Create Images, Sylabs Cloud Services, Cloud Storage, Remote Build]
description: Using remote builder on Sylabs cloud to generate images
category: getting-started
---

***   

You can create your own Singularity containers, customized for your personal project needs. We suggest you [install](install-singularity.html) locally and create images on a local machine where you have root access. 

 It is also possible to create your images directly on Spiedie, without further installing Singularity on a local machine. 

 In order to use the remote builder provided by the sylabs, you must 

 1. [Make an Account](#make_account)
 2. [Create a Access Token](#access_token)
 3. [Define a recipe to Build](#using_recipe)
 4. [Sign and verify your container](#verify_container)
 5. [Host your container online](#singularity_push)

***

## <a name="make_account"></a> Make and account

 In order to use the Singularity Cloud Services (SCS), you must create an account. 

 1. Go to <a href="https://cloud.sylabs.io/library" target="_blank">https://cloud.sylabs.io/library</a>
 2. Click "Sign in to Sylabs" 
 3. Select method to sign in, with Google, GitHub, GitLab, or Microsoft
 4. Follow the steps to create passwords 


## <a name="access_token"></a> Create a Access Token

 To use the remote builder, you must associate an access token with your CLI on Spiedie.

 To generate a access token: 

 1. Go to <a href="https://cloud.sylabs.io/library" target="_blank">https://cloud.sylabs.io/library</a> and log in 
 2. Click on the username to access account dashboard
 3. select Access Token from the dropdown meny 
 4. Enter a token name and click "Create a new token"
 5. Copy the token to your clipboard and run the following commands on Spiedie

 ```bash
 cd 
 echo [paste token here] >> .singularity/sylabs-token
 ```

## <a name="using_recipe"></a> Using a recipe to build 

 Once you have completed the above steps, you can use the remote builder to generate 
 your images on the cloud and download it onto Spiedie.

 Select a  pre-configured recipe from [our recipe hub](recipe_hub.html) or use your own, and run the command: 
 ``` bash
 singularity build --remote image.sif definition_file.def 
 ```

 The image should be remotely built and transferred to you working directory for use.

## <a name="verify_container"></a> Sign and verify your container

Singularity 3.0 allowedyou to create PGP keys and use them to sign and verify containers. This ensures an added layer of security while sharing containers to 
ensure you have the correct container and a bit-for-bit reproduction of the original container. 

<a href="https://sylabs.io/guides/3.3/user-guide/signNverify.html#signnverify" >Click here to learn more about Signing and Verifying Containers</a>

## <a name="singularity_push"></a> Host your container online

Once you have created a access token and copied it onto Spiedie, you can also upload your containers to your personal library for ease of sharing. 

You can push your built contier using the push command on Singularity. 

First you must create a project on Sylabs Cloud by going to <a href="https://cloud.sylabs.io/library">https://cloud.sylabs.io/library</a>  and clicking on create a new Project and following the steps. 

Once you have created your image, you can push your built container using: 

```bash
singularity push -U image.sif library://your-username/project-dir/my-container:tags
```

You can obtain the library link from your projects page on the csylabs cloud website. 
