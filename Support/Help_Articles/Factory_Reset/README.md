---
title: Factory Reset
permalink: Support/Help_Articles/Factory_Reset/
parent: Help Articles
layout: default
nav_order: 440
---

# Device reset to factory settings means the following

* All user data, settings and accounts are deleted from the device and are **irretrievable** after this operation (however, data on the memory card remains intact) 
* All applications installed by the user are removed
* The operating system is reverted to the version the device had when leaving the factory or that was installed later by "flashing". You will need to update the phone to the latest OS version which implies installing a chain of Stop Releases. In the worst cases, this may take several hours.
* **In the case of Xperia devices, we recommend re-installing (by "flashing") Sailfish OS to the device, instead of resetting it**. This is easier and saves you from many extra steps. While the reset reverts your phone to one of the earlier OS versions, you will get the latest OS release directly by flashing it to the phone. **[See our comparison](/Support/Help_Articles/Tips_and_Tricks/#total-device-reset)** of device reset to re-installation. Our instructions for flashing are **[in this support article](/Support/Help_Articles/Reinstalling_Sailfish_OS/)**.

# Preparation
It is recommended to **[take a backup](/Support/Help_Articles/Backup/Backup_and_Restore/)** of the data in your device and copy it to an **SD card** before running the reset (if possible). Once done then proceed to the reset.

Whether unsure if the device reset will erase data you will need once it's gone, please make a list for yourself of all files or other information on your device that is important to you, and use our  **[backup](/Support/Help_Articles/Backup/Backup_and_Restore/)** article as a resource to learn what information can be saved and how.

# Resetting the device
1. Connect a battery charger to the device.
2. Go to menu Settings > System > 'Reset device'.
**NOTE: This feature is missing from Xperia 10 II and Xperia 10 III devices. Consider re-installing ("flashing") the latest Sailfish OS release to the device. [This article](/Support/Help_Articles/Reinstalling_Sailfish_OS/) explains how to do it.**
3. Tap 'Clear device'.
4. Read the disclaimer, and tap 'Accept' if you are ready to proceed.
5. If you have the device lock enabled, it will prompt for the security code.
6. The reset starts now.
The reset typically takes 1-2 minutes. It ends when the device is turned off, i.e. the display is and remains black. No LEDs are lit.

You can then restart the device by using the Power key on the side of your device.

# First actions after the reset
The main idea below is to update Sailfish OS to its latest version first, and only then install the apps and accounts.

These guidelines are to avoid the situation where you upgrade the OS while the device keeps installing a set of apps in the background. This has sometimes caused serious problems.

## Run the startup actions
* Select language
* Accept the SailfishOS terms of use
* Check date and time; set correct or else updates would fail
* Sign in to your Jolla account which requires selecting the Internet connection (WLAN or mobile data); instead of signing in you can also register a new Jolla account (this requires a different email address, though).  If signing in should keep failing then skip this step and sign in once you have completed the startup actions. You will need to sign in to get the SailfishOS update as described below.
* "Get your apps"
* Skip the Tutorial by tapping all four corners of the display in a clockwise direction - start from the top left.

Let your phone install the apps before you proceed from here.

## Get the SailfishOS update
The device has probably presented a notification about SailfishOS update by now. Please download and install it now:
* Visit menu page "Settings > System > Sailfish OS updates"
* Follow the on-screen instructions
* Detailed instructions on installing a Sailfish OS update are given on **[this page](/Support/Help_Articles/Updating_Sailfish_OS/)** - please read it!

Please note that it is not necessarily possible to update the OS to the latest version directly but in one or more steps. There are so-called **[Stop Releases](/Support/Help_Articles/Updating_Sailfish_OS/#the-update-path-and-stop-releases)** in the update path. All of them must be traversed. Sailfish OS should automatically suggest the next stop release for you in "Settings > System > Sailfish OS updates".  Download and install it.

Should you need help with the commands above, please file a request at **[Jolla Service & Support](https://jolla.zendesk.com/hc/en-us/requests/new)**.

## Install your primary applications
Install your most-used applications from Jolla Store (install more apps later)

## Restore your data from the SD card
Restore the backup from the SD card.  Follow the **[instructions here](/Support/Help_Articles/Backup/Backup_and_Restore/)**.

## Check your accounts
Check your accounts (e.g. Google, Exchange, Facebook) on the menu page Settings > Accounts. Backup should have restored the account settings; however, it is best to check all accounts and sign in again if necessary.

## Check your settings
All settings are in their default values after the factory reset. Some of them may not have your favourite values. Check at least the following:

* Settings > Look and feel > Gestures: "Quick app closing" and "Quick Events access"
* Settings > Look and feel > Events view: "Setting shortcuts" and "Select actions"
* Settings > Look and feel > Display: "Sleep after"
* Settings > Location: "Location"
* Settings > Apps > Phone: "Quick call" **[(read this)](/Support/Help_Articles/Tips_and_Tricks/#quick-calls-from-the-call-history)**
* Settings > Apps > People: Check "Show" and "Sort" options
* Settings > Apps > Camera: Select "Memory card" for "Storage" if card is available.


