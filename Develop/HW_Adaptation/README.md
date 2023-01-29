---
title: HW Adaptation
permalink: Develop/HW_Adaptation/
has_children: true
layout: default
nav_order: 300
---

# Overview

Sailfish OS is, of course, designed to run on actual devices and there are a number of areas related to making that work smoothly.

Logically the flow is:

  - Port Sailfish OS to work on a given device
  - Build an image
  - Install (flash) the image onto the device

However the order in which they're most used is:

  - [Flashing](/Develop/HW_Adaptation/Flashing)
  - [Image Creator](/Services/Development/Image_Creator)
  - [Porting using the Hardware Adaptation Development Kit](/Tools/Hardware_Adaptation_Development_Kit)

Different devices have different mechanisms for some of the steps related to flashing; the [Devices](/Develop/HW_Adaptation/Devices) page provides links which may be helpful for some devices.

The hardware areas which need adapting are:

  - kernel
  - display
  - touch
  - LED indicator
  - audio
  - NFC
  - bluetooth
  - GSM : SMS/voice/data
  - wlan : connect/hotspot
  - GPS
  - Camera
  - Sensors : Ambient Light/PS/Accel/Gyro/Magnetic
  - Keys: Home/Volume
  - Vibra
  - Haptics
  - Power management
  - Real time clock/alarms
  - USB : Network/Charging
  - FM Radio

The status of community adaptations to common devices are [recorded here](https://forum.sailfishos.org/t/community-hardware-adaptations/14081).
