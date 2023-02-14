---
title: Android App Support
permalink: Support/Help_Articles/Android_App_Support/
parent: Help Articles
has_children: true
layout: default
nav_order: 100
---

Sailfish OS aims to be compatible with the majority of Android apps, but due to the sheer volume of Android applications designed for Android-based devices with different configurations, we cannot guarantee 100% compatibility.

In this article, you will learn how to make the best of the **Android™ App Support** on your Sailfish device.

If you would like to remove Android apps (and support) from your Sailfish device, read [**this help article**](/Support/Help_Articles/Android_App_Support/Removing_Android_App_Support/).

# Installing Android applications on your Sailfish device
Installing Android applications is done by downloading **apk** files (an Android package file used to distribute applications) from application stores and by then installing them to your Sailfish device.

Before installing any Android apps one must install **Android™ App Support** (simulation of the Android system on Sailfish OS) which is available in the Jolla Store. This requires the Sailfish X licence on Xperia devices.

Android apps are installed in the internal storage of a phone. Installing apps on SD cards is not supported.

After installing Android apps, the folder ```/home/.android/data/app``` shows all of your installed Android apps. The folder ```/home/defaultuser/android_storage/Android/data/``` contains the data meaningful to you in various Android apps.

## Installing applications from application stores
The SailfishOS operating system of Jolla supports Android apps that are featured in the Jolla Store and in Jolla-certified app partner stores.

We recommend first checking what is available in **[Aptoide Store](/Support/Help_Articles/Android_App_Support/Aptoide/)**. This is our Android apps store by Aptoide, available in the Jolla Store app (in category Marketplaces). After installing this app, it appears simply as **"Aptoide"** at the Sailfish apps grid.

<div class="flex-images" markdown="1">

* <a href="aptoide3.png" class="narrow-image"><img src="aptoide3.png" alt="Apptoide"></a>
  <span class="md_figcaption">
    Apptoide app at the app grid
  </span>
</div>

There are also other Android app stores (see examples below), some of which we have tried out, and it is possible to download these stores to your Sailfish device and install apps from there.
Some examples of other app stores:

