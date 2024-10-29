---
title: Android AppSupport
permalink: Support/Help_Articles/Android_App_Support/
parent: Help Articles
has_children: true
layout: default
nav_order: 100
---

Sailfish OS aims to be compatible with the majority of Android apps, but due to the sheer volume of Android applications designed for Android-based devices with different configurations, we cannot guarantee 100% compatibility.

In this article, you will learn how to make the best of the **Android AppSupport** on your Sailfish device.

If you would like to remove Android apps (and support) from your Sailfish device, read [**this help article**](/Support/Help_Articles/Android_App_Support/Removing_Android_App_Support/).

# Installing Android applications on your Sailfish device
Installing Android applications is done by downloading **apk** files (an Android package file used to distribute applications) from Android application stores, followed by the installation in the app store.

Before installing any Android apps, **Android AppSupport** (simulation of the Android system on Sailfish OS) must be installed. It is available in the Jolla Store. This requires the Sailfish OS licence.

Android apps are installed in the internal storage of a phone. Installing apps on SD cards is not supported.

After installing Android apps, the folder ```/home/.appsupport/instance/defaultuser/data/data``` has all of your installed Android apps. The folder ```/home/defaultuser/android_storage/Android/data/``` contains the data meaningful to you in various Android apps. 
Files saved using Android apps, for example downloaded files in a web browser or photos taken in a camera app, are stored in their respective folders in ```/home/defaultuser/android_storage```.

## Installing applications from application stores
Sailfish OS supports Android apps featured in the Jolla Store and the Jolla-certified app partner stores.

We recommend first checking what is available in **Aurora Store** and **F-Droid**. They are the Android apps stores also available in the Jolla Store app (in category Marketplaces). 

### Note regarding the Google Play Store
Sailfish OS does not support the Google Play store, because it relies on Google's proprietary background services only found on Android devices running Google's Android. We always advise against installing Google Services on SailfishOS, as it is known to potentially cause different problems.

Applications reporting that they require Google Play Services may work entirely or partially regardless of that disclaimer.  On the other hand, it may not be possible to install some apps at all.

## Installing applications from .apk files
Android applications are installed from files with the extension ".apk". Once you point your Sailfish device to such a file, it is possible to install the Android application from this file.
Installing .apk files requires enabling "Settings > System > Untrusted software > Allow untrusted software". Installing Android apps (including Android application stores) from previously unused sources is considered potentially risky. Therefore, you must deliberately allow it.
NOTE: We recommend installing Android apps directly from application stores (see chapter above) instead of installing ".apk" files.

### Downloading with the Browser

You can web search via the Sailfish browser for the app you are interested in and if you find the application's .apk file, you can download it, and then install it. The browser downloads the files to folder Downloads. Read about the Sailfish Browser [**in this document**](/Support/Help_Articles/Web_Browser/).

The downloaded files can also be found in "Settings > Transfers".

Once you see the list of downloaded files, tap on a file to begin installing it.

### Using File Manager
Another option to install .apk files is to first copy them to your device (e.g. to the Downloads folder) and then use the **File manager** application (Settings > Storage > User data, see the pulley menu) to install the file/application. Start the installation simply by tapping  the .apk file in File Manager. To transfer files between your PC and your Sailfish device, please [**see this document**](/Support/Help_Articles/Moving_Files_between_PC_and_Sailfish_Device/).

[**File Browser**](/Support/Help_Articles/File_Browser/) app (available in Jolla Store) is another option for doing the same.

### Installing via Email

The third way is to send a .apk file attached to an email message. Once you receive the email with the attachment, simply tap on the attachment to download and install it.

# Known limitations to Android AppSupport
As mentioned before, we cannot ensure 100% compatibility of Android apps with Sailfish OS. Often, this is caused by the missing access to certain interfaces at Google services. It is also possible that some features of Android applications are not supported.

Various Sailfish OS devices (generations) have a different Android AppSupport, i.e. the Android version they are compatible with is different. Check the versions in the table of **[SupportedDevices](/Support/Supported_Devices/)**.

