---
title: SD Card in Recovery Mode
permalink: Support/Help_Articles/SD_Card_in_Recovery_Mode/
parent: Help Articles
layout: default
nav_order: 795
---

The instructions in this article are meant for situations, where your **Xperia** device no longer functions normally, and the command line is used to attempt to salvage data from the device. *There is no guarantee* that saving data with these instructions will succeed.

NOTE: You will need to type in **the correct security code of your phone** to get access to the data on the phone.

If you are unsure about following these instructions, please [**contact us**](https://jolla.zendesk.com/hc/en-us/requests/new) and explain to us your situation. 

# Prerequisites
* We assume that you have the default memory arrangement of Sailfish OS on your Xperia device, i.e., you have not created any partitions yourself etc. (if you have you would probably know how to handle them here)
* You will need the correct **security code** of your Xperia phone.
* Make sure that you have a formatted **memory card** (SD card) inserted in your phone, having enough free storage space for your data that you intend to copy and save to the card. The instructions for SD cards used with Sailfish OS are in [**this article**](/Support/Help_Articles/SD_Card_Format_and_Encryption/). Do not use an encrypted card here.
* Force your Xperia to the **Recovery Mode** first, explained in this [**Recovery Mode**](/Support/Help_Articles/Recovery_Mode/) document.

Select option #3 "Shell" in the main menu of the Recovery Mode, shown on the terminal window of your computer. You will be requested to *"Type your device lock code"* which means your Sailfish security code (the code that you type in when restarting the phone).

If your code was accepted you can proceed.

# The source of data, the mass storage on the Xperia phone
At the shell, give the commands below to unlock the encryption and to make copying the data from your Sailfish device to the SD card possible:

```
  / # cryptsetup luksOpen /dev/sailfish/home recover
  Enter passphrase for /dev/sailfish/home:
  / # chroot /rootfs
  / # mount /dev/mapper/recover /home
```

The passphrase above is the Sailfish security code, again. You need to type it correctly the 2nd time here.

Once done, you are able to see the contents of the Home area. Note that on some phones, the username may still be "nemo" instead of "defaultuser".

You are able to check the contents of your phone now:

```
/ # ls -al /home/defaultuser/
total 80
drwxr-x--- 20 defaultu defaultu 4096 May 17 12:12 .
drwxr-xr-x 7 root root 4096 May 18 10:09 ..
drwxrwx--- 14 defaultu defaultu 4096 May 17 12:12 .cache
drwx------ 12 defaultu defaultu 4096 May 18 10:06 .config
drwx------ 2 defaultu privileg 4096 May 3 09:41 .gnupg
-rw-r--r-- 1 defaultu privileg 0 May 3 09:40 .jolla-startupwizard-done
-rw-rw-rw- 1 defaultu privileg 0 May 17 11:59 .jolla-startupwizard-usersession-done
drwxr-xr-x 4 defaultu defaultu 4096 May 3 09:41 .local
drwx------ 5 defaultu privileg 4096 May 17 12:12 .mozilla
drwxr-xr-x 2 defaultu defaultu 4096 May 3 09:40 .profiled
drwx------ 2 defaultu privileg 4096 May 3 09:41 .qmf
drwxr-xr-x 2 defaultu defaultu 4096 May 3 09:40 .timed
drwxrwxr-x 2 defaultu defaultu 4096 May 3 09:40 Desktop
drwxrwxr-x 2 defaultu defaultu 4096 May 3 09:40 Documents
drwxrwxr-x 3 defaultu defaultu 4096 May 17 12:15 Downloads
drwxrwxr-x 2 defaultu defaultu 4096 May 3 09:40 Music
drwxrwxr-x 4 defaultu defaultu 4096 May 17 11:59 Pictures
drwx------ 2 defaultu privileg 4096 May 3 09:41 Playlists
drwxr-xr-x 2 defaultu defaultu 4096 May 3 09:40 Public
drwxr-xr-x 2 defaultu defaultu 4096 May 3 09:40 Templates
drwxrwxr-x 4 defaultu defaultu 4096 May 17 11:59 Videos
drwxrwx--- 13 media_rw media_rw 4096 May 17 12:10 android_storage
/ #
```

# The target of data: the memory card
At this phase, there must a formatted SD card (memory card) inserted in your Xperia phone.
The instructions of SD cards for Sailfish OS are in [**this article**](/Support/Help_Articles/SD_Card_Format_and_Encryption/).

With the commands below we create a mount point for the card to make accessing it easy:

```
mkdir -p /mysdcard
mount /dev/mmcblk1p1 /mysdcard
```

You can see the contents on the card now:

```
/ # ls -al /mysdcard
drwxrwx--- 15 nemo nemo 4096 May 20 08:22 .
drwxr-xr-x 19 root root 0 May 20 13:04 ..
drwxrwxr-x 2 nemo media_rw 4096 May 20 08:17 Alarms
drwxrwxr-x 2 nemo media_rw 4096 May 20 08:17 DCIM
drwxr-xr-x 6 nemo nemo 4096 May 20 08:18 DEMO
drwxr-xr-x 2 nemo nemo 4096 May 20 08:22 Documents
drwxrwxr-x 2 nemo media_rw 4096 May 20 08:34 Download
drwxrwxr-x 2 nemo media_rw 4096 May 20 08:17 Movies
drwxrwxr-x 2 nemo media_rw 4096 May 20 08:19 Music
drwxrwxr-x 2 nemo media_rw 4096 May 20 08:17 Notifications
drwxrwxr-x 2 nemo media_rw 4096 May 20 09:18 Pictures
drwxr-xr-x 2 nemo nemo 4096 May 20 08:17 Playlists
drwxrwxr-x 2 nemo media_rw 4096 May 20 08:17 Podcasts
drwxrwxr-x 2 nemo media_rw 4096 May 20 08:17 Ringtones
drwx------ 2 root root 16384 May 20 08:17 lost+found
/ #
```

If there is the need to make new folders to the SD card it goes as follows:

```
mkdir /mysdcard/MyNewFolder
```

# Copying data from the phone to the SD card
You can now try to copy data from your phone to the SD card.

For instance, to copy all pictures (also those contained in potential subfolders), use the command

```
cp -r /home/defaultuser/Pictures/*  /mysdcard/Pictures
```

If you would like to save everything from the user area of the phone to the SD card then the following command set should do it. Note that a lot of free space on the card is needed and that the copy operation may take several minutes. The first command calculates how much data there is on your phone in the /home area

```
du -hsc ./home     ## total size of /home  => free space needed on the SD card

mkdir /mysdcard/Phone
cp -apr ./home /mysdcard/Phone/
ls -al /mysdcard/Phone
```

# Exit
Unmount the SD card safely with the commands below, followed by two exits to get back to the main menu of the Recovery Menu.

```
sync
umount /mysdcard

exit
exit
```
 
If you have collected all the data from the phone, do:

1. Select option 6 'Exit' in the Recovery Mode menu.

2. Disconnect the USB cable from the phone.

3. Press Vol Up key down, keep it pressed and then also press the Power key. Release both keys when you feel the vibrator play three times - this will happen in about 30 seconds. The phone is now off.
	* all this may not work if your phone is badly corrupted.

4. In the case of Xperia 10 II and Xperia 10 III (if the phone is in usable condition), you will need to run the final actions to force the phone to its normal state. Follow [**these instructions**](/Support/Help_Articles/Recovery_Mode/), please.