* APKpure  (see this [**help article**](/Support/Help_Articles/Android_App_Support/APKPure/))
* [**F-Droid**](https://f-droid.org/en/) (can be installed from Marketplaces of Jolla Store)
* Aurora Store (can be installed from F-Droid)
* [**Amazon**](http://www.amazon.com/gp/mas/get/android)

### Note regarding the Google Play Store
Sailfish OS does not support the Google Play store, because it relies on Google's proprietary background services only found on Android devices running Google's Android. We always advise against installing Google Services on SailfishOS, as it is known to potentially cause different problems.

Applications that report that they require Google Play Services may work entirely or partially regardless of that disclaimer.  On the other hand, it may not be possible to install some apps at all.

## Installing applications from .apk files
Android applications are installed from files with the extension ".apk". Once you point your Sailfish device to such a file, it is possible to install the Android application from this file.
NOTE: We recommend installing Android apps directly from application stores (see chapter above) instead of installing ".apk" files.

### Downloading with the Browser

You can web search via the Sailfish browser for the app you are interested in and if you find the application's .apk file, you can download it, and then install it. The browser downloads the files to folder Downloads. Read about the Sailfish Browser [**in this document**](/Support/Help_Articles/Web_Browser/).

Transfers can also be found in Settings > Transfers.

Once you see the list of downloaded files, tap on the file to begin installing it.

[**This help article**](/Support/Help_Articles/Android_App_Support/APKPure/) has the detailed steps of installing APK Pure app store using this method.

### Using File Manager
Another option to install .apk files is to first copy them to your device (e.g. to the Downloads folder) and then use the **File manager** application (Settings > Storage > User data, see the pulley menu) to install the file/application (tap the .apk file in File Manager). To transfer files between your PC and your Sailfish device please [**see this document**](/Support/Help_Articles/Moving_Files_Between_PC_and_Sailfish_Device/).

[**File Browser**](/Support/Help_Articles/File_Browser/) app (available in Jolla Store) is another option for doing the same.

### Installing via Email

The third way is to send a .apk file attached to an email message. Once you receive the email with the attachment, simply tap on the attachment to download and install it.

# Known limitations to Android App Support
As mentioned before, we cannot ensure 100% compatibility of Android apps with Sailfish OS. Often, this is caused by the missing access to certain interfaces at Google services (see chapter above). It is also possible that some features of Android applications are not supported.

Various Sailfish OS devices (generations) have a different Android App Support, i.e.  the Android version they are compatible with is different:

* Android 10 on Xperia XA2, Xperia 10 and Xperia 10 II from Sailfish OS 4.1.0 [^1] onwards (Android 11 is recommended for Xperia X 10 III, please note that Android 12 is not yet recommended) 
	* API level (SDK version) 29
* Android 9 "Pie" on Xperia XA2 and Xperia 10 from Sailfish OS 4.0.1 onwards 
	* API level (SDK version) 28
* Android 8.1 "Oreo" on Xperia XA2 and Xperia 10 up to Sailfish OS 3.4.0 [^2]
	* API level (SDK version) 27
* Android 4.4.4 "Kit-Kat" on Xperia X, Jolla Tablet and Jolla C
	* API level (SDK version) 19
* Android 4.1.2 "Jelly Bean" on Jolla Phone
	* API level (SDK version) 16
If an Android application requires let's say Android 5.0 Lollipop it will typically refuse to install on any other Sailfish OS devices but Xperia XA2 and Xperia 10. Even if it were possible to install the app it would not work fully or at all.

Some apps may show a disclaimer that they require a higher "Android SDK version". This means that the Android App Support on your Sailfish phone is not compatible with that app. However, that app would probably work on Xperia XA2 or Xperia 10 as the Android SDK version supported on them is 28 or 29, given that the phone has Sailfish 4 installed.

[^1]: Rolled out in May 2021.

[^2]: Android App Support running on Xperia XA2 and on Xperia 10 simulates Android 8.1 "Oreo" but it is compatible with the hardware drivers of Android 9 (AOSP 9). This makes it possible to install Sailfish OS to a device having Android 9. However, Android App Support v.8.1 of Sailfish OS is not compatible with Android apps or features requiring Android v.9 - such apps/features would not run on any Sailfish devices.

# Settings of Android apps
[**This document**](/Support/Help_Articles/Android_App_Support/Android_Application_Settings/) contains information about accessing and changing the generic and application-specific settings of your Android apps.

# Troubleshooting and FAQ

**Q: I cannot find Android App Support in Jolla Store although I have the Sailfish licence activated on this device. I may have uninstalled something on the command line.**

"I have tried to install the Android support even at the command line but it fails":
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
- install Android App Support

**Q: I'm having trouble finding all the Android apps I need. How can I get these apps?**

You can download Android application stores from Marketplaces of Jolla Store. The availability depends on your Sailfish OS device but all of them have at least Aptoide Store. Aptoide has perhaps the biggest offering of applications. You may find what you are looking for by using Aptoide's "Search Other Stores" function.

To read more about using the APKPure app store, please [**read this**](/Support/Help_Articles/Android_App_Support/APKPure/).

To read more about using the Aptoide app store in general, please [**see here**](/Support/Help_Articles/Android_App_Support/Aptoide/).

**Q: I'm having trouble installing an application from an apk file, what can I do?**

If you are having troubles installing applications from .apk files, please follow the steps below:

1. Ensure that you have AndroidTM support installed from the Jolla Store. Install if missing.
2. Download and install any Android application from the Jolla Store. This mandatory step will initialize the AndroidTM support of your device so that it will be possible to install .apk files.
3. Attempt installation of the file again. If this step didn't solve your problem, please keep reading:
4. Attempt installing another application from .apk

If you are successful in installing another application from .apk, it is likely that your .apk file is corrupted. Please try to obtain the file again from another source.

**Q: I'm having trouble with running Android apps, what can I do?**

If some of your Android apps fail to launch or tend to crash, then it is worthwhile trying to restart the AndroidTM App Support of your Sailfish device. Restarting the Android service ends all processes related to it, and after this starts them up again.
In order to do this, go to Settings > AndroidTM App Support and stop it by tapping the "Stop" button and then restart it by tapping the "Start" button.

**Q: I updated my Android app to a new version but it fails to work now. What can I do?**

Find an earlier version of this app - many app stores have the previous versions available. Install an earlier version, effectively downgrade the app. This may help sometimes. Keep an eye on future updates - they may come with fixes that make the app work on the Android app platform of Sailfish OS again.

**Q: I want to install Android apps but cannot as there is no Android App Support in the Jolla Store!**

You have probably installed Sailfish X on your Xperia device. In this combination, the Sailfish X licence must be activated on the device. Only then Android App Support starts appearing in Jolla Store

So, sign in from your Xperia device to the same Jolla account that you used when purchasing the licence. If you have signed in already then restart the device. The licence is now tied both to your account and to the IMEI code of your device. It is active. Next, open Jolla Store and look for **Android App Support** in the Jolla category.

**Q: How can I change the permissions of Android apps?**

See [**this article**](/Support/Help_Articles/Android_App_Support/Android_Application_Settings/), please.

**Q: How can I uninstall Android apps and Android App Support?**

See [**this article**](/Support/Help_Articles/Android_App_Support/Removing_Android_App_Support/), please.

**Q: I cannot install or open an Android app as it says "your device is rooted"**

Sailfish OS release 4.3.0 brings the signing of the Android system image. The practical consequence of this is that the warning on a rooted device should not appear anymore, and the related apps should work now on Sailfish devices.

**Q: My device cannot fully boot up to the Home view. I suspect Android App Support is causing trouble. How can I disable it?**

Make an SSH connection to the phone.

Issue the following commands:
```
devel-su
systemctl mask aliendalvik
```

