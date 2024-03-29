---
title: Collect Synchronization Logs
permalink: Support/Help_Articles/Collecting_Logs/Collect_Synchronization_Logs/
grand_parent: Help Articles
parent: Collecting Logs
layout: default
nav_order: 3500
---

Collecting synchronization logs (EAS, CardDAV, CalDAV)

Related articles:
* [CalDAV and CardDAV Community Contributions Sync Logs chapter](/Develop/Collaborate/CalDAV_and_CardDAV_Community_Contributions/#sync-logs)
* [Sailfish OS Cheat Sheet's Diagnostics chapter](/Reference/Sailfish_OS_Cheat_Sheet/#diagnostics)
* [Collecting Email logs](/Support/Help_Articles/Collecting_Logs/Collect_Email_Logs/)

This article contains instructions for collecting logs from various sync processes, for example Google, EAS and Dropbox.
Using the tools below requires that Linux is familiar to you and that you are confident in working with the command line. Do not continue if you feel unsure!

## Prepare for collecting journal
The journal collects a lot of events when synchronization is set to a debugging mode. We need to prepare to be able to catch all of the events.

1. Enable the [Developer mode](/Support/Help_Articles/Enabling_Developer_Mode/) on your device.

2. Open an SSH terminal to your device [SSH usage instructions](/Support/Help_Articles/SSH_and_SCP/), and make a copy of the journal configuration file with these commands:
```
devel-su
cd /etc/systemd
cp journald.conf journald.conf.original
```
3. Edit the file  journald.conf and make the following changes (see below) to it. These changes are to ensure that the journal is persistent over device reboots and that logs don't get truncated. If those values are different, or if those keys are commented out (prefixed by hash or semi-colon), edit the file "as root" (with super-user rights). 
If needed, read more about the available [text editors](/Support/Help_Articles/Enabling_Developer_Mode/#how-to-use-the-vi-or-nano-text-editors-at-sailfish-terminal).
```
Storage=persistent
RateLimitBurst=9999
RateLimitInterval=5s
```
4. Save the file, and then reboot your device and open an SSH terminal to it again once it has booted.
NOTE: We will revert this configuration to its original status in [this chapter](#reverting-the-device-to-original-configurations) below.

## Basic sync logs
Preparations: do as instructed in the [Prepare for collecting journal chapter](#prepare-for-collecting-journal) above.
Here we prepare your device for collecting the actual sync logs. Note that rebooting the device will bring it back to its normal state. Hence the settings below are in effect till the next reboot only.

1. Stop the sync daemon so that it can later be restarted with extra logging enabled, via (as a normal user, 'defaultuser')
```
systemctl --user stop msyncd
killall msyncd    # this may print "no process killed" - just ignore it.
```
2. Start the sync daemon with extra debug logging enabled, via 
```
devel-su
MSYNCD_LOGGING_LEVEL=8 msyncd 2>&1 | cat > msyncd.log
```
3. Trigger a sync cycle by opening up "Settings > Accounts". Then long-press the account you want to debug. Tap Sync in the pop-up menu.
4. Wait for 30 seconds or until the sync cycle has completed. The logs collected from the msyncd terminal were saved to file msyncd.log.
5. Use \<ctrl\>C to stop the previous command.
6. Collect the journal log:
```
journalctl -a -b > journal-sync.txt  
```
7. Then continue from the [Sending logs chapter](#sending-logs).

## More detailed logs on contact sync
1. Preparations: do as instructed in the [Prepare for collecting journal chapter](#prepare-for-collecting-journal) above. 
2. The level of debugging enabled in step 2 of the Basic sync logs chapter does not make the system print out too much data on contact sync. If there is a need to get deeper insight to the issues in contact sync then consider using the following setup
(make sure that you copy the whole long command):
```
sudo -E -g privileged QTCONTACTS_SQLITE_TRACE=1 MSYNCD_LOGGING_LEVEL=8 msyncd 2>&1 | cat > msyncd.log
```
3. Trigger a sync cycle by opening up "Settings > Accounts". Then long-press the account you want to debug and tap Sync in the pop-up menu.
4. Wait for 30 seconds or until the sync cycle has completed. The logs collected from the msyncd terminal were saved to file msyncd.log.
5. Use \<ctrl\>C to stop the previous command.
6. Collect the journal log:
```
journalctl -a -b > journal-sync.txt  
```
7. Then continue from the [Sending logs chapter](#sending-logs).

## Detailed EAS logs
1. Preparations: do as instructed in the [Prepare for collecting journal chapter](#prepare-for-collecting-journal) above. 
2. More information and steps can be found from [this document](/Reference/Sailfish_OS_Cheat_Sheet/#email--active-sync-e-mail-debugging).

## Sending logs
Depending what logs you have taken you now have some of the following log files:
* journal-sync.txt
* msyncd.log
* eas.log

These files can be sent to Jolla customer service. 
 
**Please note**
 
The log files probably contain personal information from you. We will not share them in public but simply look for technical issues in them by a chief engineer in Jolla R&D.  If you are in doubt, glance through the files or do not send them at all.

## Reverting the device to original configurations
```
devel-su 
cd /etc/systemd 
cp journald.conf.original journald.conf
## let it overwrite
reboot
```

