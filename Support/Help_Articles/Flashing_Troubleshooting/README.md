---
title: Flashing Troubleshooting
permalink: Support/Help_Articles/Flashing_Troubleshooting/
parent: Help Articles
layout: default
nav_order: 470
---

# Flashing Sailfish to Xperia phone fails, troubleshooting.

The following issue has been observed to happen on Ubuntu computers (version 18.04 at least) sometimes when installing Sailfish X to an Xperia XA2 device via a USB3 port.  It is not clear where the culprit is.
Similar problems have been reported from different linux distributions, too, and while flashing Xperia X, Xperia XA2 and Xperia 10 devices.
In our experience, flashing with Ubuntu (we use it on Lenovo Thinkpad computers) works in a reliable way. 

## The problems 

The failures typically hit when using a USB3 port on Ubuntu 18.04 computer (we are not yet aware of this in other environments).

### Flashing starts but later fails

Soon after starting the script to flash Sailfish X to an Xperia XA2 the following can happen and appear at the computer terminal:
```
$ ./flash.sh
Detected Linux
Searching device to flash..
Found 1 devices: CQ3000XMTM
Fastboot command: fastboot -s CQ3000XMTM
Flashing boot\_a partition..
Sending 'boot\_a' (17772 KB) FAILED (remote: 'unknown command')
Finished. Total time: 0.001s
```

### Flashing fails to start
```
$ ./flash.sh
Detected Linux
Searching device to flash..
Found 0 devices: Incorrect number of devices connected. Make sure there is exactly one device connected in fastboot mode.
```

## How to avoid the problem

One of the following steps should help you out. 

1) Attach your Xperia to a USB port which is a **"USB root hub" (internal to your computer), to which no other device is attached (neither internally nor externally):
* Execute lsusb in a terminal window (this is for Linux computers), without having your Xperia connected.
* Look for a bus that solely has a Linux Foundation 2.0 root hub attached (i.e., nothing else).
* Connect your Xperia to the USB port which is attached to this bus.
* Execute lsusb again to make sure you selected the correct USB port; for example, an Xperia X on bus 003 then looks like this:
```
Bus 003 Device 015: ID 05c6:0afe Qualcomm, Inc. Xperia X Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
```

2) Check if there is a **USB2 port [^1] on your computer or on the USB hub you are using. Connect your phone to the USB2 port for flashing.

3) If your USB hub has only USB3 ports, then connect the hub to the PC with a **USB2 data cable, and XA2 to the hub with any USB data cable ("USB C-type" in the XA2 end) [^2].

4) If there are only USB3 ports available, then this problem can be worked around in the following way on the PC: 
* Force USB3 ports to USB2 mode temporarily (note that the 2nd command below is long - be sure to copy all of it)
```
sudo su
lspci -nn | grep USB | cut -d '\[' -f3 | cut -d '\]' -f1 | xargs -I@ sudo setpci -H1 -d @ d0.l=0
exit
```
* Install Sailfish X to your Xperia XA2 now.
```
./flash.sh
```
At the end of a successful flashing session, this script will write to the terminal:
```
Flashing completed. Remove the USB cable and bootup the device by pressing powerkey. 
```

## Cleaning up

Restart your computer now to bring the USB3 ports to their normal mode. Alternatively, give the following reverting command:
```
sudo su
lspci -nn | grep USB | cut -d '\[' -f3 | cut -d '\]' -f1 | xargs -I@ sudo setpci -H1 -d @ d0.l=1
exit 
```

## What if the problem persists

Use a different computer if possible. Try Ubuntu in place of other Linux variants, or use Windows 10 with the latest OS version. 
Contact Jolla customer support again (file a **[new ticket](https://jolla.zendesk.com/hc/en-us/requests/new)** if you do not have a ticket open yet). Force your Xperia phone to the fastboot mode (blue LED), give the command below, and attach the output to your ticket, please.
```
fastboot getvar all
```
Also, send the output from the terminal window showing how the execution of the flashing script went. 

## Can the Sailfish community help

Our community has many talented persons, even experts. One of them has composed extensive instructions for installing Sailfish&nbsp;X (**[link](https://gitlab.com/Olf0/sailfishX#guide-installing-sailfishx-on-xperias)**), which also cover troubleshooting. 
We/Jolla have not tested the tricks and methods of that article. They may or may not help. Some of these instructions require a fair amount of skills with Linux commands and computer systems, so we do not recommend them for beginners. Use them with care and at your own risk.

You can also search help or send questions to the **[Forum](https://forum.sailfishos.org/)**.

[^1]:  USB 3.0 Connectors are different from USB 2.0 connectors - they are usually (but not always) coloured blue on the inside in order to distinguish them from the 2.0 connectors. Check the specifications of your PC.

[^2]:  Make sure that your USB cable is a **data cable (all 4 lines connected) and not just a charging cable. You can test this by copying a file over the cable from the PC to the phone or vice versa.
