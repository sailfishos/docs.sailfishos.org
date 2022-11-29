---
title: SSH and SCP (Mac)
permalink: Support/Help_Articles/SSH_and_SCP/SSH_and_SCP_Mac/
parent: SSH and SCP
grand_parent: Help Articles
layout: default
nav_order: 200
---


  
Currently, it is not possible to browse the contents of your Sailfish phone over a USB connection. This is due to limitations in Mac OS X’s support for the **Media Transfer Protocol (MTP)**. It is possible to browse the contents of your phone by forming an **SSH connection over WLAN**, however. Here are the instructions for setting this up.
  

# Prerequisites

You must unlock the device lock and the encryption of your Sailfish phone before you can make an SSH connection to the phone. In other words, the phone must be on and unlocked. See these articles: **[device lock](/Support/Help_Articles/Device_Lock_and_Security_Code/)** and **[encryption](/Support/Help_Articles/Encryption_of_User_Data/)**.

Make sure you have the Developer mode enabled on your Sailfish device. If not, see **[this article](/Support/Help_Articles/Enabling_Developer_Mode/)**.
Check that you have the SSH password set in "Settings > Developer tools > Remote connection".

# SSH session

Open the Terminal on your Mac. Note that there are two different usernames depending on the Sailfish OS version on your phone:  'defaultuser' and 'nemo'. Only the correct one works. You can check it from the prompt of the Terminal app of the phone or with the command below (before getting root rights).
```
echo $USER
```
It replies either `nemo` or `defaultuser`. If you should get `root` then do `exit` first and try again.

Create the SSH connection with the correct command (matching your username).

# On your Mac OS X computer

1) Acquire the app called **[Cyberduck for Mac](https://cyberduck.en.softonic.com/mac/download)**.

2) Download the file and decompress it. Start “Cyberduck 2”.

3) Click on “Open connection” in the top left corner.

  
4) Click on the text “FTP (File Transfer Protocol)”, and change it to “SFTP (SSH File Transfer Protocol)”

5) Check the WLAN IP address of your Sailfish phone in "Settings > System > Developer tools". Both your computer and your Sailfish OS device must be connected to the same WLAN network (SSID).  Type the same WLAN IP address on your Mac into the “Server” field.

<div class="flex-images" markdown="1">

* <a href="Settings_wlan_ip_address.png" class="narrow-image"><img src="Settings_wlan_ip_address.png" alt="WLAN IP"></a>
  <span class="md_figcaption">
    WLAN IP address of Sailfish phone
  </span>
</div>


# SSH session

6) Type the correct username -- either _defaultuser_ or _nemo_

7) The password is the SSH password you defined on the phone at  "Settings > Developer tools > Remote connection".

8) Press “Connect” and wait a moment.

  
You should be able to see the contents of your Sailfish phone in Cyberduck now. Transferring files to and from your phone should now be possible in Cyberduck. 

## Further reading:

**[Moving files between Sailfish and Mac](/Support/Help_Articles/Moving_Files_between_Mac_and_Sailfish_Device/)**

