---
title: Sailfish OS 4.0.1.48 Known Issues
permalink: Releases/Known_Issues/Koli/
parent: Known Issues
grand_parent: Releases
layout: default
nav_order: 500
---

This content can also be found in the [forum Release Notes](https://forum.sailfishos.org/t/release-notes-koli-4-0-1/4542#known-issues-generic-42).

## Generic

- *Assisted location service of Mozilla* has stopped working from 2020-03-01. This tends to slow down finding the position of the phone. We are looking for alternative ways to make it work faster. Unfortunately, this problem persists. It seems to affect Xperia XA2 worst.
- Sailfish can connect *Bluetooth Low Energy devices*. However, Android apps cannot use peripheral devices via Bluetooth - other than for playback of the sound. Therefore smartwatches, for instance, cannot be controlled from Android apps, unfortunately.
- *Signing in to Dropbox* works via Google only. So, after triggering the sign-in at "Settings > Accounts > Dropbox" and the browser page dropbox.com appears, tap "Sign in with Google" (if you have a Google account).
- *Importing contacts wizard* fails to create a Google account in "Settings > Apps > People". The same happens if one tries to sign in to a Google account from Email. However, signing in to Google from "Settings > Accounts" does work correctly, after which the contacts will be downloaded to the device (if you allowed this in the account settings) 
- An invalid warning and request to *uninstall all system packages* will appear if the previous OS version 3.4.0 is flashed to a device without installing the default Sailfish apps, followed by the download of the current OS version 4.0.1. This warning looks scary but it is just a warning. It should be okay to continue downloading and installing the OS update in the normal manner, i.e., you can ignore the warning. To avoid the warning, enabling the developer mode and running <code> devel-su; pkcon refresh</code> before downloading 4.0.1 may prevent the warning from appearing.
- [ *developers only* ] connman-test package is broken (does not install) for devices freshly flashed with 4.0.1, because dbus-python is no longer available (requires python2). All still works if updating from 3.4.0 as in this case the old dbus-python (if it exists in rootfs) will be used.
- *QR code reader* can recognise only the 2-dimensional code that has squares in 3 corners (for positioning).
- 4.0.1 update will remove your *synced contacts* - please re-sync your accounts to get them back! So, go to Settings > Accounts, long-tap an account and take 'Sync'. Repeat to all of applicable accounts. Check People app, then. Also, restart your phone to see the contacts in Phone > People.*
- *Calendar app* does not open anymore if user cancels first permission query and tries to reopen the app. Remedy: Restart phone, open Calendar, accept permissions. Fixed to the next OS release.
- *Call recorder* does not save the conversation to the phone storage. This can be fixed with the following commands (and in the next OS release) - make sure you type the whole long command on the 2nd row:
```
        devel-su
        echo -e '\nmkdir     ${PRIVILEGED}/Phone\nprivileged-data Phone' >> /etc/sailjail/permissions/Phone.permission 
        systemctl-user restart voicecall-ui-prestart
```

## Known issues to Android App Support 9 - Xperia 10 & Xperia XA2

- Aptoide Store (the default Android Store on Sailfish) may not become visible in the app grid if installed during startup wizard (SUW) or later in first boot. Remedy: reboot, uninstall it, install it again.
- Aptoide Store app (of Jolla Store) is failing to install apps. In the end of the download an ERROR is shown and the installation attempt stops here. Please, download the latest Aptoide app ( `aptoide-latest.apk` ) from **[here](https://en.aptoide.com/download?package_uname=aptoide&entry_point=appstore_home_installer_mobile)** and install to your phone. We will update Jolla Store soon.
- [APKPure website](https://m.apkpure.com/), which is another good source of Android apps, started serving 64bit APKs by default and they'll fail to install, but there won't be anything displayed to a user (because notifications from Android App Support are broken). You will need to choose armeabi-v7a (32bit) variant of the APK on the website.
- Android apps cannot use peripheral devices via Bluetooth - other than for playback of the sound. Therefore smartwatches, for instance, cannot be controlled from Android apps.
- The voice of an incoming call might not automatically be routed to a wired headset. However, if the user first directs the voice to the HF speaker and then back to the headset, the voice can be heard at the headset.

## Known issues specific to Xperia X [no changes here]

- Not implemented features: FM radio, double-tap wakeup, step counter, RTC Alarms
- Issues with mobile data persist on some SIM cards. Turn the Flight mode on and off to reset the network setup. Reverting the device to Android and re-installing Sailfish X has often helped. See our [support article](https://jolla.zendesk.com/hc/en-us/articles/115004283713).
- [camera] Force autofocus mode for photos, and continuous for video. After this, camera focus is still not ideal - as the camera stays out of focus when it starts until you either tap or try to take a shot - but the pictures seem to be better focused now
- Bluetooth: problems with some car equipment, some audio devices and computers may appear
- The loudspeaker volume level cannot be adjusted very high
- Not all SD cards are recognized and mounted.

## Known issues specific to Xperia XA2 [no changes here]

- Not implemented features: FM radio, double-tap wakeup, RTC Alarms
- Bluetooth: there are problems in connecting to some peripheral devices
- XA2 does not power up when alarm time has elapsed
- Flashing Sailfish X to XA2 might still fail (so far seen to happen on Ubuntu 18.04 when using USB3 port). Please read [this article](https://jolla.zendesk.com/hc/en-us/articles/360012031854).

- With [v17B](https://developer.sony.com/file/download/software-binaries-for-aosp-oreo-android-8-1-kernel-4-4-nile) Sony vendor image we observed a decrease in the perceived signal strength of the 5GHz WLAN access points (investigations ongoing). Version [v16](https://developer.sony.com/file/download/software-binaries-for-aosp-oreo-android-8-1-kernel-4-4-nile-v16/) may work better in this respect. Therefore we would not recommend flashing v17B for the time being if you use WLAN networks in the 5GHz band. You can reflash the vendor image of your choice by following the instructions in [here](https://jolla.zendesk.com/hc/en-us/articles/360019346354).

## Known issues specific to Xperia 10 [no changes here]

- Features not yet implemented: FM radio, double-tap wakeup, support for dual-lens camera, RTC Alarms.
- Rarely, audio playback and sensors (display rotation) may stop working. If this happens, please restart the device
- In some cases, the acceptance of the PIN code of a SIM card may take up to 5...20 seconds
- White balance and HDR (of the camera) do not work.
- Transitions related to network switching 4G > 3G (call begins) and 3G > 4G (call ends) may take time on some networks. Getting the data connection of 4G might require extra actions in the worst cases. Normally, these transitions take 2-10 seconds on Xperia 10.

## Known issues specific to Jolla Tablet [no changes here]

- There is no progress bar during the installation phase of OS upgrades. This makes it difficult to follow if it makes progress or not. However, if there are no problems the device will restart itself in the end - please wait patiently. If you feel that you have waited enough, wait for yet another 20 minutes before you turn off the device to allow some more time for it to complete the job. Interrupting too early may break the tablet.
- Taking screenshots is broken. Pressing the VOL keys together seems to create an image but it cannot be viewed in Gallery.

## Known issues specific to Gemini PDA [no changes here]

- Features not yet implemented: double-tap wakeup, RTC Alarms
- Gemini Screenshot Button Fn + X does not work
- Not possible to answer calls when Gemini is closed with side button
- Some 3rd party apps have issues in Landscape mode.


