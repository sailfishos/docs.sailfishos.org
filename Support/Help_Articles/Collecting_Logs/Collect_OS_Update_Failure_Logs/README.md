---
title: Collect OS Update Failure Logs
permalink: Support/Help_Articles/Collecting_Logs/Collect_OS_Update_Failure_Logs/
grand_parent: Help Articles
parent: Collecting Logs
layout: default
nav_order: 2800
---

# Collecting OS Update Failure logs

This help article is mainly intended for those opting-in early access releases of SailfishOS. 
If you are downloading a public release and it would fail, this article instructs how to collect logs, but if you do not wish to do so you can jump to [this article](/Support/Help_Articles/Managing_Sailfish_OS/Updating_Sailfish_OS/#what-if-installing-an-os-update-fails-but-download-worked) which gives instructions how to complete the failed OS update.


## Your device can still be booted up to the UI or at least beyond the Sailfish logo

Run the following commands in the Terminal app (if accessible) or else use an SSH connection (if it works) to collect some of the crucial information.
Now collect the logs from the device:
```
devel-su # (if not done already)
cp /var/log/systemboot.log $MYHOME
cp /var/log/systemupdate.log $MYHOME
cp /var/log/zypp/history $MYHOME/history.txt 
rpm -qa | sort > $MYHOME/rpm-qa.txt
export COLUMNS=400; journalctl -a --no-pager -n10000 > $MYHOME/journal.txt
ssu lr > $MYHOME/ssu-lr.txt
tar -cvf $MYHOME/Update-failure.tar systemboot.log systemupdate.log history.txt rpm-qa.txt journal.txt ssu-lr.txt
```


## Your device is failing to boot up

Note for Early access users: Prior to downloading and installing an OS update
Please read the [release notes](https://forum.sailfishos.org/tag/release-notes), before you start.
As an early access customer, you should enable the [Developer mode](/Support/Help_Articles/Enabling_Developer_Mode/) in your device before attempting an OS update. Do not forget to create and save the SSH password for you, either. All this is done in the menu page "Settings > System > Developer mode".
This precaution makes it easier to collect log files from the device, if the update fails. The device may end up in a state where it is no more possible to enable the Developer Mode.

Let's define a variable for your home area because $HOME points to /root after ```devel-su```:
```
cd $HOME
export MYHOME=$(pwd)
```
For the SSH connection to work over USB, add the usb_moded configuration allowing to connect by SSH even if the system is not started fully.
```
devel-su
mkdir -p /var/lib/environment/usb-moded/
echo "USB_MODED_ARGS=-r" > /var/lib/environment/usb-moded/usb-moded-args.conf
```


## Reporting the issue to Jolla Customer Support
Create a service request at Jolla Customer Support. Find file OS-update-failure.tar in "Mass storage" ( /$HOME ) and attach it to your service request.


