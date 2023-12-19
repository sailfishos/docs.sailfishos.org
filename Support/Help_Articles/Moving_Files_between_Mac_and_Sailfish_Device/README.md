---
title: Moving files between a Mac and a Sailfish Device
permalink: Support/Help_Articles/Moving_Files_between_Mac_and_Sailfish_Device/
parent: Help Articles
layout: default
nav_order: 580
---

# Transferring data over a USB connection


The **OS X** operating system on Mac computers does not support the **MTP** (**[Media Transfer Protocol](http://en.wikipedia.org/wiki/Media_Transfer_Protocol)**) which makes easy access to Sailfish device contents over USB impossible, unfortunately.

There are some commercial solutions that may help, including [**SyncMate**](http://www.sync-mac.com/mtp-sync.html).

\- _We cannot guarantee that those solutions would make the connection between your Mac and Sailfish device work_.


# Transferring files over a WLAN connection

## Via a graphical app

If you prefer a solution with a graphical UI you could use **[Cyberduck for Mac](https://cyberduck.en.softonic.com/mac/download)**[^1]. Mac and your Sailfish device must be connected to the same WLAN network. Enable **[Developer Mode](/Support/Help_Articles/Enabling_Developer_Mode/)** and remote connections on the phone and set a password.

On Cyberduck, make a new connection using SFTP (SSH) to the WLAN IP address of the phone (see "Settings > System > Developer tools"), username 'defaultuser' or 'nemo'. Then you can easily browse the phone's file system.
\- _Jolla cannot however guarantee that this solution would make the connection between your Mac and Sailfish device work_.

<div class="flex-images" markdown="1">

* <a href="Settings_wlan_ip_address.png" class="narrow-image"><img src="Settings_wlan_ip_address.png" alt="WLAN IP"></a>
  <span class="md_figcaption">
    WLAN IP address of Sailfish phone
  </span>
</div>


## Via the command line

Another option is to rely on **[SCP](https://en.wikipedia.org/wiki/Secure_copy)**[^2] on Mac OS X (_we do not know whether it is installed by default_) with **[Developer Mode](/Support/Help_Articles/Enabling_Developer_Mode/)** enabled on the Sailfish phone. It is fast and works over WLAN. 

Please read our document about **[SSH and SCP](/Support/Help_Articles/SSH_and_SCP/SSH_and_SCP_Mac/)** on Mac computers.

Use the following command to download files from the phone to Mac's current directory - in this example we copy pictures. Do not forget to replace the fake address u.v.w.x with the actual WLAN IP address of your Sailfish phone (see the picture above).

```
scp -r defaultuser@u.v.w.x:$HOME/Pictures/Camera/*
```

## AirSail
OpenRepos store has a clever application named **[AirSail Transfer](https://openrepos.net/content/6uvnpr/airsail-transfer)**[^3] for transferring files to/from your Sailfish OS device using your computer's web browser. Install the latest rpm file - for this, you will need to allow untrusted software in "Settings > System > Untrusted software". _We cannot guarantee that this solution would make the connection between your Mac and Sailfish device work_.


# Transferring files via an SD card to/from Mac

Using a micro SD card inserted into your Sailfish device is an option for moving files from the phone memory to your Mac. In the first phase, transfer the files with the **[File Browser](/Support/Help_Articles/File_Browser/)** app from the phone memory to the SD card. Once done, take the SD card and connect it to your Mac computer and read the files on the SD card.

In the opposite direction, copy files from Mac to the SD card. Then insert the card into your Sailfish device.

**[This document](/Support/Help_Articles/SD_Card_Format_and_Encryption/)** describes what kind of SD cards and file formats Sailfish OS supports.

# Transferring files via a cloud-based service

Your Mac supports the integration of cloud-based services such as Dropbox into your _Finder_ application. This way you can easily sync media files (or any files) from your Mac into your cloud storage, and then download the media on your Sailfish device.

Dropbox will be the example service used here, but there are several other services available and we encourage you to try to use one that you are most familiar with.
  
**Prerequisite:**
An account in a cloud-based file-storing service (e.g. Dropbox, Nextcloud, etc.) and a possible client app downloaded and configured on your computer.
  
**On your computer:**

Upload the file(s) to your web-storage service. You can do it using the app on your computer or a web interface.

**On your Sailfish device:**
1) Open the Sailfish browser, and browse to **[www.dropbox.com](http://www.dropbox.com)** (_we use it as an example here_)

2) Sign in or sign up using the links at the top.

3) Find your media files inside your Dropbox and download them.

4) Check the status of the file transfer in "Settings > System > Transfers". Once ready, the files will reside in the Downloads folder of Sailfish.

5) Downloaded music files will automatically show up in the Media app, videos and photos in the Gallery app, and documents in the Documents app.
  

# Transferring files over Bluetooth

Bluetooth is a fairly hassle-free wireless way of transferring data, but it is quite slow. Therefore this method is recommended for cases where you are transferring only a moderate amount of files, or files that are quite small in size (for eg. single songs, single photos etc.).

1) Enable Bluetooth on your Mac. Set it ready for pairing new devices.

2) On your Sailfish device, enable Bluetooth and initiate the device search. We have a document about **[Bluetooth pairing](/Support/Help_Articles/Bluetooth_Pairing/)**. Connect your device to your Mac. Let the transfers take place automatically.

3) On your Mac to send files

* Click on the Bluetooth icon in the menu bar and click "Send File to device"
* Select the file(s) you wish to send to your Sailfish device and press "Send"
* Transfers will now begin. Every Bluetooth transfer will have to be accepted separately on your Sailfish device.
* Your music files will now show up in the Media app of your device, photos and videos in the Gallery app, and documents in the Documents app.

4) On your Mac to receive files

Enable the "Receive File" service on Mac to transport files from Sailfish to Mac. 

On Sailfish, use the File Manager (find it in the pulley menu of "Settings > System > Storage >  User data") or to locate a file to send. Long-tap the file and select "Share" in the popup menu.

<div class="flex-images" markdown="1">

* <a href="FileManager_share_a_file.png" class="narrow-image"><img src="FileManager_share_a_file.png" alt="Share a file"></a>
  <span class="md_figcaption">
    Sharing a file
  </span>
</div>


# Using Android's support software

Yet another option is to install support for over-the-USB file transfer for Android phones on your Mac. Please visit this site: **[https://www.android.com/filetransfer/](https://www.android.com/filetransfer/)**

_We haven't verified this method, so please use this method at your own risk._

- - - - -
[^1]: Thanks to user _femtopeta_ in together.jolla.com
[^2]: Thanks to user _wosrediinanatour_ in together.jolla.com
[^3]: Thanks to user _aga4io_ in together.jolla.com

