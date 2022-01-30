---
title: Transfer File to Cluster
layout: default
images: []
tags: [Login, Setup, File Transfer, Windows, Mac, Linux, New_User]
description: A guide to transferring data to and from Spiedie and setting up network drives. 
prev: Spiedie User Environment
category: getting-started
---



***Note: The following steps are only applicable while connected to the university network. If working off-campus, you must connect first to a SSL VPN. [Click here for more details](ssl_vpn.html)*** 


### Table of Contents 

1. [Using SCP](#SCP)
2. [Using RSYNC](#rsync)
3. [Map Home Directory](#Home_dir)
    * [Windows](#windows_map_home)
    * [Mac](#mac_map_home)
    * [Linux](#linux_map_home)






## <a name="SCP"></a> SCP

#### Single File Transfer to/from Spiedie Cluster

SCP (secure copy) is a command-line utility that allows you to securely copy files and directories between two locations.  

``` bash
scp source.ext <username>@spiedie.binghamton.edu:path/to/destination
``` 
Lets look at the components of the scp command:

* `source.ext` is the file you wish to transfer to the remote server.
* `<username>` is the username of your spiedie cluster account.
* `path/to/destination` is the path to the directory you want to transfer to.


To transfer a file **from** spiedie onto your local computer, simply swap the source and destination.

``` bash
scp <username>@spiedie.binghamton.edu:your/desired/directory/file.txt .
```
The `.` at the end is a shortcut for you current working directory.

#### Transferring a Directory to Spiedie Cluster

This is similar to transferring a single file except instead of specifying a file, we specify a directory, `local-directory`, and we add the `-r` flag which tells scp that we are trying to transfer a directory.

``` bash 
scp -r local-directory <username>@spiedie.binghamton.edu:your/desired/destination
```
More informion on SCP can be found <a href='https://linuxize.com/post/how-to-use-scp-command-to-securely-transfer-files/' target="_blank">here</a>.



## <a name="RSYNC"> </a> 2.2.2 Rsync

Similar to SCP, Rsync can also be used to transfer files and folders using the terminal. Rsync differs in that only the portions of the files that have been changed are transferred, minimizing the total amount of data transferred.

Use Rsync when:
  * You are transferring large files.
    * In case of network connection failure mid transfer.
    * The entire file does not need to be transferred, only the parts that changed.
  * When keeping remote and local directories synced.
    * Using the rsync command to sync the directories will only transfer the changed files.

``` bash 
rsync file.ext <username>@spiedie.binghamton.edu:your/desired/directory 
```

A good resource for using Rsync can be found <a href='https://www.digitalocean.com/community/tutorials/how-to-use-rsync-to-sync-local-and-remote-directories' target="_blank">here</a>.


## <a name= "Home_dir"> </a>2.2.3 Mapping Home Directory

You can map your Spiedie home directory to your file explorer if you wish to use a graphical interface for file transfer 

#### <a name="windows_map_home"> </a> Windows Explorer
1. Open a new windows explorer to PC.
2. Click on the computer option on the taskbar and select Map network drive.
3. Select folder letter and paste ```\\spiediefiles.binghamton.edu\username``` to the folder text field. 
4. Make sure to select 'Use different credentials' and click finish.
5. Use Spiedie user name and password for your credentials.

#### <a name="linux_map_home"> </a> Linux File System Viewer (Ubuntu)
1. Open a new system files window.
2. Click on other locations.
3. Enter ``` smb://spiediefiles.binghamton.edu/username``` for the server address, replacing your user name for username and click connect.
4. Click on registered users and use your user name and password to mount the network drive.

#### <a name="mac_map_home"></a> Mac Directory Mapping
1. From the Mac OS X Finder, press Comand+K to bring up the 'Connect to Server' window.
2. Follow the instructions for Linux starting at item 3.

