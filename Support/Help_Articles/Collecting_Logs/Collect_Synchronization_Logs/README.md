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

## Get sync logs
Preparations: do as instructed in the [Prepare for collecting journal chapter](#prepare-for-collecting-journal) above.
Here we prepare your device for collecting the actual sync logs. Note that rebooting the device will bring it back to its normal state. Hence the settings below are in effect until the next reboot only.

1. Stop the sync daemon so that it can later be restarted with extra logging enabled, via (as a normal user, 'defaultuser' or 'nemo')
```
systemctl --user stop msyncd
killall msyncd    # this may print "no process killed" - just ignore it.
```
2. Start the sync daemon with extra debug logging enabled, via 
```
devel-su -p
MSYNCD_LOGGING_LEVEL=8 msyncd 2>&1 | tee msyncd.log
```
or to get more verbose logs for contacts syncs, use
```
devel-su -p
QTCONTACTS_SQLITE_TRACE=1 MSYNCD_LOGGING_LEVEL=8 msyncd 2>&1 | tee msyncd.log
```
or to get even more verbose output, use this:
```
devel-su -p
QTCONTACTS_SQLITE_TWCSA_TRACE=1 QTCONTACTS_SQLITE_TRACE=1 MSYNCD_LOGGING_LEVEL=8 msyncd 2>&1 | tee msyncd.log
```
3. Trigger a sync cycle by opening up "Settings > Accounts". Then long-press the account you want to debug. Tap Sync in the pop-up menu.
4. Wait for 30 seconds or until the sync cycle has completed. (You should see something like this: `"void Buteo::Synchronizer::slotSyncStatus(QString, int, QString, int)" :Exit, execution time: 194 ms`) The logs collected from the msyncd terminal were saved to file msyncd.log.
5. Use \<ctrl\>C to stop the previous command.
6. Collect the journal log:
```
journalctl -a -b > journal-sync.txt  
```
7. Then continue from the [Sending logs chapter](#sending-logs).
8. Don't forget to [revert the changes back to the original configuration](#reverting-the-device-to-original-configurations).

## Detailed EAS logs
1. Preparations: do as instructed in the [Prepare for collecting journal chapter](#prepare-for-collecting-journal) above. 
2. More information and steps can be found from [this document](/Reference/Sailfish_OS_Cheat_Sheet/#email--active-sync-e-mail-debugging).
3. Don't forget to [revert the changes back to the original configuration](#reverting-the-device-to-original-configurations).

## Sending logs
Depending what logs you have taken you now have some of the following log files:
* journal-sync.txt
* msyncd.log
* eas.log

These files can be sent to Jolla customer service. 
 
**Please note**
 
The log files probably contain personal information from you. We will not share them in public but simply look for technical issues in them by a chief engineer in Jolla R&D.  If you are in doubt, glance through the files or do not send them at all.

## Reverting the device to original configurations
To restore the original configuration for journald:
```
devel-su 
cd /etc/systemd 
cp journald.conf.original journald.conf
## let it overwrite
reboot
```