Some recently upgraded apps may show a disclaimer that they require a higher "Android SDK version". This means that the Android AppSupport on your Sailfish phone might not be compatible with that app.

# Settings of Android apps
[**This document**](/Support/Help_Articles/Android_App_Support/Android_Application_Settings/) contains information about accessing and changing the generic and application-specific settings of your Android apps.

# Troubleshooting and FAQ

**Q: I cannot find Android AppSupport in Jolla Store although I have the Sailfish licence activated on this device. I may have uninstalled something on the command line.**

"I have tried to install the Android AppSupport even at the command line but it fails":
```
devel-su
pkcon install aliendalvik
Resolving > Package not found: aliendalvik
Command failed: This tool could not find any available package: 
No packages were found
```

Do the following 2 steps:

**1) At the CLI**
```
devel-su
pkcon install feature-alien
reboot
```
**2) In Jolla Store**
- install Android AppSupport

**Q: I'm having trouble finding all the Android apps I need. How can I get these apps?**

You can download Android application stores from Marketplaces of Jolla Store. The Aurora Store has the biggest offering of applications.

**Q: I'm having trouble installing an application from an apk file, what can I do?**

If you are having trouble installing an application from a .apk file, please follow the steps below:

1. Ensure that you have Android AppSupport installed from the Jolla Store. Install if missing.
2. Ensure that you have enabled "Settings > System > Untrusted software > Allow untrusted software".
3. Download and install the Aurora Store application from the Jolla Store. This step will initialize the Android AppSupport of your device and verify that Android apps can be installed on your phone.
4. Attempt installation of the original file again. If this step didn't solve your problem, please keep reading.
5. Attempt installing another application from its .apk

If you were successful at step 5 (but not at 4), it is likely that the original .apk file is corrupted. Please try to obtain the file again from another source.

**Q: I'm having trouble with running Android apps, what can I do?**

If some of your Android apps fail to launch or tend to crash, then it is worthwhile trying to restart the Android AppSupport of your Sailfish device. Restarting the Android service ends all processes related to it, and after this starts them up again.
In order to do this, go to Settings > Android AppSupport and stop it by tapping the "Stop" button and then restart it by tapping the "Start" button.

**Q: I updated my Android app to a new version but it fails to work now. What can I do?**

Find an earlier version of this app - many app stores have the previous versions available. Install an earlier version, effectively downgrade the app. This may help sometimes. Keep an eye on future updates - they may come with fixes that make the app work on the Android app platform of Sailfish OS again.

**Q: I want to install Android apps but cannot as there is no Android AppSupport in the Jolla Store!**

The Sailfish OS licence must be activated on the device. Only then Android AppSupport starts appearing in the Jolla Store.

Buy the licence at the [Jolla Shop](https://shop.jolla.com/). As soon as you have the licence, sign in from your Xperia device to the same Jolla account that you used when purchasing the licence. If you have signed in already then restart the device. The licence is now tied both to your account and to the IMEI code of your device. It is active. Next, open the Jolla Store and look for **Android AppSupport** in the Jolla category.

**Q: How can I change the permissions of Android apps?**

See [**this article**](/Support/Help_Articles/Android_App_Support/Android_Application_Settings/), please.

**Q: How can I uninstall Android apps and Android AppSupport?**

See [**this article**](/Support/Help_Articles/Android_App_Support/Removing_Android_App_Support/), please.

**Q: I cannot install or open an Android app as it says "your device is rooted"**

Sailfish OS release 4.3.0 brings the signing of the Android system image. The practical consequence of this is that the warning on a rooted device should not appear anymore, and the related apps should work now on Sailfish devices.

**Q: My device cannot fully boot up to the Home view. I suspect Android AppSupport is causing trouble. How can I disable it?**

Make an [SSH connection](https://docs.sailfishos.org/Support/Help_Articles/SSH_and_SCP/) to the phone.

Issue the following commands:
```
devel-su
systemctl mask aliendalvik
```

