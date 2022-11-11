---
title: Common Tasks
permalink: Develop/Common_Tasks/
layout: default
nav_order: 700
---

## Common Development Tasks

As a [contributor](/Develop/Collaborate) to Sailfish OS, there are a variety of slightly more advanced tasks which you may occasionally be required to perform. While in many cases the average contributor will never have to do these, it is useful information for every contributor and developer of Sailfish OS.

### Creating Packages

In some cases, a contributor will wish to contribute an entirely new feature, either as a standalone application or a plugin to an existing application or framework in Sailfish OS. Creating a new package is often the correct course of action in this instance.

To do so, the contributor must:

1.  request that a new repository be created
2.  commit the code to that repository following the [Collaborative Development](/Develop/Collaborate) process
3.  write an RPM SPEC file and commit that to the repository
4.  trigger OBS to build the package
5.  ensure that the package is pulled into an image via the appropriate "pattern"

### Creating Images

The [Imager service](/Services/Development/Image_Creator) allows contributors to construct images which contain a specific set of content. This can be useful for creating SDK target RootFS images, or for creating device-flashable images.

### Flashing Devices

To flash a device, the contributor should download the flashable image tarball from the imager service. That tarball will contain a script (flash.sh for Linux, flash.bat for Windows) which allows the device to be flashed. The contributor needs to have a recent version of fastboot which can talk to their specific device.

To flash the device, the contributor should reboot the device into fastboot mode, then run the flash script on their host machine, and then plug their (fastboot-mode) device into their host machine via USB. The flash script should then flash the device successfully.

More information is available at the [Flashing](/Develop/HW_Adaptation/Flashing) page.

### Diagnostics

A variety of diagnostic information can be retrieved from the device, including journal logs, telemetry information (including memory and CPU usage snapshots over time, battery usage reports, and data transfer reports), crash dumps, and telephony and connectivity information. A comprehensive list of commands to retrieve diagnostics information is included in the [Sailfish OS Cheat Sheet](/Reference/Sailfish_OS_Cheat_Sheet).
