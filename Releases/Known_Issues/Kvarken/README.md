---
title: Sailfish OS 4.1.0.24 Known Issues
permalink: Releases/Known_Issues/Kvarken/
parent: Known Issues
grand_parent: Releases
layout: default
nav_order: 400
---

This content can also be found in the [forum Release Notes](https://forum.sailfishos.org/t/release-notes-kvarken-4-1-0/5942#known-issues-generic-47).

## Generic

- Sailfish can connect *Bluetooth Low Energy devices*. However, Android apps cannot use peripheral devices via Bluetooth - other than for playback of the sound. Therefore smartwatches, for instance, cannot be controlled from Android apps, unfortunately.

- *Signing into Dropbox* works via Google only. So, after triggering the sign-in at "Settings > Accounts > Dropbox" and the browser page dropbox.com appears, tap "Sign in with Google" (if you have a Google account).

- An invalid warning and request to *uninstall all system packages* will appear if the previous OS version 4.0.1 is flashed to a device without installing the default Sailfish apps, followed by the download of the current OS version 4.1.0. This warning looks scary but it is just a warning. It should be okay to continue downloading and installing the OS update in the normal manner, i.e., you can ignore the warning. To avoid the warning, enabling the developer mode and running <code> devel-su; pkcon refresh</code> before downloading 4.1.0 may prevent the warning from appearing.

- QR code reader can recognise only the 2-dimensional code that has squares in 3 corners (for positioning).

- [ *developers only* ] connman-test package is broken (does not install) for devices freshly flashed with 4.1.0, because dbus-python is no longer available (requires python2). All still works if updating from 3.4.0 as in this case the old dbus-python (if it exists in rootfs) will be used.

## Known issues to Android App Support 10 - Xperia 10 II, Xperia 10, and Xperia XA2

- Android apps cannot use peripheral devices via Bluetooth - other than for playback of the sound. Therefore smartwatches, for instance, cannot be controlled byk Android apps.

- The 'old' version of the Aptoide Store app cannot install anything anymore on Android 10. Please update the Aptoide app on your phone by downloading and installing the new version from Jolla Store - it will show a notification about Aptoide update if you have installed it from the Jolla Store in the past

- Update your APKpure app to its latest version, to 3.17.19 or later.

- After installing Android App Support, please restart your phone to make mobile data available for your Android apps.

## Known issues specific to Xperia 10 II

- Unfortunately, we cannot provide you with the Predictive text input on this phone yet. We are working on this, though. Expected in one of the next OS updates.

- The Sailfish Camera app does not support the three rear cameras of this product, yet. Only one camera is supported. However, every camera is available at the middleware level for other apps to use, e.g., [Advanced Camera](https://openrepos.net/content/piggz/advanced-camera). Android "Open Camera" can use the 3 cameras, too.

- White balance & light sensitivity selectors do not work on Sailfish Camera

- Mobile data over 3G and 2G connections might not work. LTE/4G does work.

- Top edge swipes in landscape orientation may not work so well

- 5 GHz WLAN signal reception is weaker than should be

- While restarting the phone for the 1st time after completing the startup wizard, Xperia 10 II tends to lose the saved WiFi network(s). This does not happen on the following restarts, though **.** Also, the first restart may harm your sign-in to your accounts. To avoid problems, please restart your phone after completing the startup wizard. Then, sign in to your WLAN and accounts. 

- Wired headsets currently work as headphones during voice calls so one needs to talk into the phone's microphone during voice calls if a headset is in use

- Sidetone feature is not perfectly calibrated, and sidetone volume can be a bit high in wired accessories during voice calls

- There is no partition for the factory-reset image on Xperia 10 II. Therefore there is no option for the factory reset in the Settings. Instead of resetting the phone, it can be reflashed.  [This is not actually an issue but can be perceived as such.]

- NOTE: Those who have installed 4.1.0 to their Xperia 10 II, used the phone with the free trial licence and installed some Android apps from Jolla Store (Aptoide, Here WeGo) already when there is no Android App Support on the phone: after buying the licence, you must *uninstall the Android apps first*. Only then can you install Android App Support.

## Known issues specific to Xperia 10 [ *no changes here* ]

- Features not yet implemented: FM radio, double-tap wakeup, support for dual camera, RTC Alarms.

- Rarely, audio playback and sensors (display rotation) may stop working. If this happens, please restart the device

- In some cases, the acceptance of the PIN code of a SIM card may take up to 5...20 seconds

- White balance and HDR (of the camera) do not work.

- The phone may not turn off by applying the Power key or the Top Menu. A forced power down goes like this: press both the Volume Up and Power keys down. Keep them down for 20-30 sec until the vibrator plays 3 times - now release the keys.

- Transitions related to network switching 4G > 3G (call begins) and 3G > 4G (call ends) may take time on some networks. Getting the data connection via 4G back might require extra actions in the worst cases. Normally, in most networks, these transitions take few seconds on Xperia 10.

## Known issues specific to Xperia XA2

- Not implemented features: FM radio, double-tap wakeup, RTC Alarms

- Bluetooth: there are problems in connecting to some peripheral devices

- XA2 does not power up when alarm time has elapsed

- Flashing Sailfish X to XA2 might still fail (so far seen to happen on Ubuntu 18.04 when using USB3 port). Please read [this article](https://jolla.zendesk.com/hc/en-us/articles/360012031854).

- With [v17B](https://developer.sony.com/file/download/software-binaries-for-aosp-oreo-android-8-1-kernel-4-4-nile) Sony vendor image we observed a decrease in the perceived signal strength of the 5 GHz WLAN access points (investigations ongoing). Version [v16](https://developer.sony.com/file/download/software-binaries-for-aosp-oreo-android-8-1-kernel-4-4-nile-v16/) may work better in this respect. Therefore we would not recommend flashing v17B for the time being if you use WLAN networks in the 5 GHz band. You can reflash the vendor image of your choice by following the instructions in [here](https://jolla.zendesk.com/hc/en-us/articles/360019346354).

- Some XA2 devices suffer from the loss of audio during voice calls. Reported [here](https://forum.sailfishos.org/t/3-4-0-22-xa2-phone-calls-no-audio/2446).

## Known issues specific to Xperia X [ *no changes here* ]

- Not implemented features: FM radio, double-tap wakeup, step counter, RTC Alarms

- Issues with mobile data persist on some SIM cards. Turn the Flight mode on and off to reset the network setup. Reverting the device to Android and re-installing Sailfish X has often helped. See our [support article](https://jolla.zendesk.com/hc/en-us/articles/115004283713).

- [camera] Force autofocus mode for photos, and continuous for video. After this, camera focus is still not ideal - as the camera stays out of focus when it starts until you either tap or try to take a shot - but the pictures seem to be better focused now

- Bluetooth: problems with some car equipment, some audio devices and computers may appear

- The loudspeaker volume level cannot be adjusted very high

- Not all SD cards are recognized and mounted.

## Known issues specific to Jolla Tablet [ *no changes here* ]

- There is no progress bar during the installation phase of OS upgrades. This makes it difficult to follow if it makes progress or not. However, if there are no problems the device will restart itself in the end - please wait patiently. If you feel that you have waited enough, wait for yet another 20 minutes before you turn off the device to allow some more time for it to complete the job. Interrupting too early may break the tablet.

- Taking screenshots is broken. Pressing the VOL keys together seems to create an image but it cannot be viewed in Gallery.

## Known issues specific to Gemini PDA

- **OS update to 4.1.0 seems to break the audio functions on Gemini**

- Features not yet implemented: double-tap wakeup, RTC Alarms

- Gemini Screenshot Button Fn + X does not work

- Not possible to answer calls when Gemini is closed with side button

- Some 3rd party apps have issues in Landscape mode.


