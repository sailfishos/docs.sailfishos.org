---
title: Removing Android AppSupport
permalink: Support/Help_Articles/Android_App_Support/Removing_Android_App_Support/
parent: Android AppSupport
grand_parent: Help Articles
layout: default
nav_order: 500
---

This document instructs how to revert a Sailfish device back to a state where there is no Android Support and no Android apps.


# Clean removal

Android App SUpport should be removed in this way. It is to remove everything necessary.

1) Uninstall all Android apps, one by one, using the app launcher grid. 
* Tap and hold the background until all icons get an X on them
* Uninstall Android apps by tapping each of them
  
2) Uninstall Android AppSupport:
* Open Jolla Store app on your phone
* Pull down My Apps
* Look for "Android AppSupport"
* Long-tap it and select "Uninstall"
  
<div class="flex-images" markdown="1">

* <a href="AAS_uninstall.png" class="narrow-image"><img src="AAS_uninstall.png" alt="Uninstalling Android AppSupport"></a>
  <span class="md_figcaption">
    Uninstalling Android AppSupport
  </span>
</div>


3) Restart the device.

_This is the recommended way. It is expected to work correctly on Sailfish 4 releases and thereafter._

# Brutal way

Consider using this method if the **[Clean removal](/Support/Help_Articles/Android_App_Support/Removing_Android_App_Support/#clean-removal)** fails to work, for some reason.
The commands below will definitely and quickly remove all Android stuff. Use it only if you are familiar with working on the command line. Be careful to run the commands correctly, or else you might cause damage to your device. You will need to enable the **[Developer mode](/Support/Help_Articles/Enabling_Developer_Mode/)** before proceeding.

1) Uninstall Android AppSupport
* Open Jolla Store app on your phone
* Pull down "My Apps"
* Look for "Android AppSupport"
* Long-tap it and select "Uninstall" (see the picture above)
  
2) Run the following commands in the Terminal:
```
devel-su
cd /home/defaultuser          ## On some phones:  cd /home/nemo
rm -rf /home/.android/*
rm -rf android_storage
reboot
```
3) Restart the device.

# Factory reset or reinstalling Sailfish OS

**[Factory reset](/Support/Help_Articles/Factory_Reset/)** will definitely wipe out all Android stuff and unfortunately much more. Hard work will be needed to set up the device for pure Sailfish OS use after the reset.

**[Reflashing (reinstalling) Sailfish](/Support/Help_Articles/Reinstalling_Sailfish_OS/)** cleans everything up on the device: all data, apps and accounts are lost. However, setting up the phone is easier than after the factory reset.
