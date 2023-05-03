---
title: Collect Kernel Logs
permalink: Support/Help_Articles/Collecting_Logs/Collect_Kernel_Logs/
grand_parent: Help Articles
parent: Collecting Logs
layout: default
nav_order: 900
---

# Collecting and monitoring kernel logs
With journalctl command it is possible to print out the message buffer of the [kernel](https://en.wikipedia.org/wiki/Kernel_(computer_science)). The output of this command typically contains the messages produced by the [device drivers](https://en.wikipedia.org/wiki/Device_drivers).

First you need to enable the developer mode, instructions for that can be found from this [article](/Support/Help_Articles/Enabling_Developer_Mode/).
Once that is done, then open the Terminal app of a Sailfish device or make an SSH connection to the device. Instructions about SSH can be found from this [article](/Support/Help_Articles/SSH_and_SCP/). Get the super-user rights (root) with this command:
```
devel-su
```
Start monitoring the logs with this command:
```
journalctl -k -f
```

The following command picks up fatal messages only:
```
journalctl -k -f | grep Fatal
```

It may be good to direct the flow to a file for later investigation, that can be done with this command:
```
journalctl -k -f > kernel.log
```
or with this:
```
journalctl -k -f | grep Fatal > kernel.log
```

Messages keep flowing to the screen or to the file until ```<ctrl>C``` is used to stop it.
After you have stopped the message flow and if you have been directing the messages to log file, then you can check the content for example with this command:
```
cat kernel.log
```
