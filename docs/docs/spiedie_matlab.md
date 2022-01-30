---
title: How to setup MATLAB
layout: default
images: []
tags: [Login, Setup, Configuration, Remote Access, MATLAB, tutorials]
description: How to set up MATLAB remote desktop server on Spiedie
category: getting-started
---

***

***Note: The user must have access to the MATLAB Cluster Remote Server and by connected via ethernet on campus. 
The following steps will NOT work through a WiFi connected device.
***

### Table of Contents
1. [Log in to MATLAB cluster Remote Server](#remote_server_login)
2. [Map Spiedie Home Directory](#directory_map)
3. [MATLAB configuration](#matlab_configure)


## <a name="remote_server_login"></a> Log in to MATLAB cluster Remote Server

***Note: You must have access to the MATLAB Cluster Remote Desktop Server in order to do these steps***

1. Open "Remote Desktop Connection"
2. In the "Computer" field type: spiedie-access.pods.bu.int
3. Log in using your PODS ID

***Once Logged in, the subsequent directions are performed in the remote server***

## <a name="directory_map"></a> Map Spiedie Home Directory

We must map the Spiedie Home directory to the "Y" drive.

<a href="data_transfer.html#Home_dir">You can also map your Spiedie home directory on your personal machine.</a>

1. Open "Computer"
2. Click "Map network drive"
3. Select the drive letter you prefer (Y is recommended)
4. In the folder box type \\\\spiediefiles.binghamton.edu\username (replace username with your user name)
	- Select "Connect using different credentials"
	- To automatically connect every tiem you log on, check the box "Reconnect at log on"
5. Click "Finish"
6. When prompted, select "Use another account"
7. input ".\username" where "username" is your Spiedie username and your Spiedie password
	- The network drive should now be successfully mounted in your windows explorer window


## <a name="matlab_configure"></a> MATLAB configuration 

Once you have your home directory mapped, you can open up MATBAL to configure it 

1. Open MATLAB R2019b
2. In the top bar in "Environment" select "Set Path"
3. If you do not see \\\\lightning.binghamton.edu\matlab\remotesubmission\19b in your path follow the next few steps, if you do move on to step 7.
4. Click "Add Folder"
5. Next to "Folder:", in the text box type this: \\lightning.binghamton.edu\matlab\remotesubmission\19b
6. Click "Save", then click "Close"
	1. If prompted for admin credentials click on "No".
	2. You should then be prompted by MATLAB to save the pathdef.m file to another location. Click "Yes".
	3. Accept the default location.
7. In the MATLAB prompt type "configCluster". It'll prompt for your cluster username, type it in then hit "Enter".
8. Click the "Parallel" dropdown in the ribbon bar in the "Environment" section and then select "Manage Cluster Profiles"
9.  Go to the "Validation" tab. Where it says "Number of workers to use" set that to "4"
10. Click on "Validate"
	- When asked to use an identity file, select "No"
	- When prompted, enter your Binghamton University username and your cluster password
	- Everything should validate with a green check mark under "status"
12. Now you may run a MATLAB project as normal, and it will be completed on the HPC cluster. When submitting jobs be sure to specify the number of cores you wish to use.
	- The properties tab in the cluster profile manager near the bottom you can easily change the submission arguments including what partition to use as well as if you're requesting GPUs or not.
13. To view the progress of your jobs and to view your available directories, you may visit the Bright Computing Webpage and login with your PODS username and your cluster password.
14. This is a informative webinar provided by Mathworks on parallel computing
<a href="https://www.mathworks.com/videos/parallel-computing-with-matlab-81694.html?form_seq=conf1176&confirmation_page=&wfsid=5761638" target="_blank">Mathworks Parallel Computing Webinar</a>
