---
title: Updating the Vendor Image
permalink: Support/Help_Articles/Updating_Vendor_Image/
parent: Help Articles
layout: default
nav_order: 1110
---

_Sony vendor image is a binary file that contains device-specific firmware from the device vendor, i.e. Sony._
_This file is sometimes called by the name "AOSP SW binary blob", too._

This article explains how the vendor image can be reflashed (installed) **without reflashing the actual Sailfish OS**. This means that you can change the vendor image while 
keeping your data and apps untouched. 


Sony keeps updating the vendor image every now and then. The image for Xperia XA2 has been upgraded from version 16 to version 17B in March 2019. This is used in the examples of this document.


# How to check the current vendor image

Checking the current version of the vendor image can be done with the following command on Xperia XA2 and Xperia 10.
```
devel-su grep ro.odm.version /odm/build.prop
```

Unfortunately, we do not have the command for Xperia 10 II nor 10 III.


# Upgrading the vendor image


1. Download the zipped vendor image file to your Sailfish OS installation directory (where you flashed your phone).
2. Unzip it there. The resulting file is "SW_binaries_for_Xperia_Android_*.img"
3. Connect your Xperia to a USB2 port of your computer (pressing the Vol Up button at the same time) so that the blue LED gets lit on the Xperia.
4. Give one of the following commands.

```
fastboot flash oem_a <filename>
```

## Example: Xperia XA2

1. Download the zipped vendor image file **[v17B](https://developer.sony.com/file/download/software-binaries-for-aosp-oreo-android-8-1-kernel-4-4-nile/)** to your Sailfish X flashing directory. 
It has the name "SW_binaries_for_Xperia_Android_8.1.6.4_r1_v17B_nile.zip".
2. Unzip it there. The resulting file is "SW_binaries_for_Xperia_Android_8.1.6.4_r1_v17_nile.img"
3. Connect your XA2 to a **USB2** port.
4. Give the following command

```
fastboot flash oem_a **SW_binaries_for_Xperia_Android_8.1.6.4_r1_v17_nile.img
```

This is the expected output from the command:
```
  fastboot flash oem_a
  SW_binaries_for_Xperia_Android_8.1.6.4_r1_v17_nile.img
  target reported max download size of 536870912 bytes
  sending 'oem_a' (210888 KB)...
  OKAY [ 4.885s]
  writing 'oem_a'...
  OKAY [ 0.002s]
  finished. total time: 4.900s
```

# Downgrading the vendor image

Downgrading the vendor image goes in the same way as upgrading - see chapter [Upgrading the vendor image](#upgrading-the-vendor-image) above. Just ensure that you use an image officially supported by Jolla. Other combinations have not been tested.

## Example: Xperia XA2

You may want to return to the v16 image on the Xperia XA2. Download the **[v16 image file](https://developer.sony.com/file/download/software-binaries-for-aosp-oreo-android-8-1-kernel-4-4-nile-v16/)**.

The command to flash it is this: 
```
fastboot flash oem_a SW_binaries_for_Xperia_Android_8.1.6.4_r1_v16_nile.img
```


