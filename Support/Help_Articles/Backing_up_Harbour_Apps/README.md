---
title: Backing up Harbour Apps 
permalink: Support/Help_Articles/Backing_up_Harbour_Apps/
parent: Help Articles
layout: default
nav_order: 160
---

This special procedure is needed and can be used because the current backup utility of Sailfish OS does not save the data of miscellaneous 3rd party apps.
This article contains an example covering one application only.

There is no guarantee that the following instructions would always work or be able to backup all kinds of Harbour apps!

# Disclaimers
1. These instructions are applicable for the so-called Harbour apps which are SailfishOS apps from 3rd party developers. They can be installed from the Jolla Store.
2. These instructions do not cover the native SailfishOS apps (e.g. browser, email, calculator, maps).
3. These instructions do not cover any Android apps.
4. Anyone using the instructions below does it on his/her own risk. The procedure has been tested briefly but there is no guarantee that it works in all cases.
5. A good amount of Linux knowledge and technical skills is expected from you to succeed.

# General
This article has two main parts, depending on the condition of your Sailfish device:
1. [Recovery Mode](#recovery-mode)
2. [Normal Mode](#normal-mode)

This article presents an **example** of how to handle the data of the game of Snake. Other SailfishOS apps in the Jolla Store are expected to keep their data in the same folder: ```$HOME/.local/share```. If this is correct for other apps then the instructions below can be modified and used for those other apps, too.

Installed Harbour apps can be checked in the device with the command (if the app has some data to collect here).
```
ls -al $HOME/.local/share/
```
Also, check if your app(s) have something under the configurations folder:
```
ls -al $HOME/.config/
```

# Required
There must be a [micro-SD card](/Support/Help_Articles/SD_Card_Format_and_Encryption/) in your Sailfish device.

If your Sailfish device is up and running normally, consider accessing the memory card like in [Normal Mode](#normal-mode).

If your Sailfish device cannot be booted up but needs to be forced to recovery mode, then we need to mount the card to access it. Proceed to chapter [Recovery Mode](#recovery-mode) below.

 
# Recovery Mode

Our official help articles on recovery mode for various devices are here can be found from [here](/Support/Help_Articles/Recovery_Mode/). 
 
## Saving app data to SD card

User has been playing Snake. The game data wants to be saved, to make it persist over a phone reset or the re-flashing of the phone.

1. Make a Telnet connection to the device as instructed in the help articles above.
2. Using the Shell utility, give the following commands exactly as they are below:
```
mkdir -p /mnt/sd
mount /dev/mmcblk1p1 /mnt/sd/
cryptsetup luksOpen /dev/sailfish/home recover
```
Enter passphrase for /dev/sailfish/home:
```
chroot /rootfs
mount /dev/mapper/recover /home
cd /home/defaultuser/.local/share
tar -cvf /mnt/sd/MySnakeData.tar harbour-snake/
sync
```
3. If your app has some configurations, then let's save them, too:
```
cd /home/defaultuser/.config
tar -cvf /mnt/sd/MySnakeConfig.tar harbour-snake/
sync
```
4. Unmount the SD card
```
umount /mnt/sd
```
5. Exit recovery mode, instructions for that for Xperia devices can be found from [here](/Support/Help_Articles/Recovery_Mode/#reverting-the-phone-back-to-the-normal-state) or by detaching the USB cable and the battery from the device.

## Restoring data from SD card to device

1. Install Snake again
2. Launch Snake. This creates the application setup (folder for the app database) to the phone, again.
3. Close Snake app.

Now that your device is running in the normal mode again, consider restoring the data as in chapter [Normal Mode](#restoring-data-from-sd-card-to-device-1).
 
## Cleaning up

```
umount /mnt/sd
exit
```

1. Close Terminal (or SSH)
2. Disable Developer Mode (if not needed)
3. Launch Snake. You should see your previous app data now.

 
# Normal Mode

Your Sailfish device is in its normal mode. It is possible to access the memory card at ```/run/media/defaultuser/<uuid>```. Use the following command to check and copy the unique identifier <uuid> of your card:
```
ls /run/media/defaultuser
```
Our SSH instructions are here:
[SSH-connection-over-USB-from-Windows](/Support/Help_Articles/SSH_and_SCP/SSH_and_SCP_Windows/).
[SSH-connection-over-USB-from-Ubuntu](/Support/Help_Articles/SSH_and_SCP/SSH_and_SCP_Linux/).

## Saving app data to SD card

User has been playing Snake. The game data wants to be saved, to make it persist over a phone reset or the re-flashing of the phone.

1. Enable Developer Mode and launch Terminal app (or use SSH).

Let's name your home area first for the commands below:
```
cd $HOME
export MYHOME=$(pwd)
```

2. Give the commands exactly as they are below (but replace <uuid> with the real code):
```
devel-su
cd $MYHOME/.local/share
tar -cvf /run/media/defaultuser/<uuid>/MySnakeData.tar harbour-snake/
sync
```
3. If your app has some configurations, then let's save them, too:
```
cd $MYHOME/.config
tar -cvf /run/media/defaultuser/<uuid>/MySnakeConfig.tar harbour-snake/
sync
```
4. Close Terminal (or SSH).
 
## Restoring data from SD card to device

1. Install Snake again
2. Launch Snake. This creates the application setup (folder for the app database) to the phone, again.
3. Close Snake app.
4. Enable Developer Mode and launch Terminal app (or use SSH).
```
cd $HOME
export MYHOME=$(pwd)
devel-su
```
5. First we restore the app data from SD card to device memory

The tar command copies your data to the actual app folder (here: harbour-snake) and overwrites all files in there. Remember to replace <uuid> with the real card identifier.
```
tar -xvf /run/media/defaultuser/<uuid>/MySnakeData.tar -C $MYHOME/.local/share/
sync
```
6. Next, we restore the app configurations from the SD card to the device memory

The tar command copies your app configuration to the actual folder (here: harbour-snake) and overwrites all files in there. Remember to replace <uuid> with the real card identifier.
```
tar -xvf /run/media/defaultuser/<uuid>/MySnakeConfig.tar -C $MYHOME/.config/
sync
```
7. Close Terminal (or SSH)
8. Disable Developer Mode (if not needed)
9. Launch Snake. You should see your previous app data now.
