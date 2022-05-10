---
title: Sailfish OS 4.4.0.58 Known Issues
permalink: Releases/Known_Issues/Vanha_Rauma/
parent: Known Issues
grand_parent: Releases
layout: default
nav_order: 100
---

This content can also be found in the [forum Release Notes](https://forum.sailfishos.org/t/release-notes-vanha-rauma-4-4-0/10656#known-issues-generic-52).

## Generic

- Bluetooth devices are not supported by Android App Support with exception of speakers.
- Flashing Sailfish X might fail (often caused by issues with USB ports). Please read [this article](https://jolla.zendesk.com/hc/en-us/articles/360012031854).
- Manual Android app installation from the terminal or file managers is currently not working on the Android 4.4 version of aliendalvik on SailfishOS 4.4. To solve this, disable sandboxing for this handler by editing the file /usr/share/applications/apkd-mime-handler.desktop and adding the following to the end of the file

    ```
    [X-Sailjail]
    Disabled
    ```

  This doesn't affect installing Android apps from the Jolla store, nor other Android stores.

## Known issues specific to Android App Support 10 - Xperia 10 II, Xperia 10, and Xperia XA2

- Sometimes, Android apps may not be able to use Internet connections via a mobile network. If there are connection problems later on (either WLAN or mobile data), stopping and starting the Android service at "Settings > Android App Support" should help. Toggling the connection off and on is another trick to try.

## Known issues specific to Xperia 10 II

- Features not implemented: Factory reset (can be done by reflashing)
- Top edge swipes in landscape orientation may not work very well
- The sidetone feature is not perfectly calibrated, and sidetone volume can be a bit high in wired accessories during voice calls
- Mobile data does not work in 2G and 3G networks on SIM #2.

## Known issues specific to Xperia 10

- Features not implemented: FM radio, double-tap wakeup, support for dual camera, RTC Alarms.
- Rarely, audio playback and sensors (display rotation) may stop working. If this happens, please restart the device
- In some cases, the acceptance of the PIN code of a SIM card may take up to 5...20 seconds
- The phone may not turn off by applying the Power key or the Top Menu. A forced power down goes like this: press both the Volume Up and Power keys down. Keep them down for 20-30 sec until the vibrator plays 3 times - now release the keys
- Transitions related to network switching 4G > 3G (call begins) and 3G > 4G (call ends) may take time on some networks. Getting the data connection via 4G back might require extra actions in the worst cases. Normally, in most networks, these transitions take a few seconds on Xperia 10.

## Known issues specific to Xperia XA2

- Features not implemented: FM radio, double-tap wakeup, RTC Alarms (XA2 does not power up when alarm time has elapsed )
- Bluetooth: there are problems in connecting to some peripheral devices
- With [v17B](https://developer.sony.com/file/download/software-binaries-for-aosp-oreo-android-8-1-kernel-4-4-nile) Sony vendor image we observed a decrease in the perceived signal strength of the 5 GHz WLAN access points (investigations ongoing). Version [v16](https://developer.sony.com/file/download/software-binaries-for-aosp-oreo-android-8-1-kernel-4-4-nile-v16/) may work better in this respect. Therefore we would not recommend flashing v17B for the time being if you use WLAN networks in the 5 GHz band. You can reflash the vendor image of your choice by following the instructions in [here](https://jolla.zendesk.com/hc/en-us/articles/360019346354).
- Some XA2 devices suffer from the loss of audio during voice calls. Reported [here](https://forum.sailfishos.org/t/3-4-0-22-xa2-phone-calls-no-audio/2446).

## Known issues specific to Xperia X [ *no changes here* ]

- Features not implemented: FM radio, double-tap wakeup, step counter, RTC Alarms
- Issues with mobile data persist on some SIM cards. Turn the Flight mode on and off to reset the network setup. Reverting the device to Android and re-installing Sailfish X has often helped. See our [support article](https://jolla.zendesk.com/hc/en-us/articles/115004283713).
- [camera] Force autofocus mode for photos, and continuous for video. After this, camera focus is still not ideal - as the camera stays out of focus when it starts until you either tap or you try to take a shot - but the pictures seem to be better focused now
- Bluetooth: problems with some car equipment, some audio devices and computers may appear
- The loudspeaker volume level cannot be adjusted very high
- Not all SD cards are recognized and mounted.
- There is a green stripe on the lower edge of the Camera viewfinder. This does not prevent taking pictures, though.

## Known issues specific to Jolla Tablet [ *no changes here* ]

- There is no progress bar during the installation phase of OS upgrades. This makes it difficult to follow if it makes progress or not. However, if there are no problems the device will restart itself in the end - please wait patiently. If you feel that you have waited enough, wait for yet another 20 minutes before you turn off the device to allow some more time for it to complete the job. Interrupting too early may break the tablet.
- Taking screenshots is broken. Pressing the VOL keys together seems to create an image but it cannot be viewed in Gallery.

## Known issues specific to Gemini PDA [ *no changes here* ]

- Features not implemented: double-tap wakeup, RTC Alarms
- Gemini Screenshot Button Fn + X does not work
- Not possible to answer calls when Gemini is closed with a side button
- Horizontal screen in Gemini is not supported by all 3rd party apps.

## Know issues specific to Jolla C [ *no changes here* ]

- If there are issues with the camera of Jolla C, do the following

  `/usr/bin/killall minimediaservice`

  and then start the camera again.


