---
title: Collecting logs with Logcat
permalink: Support/Help_Articles/Collecting_logs_with_Logcat/
parent: Help Articles
layout: default
nav_order: 300
---

When experiencing issues related to Android applications, collecting logs might provide additional information as to what is causing the issue. 
You will need to enable the **[Developer mode](https://docs.sailfishos.org/Support/Help_Articles/Enabling_Developer_Mode/)** for this. 

# Logcat tool 
Logcat is a command-line tool that dumps a log of system messages from the Android driver subsystem. 
With the Logcat tool, it goes easily collect Android logs from the system. There are two ways to use logcat: a) from Sailfish OS b) from Android App Support. The resulting logs differ. Choose a) or b) depending on the problem you want to look at.

## Open Terminal

## Get super-user rights
See the help article of the **[Developer mode](https://docs.sailfishos.org/Support/Help_Articles/Enabling_Developer_Mode/)**.
```
cd $HOME
export MYHOME=$(pwd)
devel-su 
```

## Logcat printout to a file
### Jolla 1 and Jolla Tablet
```
/opt/alien/system/bin/logcat -v time > $MYHOME/android-logs.txt
exit
```
### Xperia X and Jolla C
From Sailfish OS
```
/usr/libexec/droid-hybris/system/bin/logcat > $MYHOME/android-logs.txt
```

From Android Support
```
chroot /opt/alien /system/bin/logcat -v time > $MYHOME/android-logs.txt
```

### Xperia XA2 and Xperia 10, Xperia 10 II and Xperia 10 III
Viewed from Android Support
```
lxc-attach -n aliendalvik -- /system/bin/logcat
```

The events in the Android system will now be printed to the screen. The command runs until you stop it with <ctrl>C.

```
lxc-attach -n aliendalvik -- /system/bin/logcat > $MYHOME/android-logs.txt
```
The events in the Android system will now be printed to file logcat.log The command runs until you stop it with <ctrl>C. 

Viewed from Sailfish OS
```
/usr/libexec/droid-hybris/system/bin/logcat > $MYHOME/sailfish-logs.txt
```

## Journal and other information
It is always good to collect the journal log, too, as it shows all events in the Sailfish system. 
Note that you must have super-user ("root") rights to do this successfully. We assume below in the next commands that you have the setup  from chapter 2 still in effect - if not, redo the commands of chapter 2 first.

```
journalctl -ab --no-pager > $MYHOME/journal.txt
```

The following commands give information on what has been installed to Sailfish: 
```
rpm -qa | egrep 'alien|apkd' | sort > $MYHOME/rpm-alien.txt
ssu lr > $MYHOME/ssu-lr.txt
ssu s > $MYHOME/ssu-s.txt
```

Here we print a list of Android apps installed, seen from Sailfish (super-user rights needed): 
```
lxc-attach -n aliendalvik -- /system/bin/sh ## ignore the warning 
:/ # pm list packages | sort
```


