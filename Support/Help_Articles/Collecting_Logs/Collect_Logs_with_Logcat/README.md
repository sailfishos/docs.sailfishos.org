---
title: Collect Logs with Logcat
permalink: Support/Help_Articles/Collecting_Logs/Collect_Logs_with_Logcat/
grand_parent: Help Articles
parent: Collecting Logs
layout: default
nav_order: 1000
---

When experiencing issues related to Android applications, collecting logs might provide additional information as to what is causing the issue. 
You will need to enable the **[Developer mode](https://docs.sailfishos.org/Support/Help_Articles/Enabling_Developer_Mode/)** for this. 

# Logcat tool 
Logcat is a command-line tool that dumps a log of system messages from the Android driver subsystem. 
With the Logcat tool, it goes easily to collect Android logs from the system. There are two ways to use logcat: a) from Sailfish OS b) from Android AppSupport (see the next chapters). The resulting logs differ. Choose a) or b) depending on the problem you want to look at.

# Using Logcat

## Open Terminal

Open the Terminal app.

## Get super-user rights
See the document **[Developer mode](/Support/Help_Articles/Enabling_Developer_Mode/)**.
```
cd $HOME
export MYHOME=$(pwd)
devel-su 
```

## Collect the logs from your device

The next commands print the logs into files. Note that the commands vary by product.

### Jolla 1 and Jolla Tablet
```
/opt/alien/system/bin/logcat -v time > $MYHOME/android-logs.txt
exit
```
### Xperia X and Jolla C

a) Viewed from Sailfish OS

```
/usr/libexec/droid-hybris/system/bin/logcat > $MYHOME/android-logs.txt
```

b) Viewed from Android Support

```
chroot /opt/alien /system/bin/logcat -v time > $MYHOME/android-logs.txt
```

### Xperia XA2, Xperia 10, Xperia 10 II, Xperia 10 III, Xperia 10 IV, Xperia 10 V and Jolla C2

a) Viewed from Sailfish OS

```
/usr/libexec/droid-hybris/system/bin/logcat > $MYHOME/sailfish-logs.txt
```

b) Viewed from Android Support

The same about Android apps. Note that the command is different for different OS releases:
* the 1st variant works up to OS release 4.4.0
* the 2nd variant works from OS release 4.5.0 onwards

```
lxc-attach -n aliendalvik -- /system/bin/logcat > $MYHOME/android-logs.txt
appsupport-attach /system/bin/logcat > $MYHOME/android-logs.txt
```
The events in the Android system will now be printed to file ```android-logs.txt```. The command runs until you stop it with \<ctrl\>C. 



# Journal and other information
It is always good to collect the journal log, too, as it shows all events in the Sailfish system. 
Note that you must have super-user ("root") rights to do this successfully. We assume below in the next commands that you have the setup from **[chapter 2.2](#get-super-user-rights)** still in effect - if not, redo the devel-su command first.

```
devel-su        ## not needed if still in effect from chapter 2.2
journalctl -ab --no-pager > $MYHOME/journal.txt
```

The following commands give information on what has been installed to Sailfish: 
```
rpm -qa | egrep 'alien|apkd' | sort > $MYHOME/rpm-alien.txt
ssu lr > $MYHOME/ssu-lr.txt
ssu s > $MYHOME/ssu-s.txt
```

The same about Android apps. Note that the command is different for different OS releases:
* the 1st variant works up to OS release 4.4.0
* the 2nd variant works from OS release 4.5.0 onwards

```
lxc-attach -n aliendalvik -- /system/bin/pm list packages | sort > $MYHOME/android-packages.txt
appsupport-attach /system/bin/pm list packages | sort > $MYHOME/android-packages.txt
## Ignore the warnings...

```


