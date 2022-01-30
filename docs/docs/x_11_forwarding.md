--- 
title: X11 Forwarding 
layout: default 
images: [] 
tags: [X11, Forwarding, Interactive Sessions]
description: Enable X11 forwarding to forward X windows from Spiedie to your local machine.
category: getting-started
---


***

## X11 Client

In order to be able to forward X11 windows from Spiedie on your MacOS and Windows machines, you must have an X11 client such as [XQuartz (MacOS)](https://www.xquartz.org/) or [XMing (Windows)](https://sourceforge.net/projects/xming/) installed running. 


## MacOS and Linux

To enable X11 forwarding, just add the following flag when signing on to Spiede:

``` bash 

ssh -Y <username>@spiedie.binghamton.edu

```

You can verify that X11 forwarding is correctly working by simply running: 

``` bash 
xclock
```

This should forward a small system clock window. 

<!-- You should now be able to forward any apps that have X11 windows.  -->

## Windows 

1. Make sure XServer (such as XMing) is running 
2. Open PuTTY 
3. Click on Connection->SSH->X11 and check Enable X11 Forwarding
4. Log in to Spiedie as usual 

X11 forwarding should now be available. You can also verify as above by running 


``` bash 
xclock
```

