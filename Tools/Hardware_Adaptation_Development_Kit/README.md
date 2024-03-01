---
title: Hardware Adaptation Development Kit
permalink: Tools/Hardware_Adaptation_Development_Kit/
layout: default
nav_order: 300
---

# Overview

If you want to get Sailfish OS running on a particular device then you're doing Hardware Adaptation development.

It's about working with device bootloaders, configuring and building the Linux kernel, low level Android systems, low level linux systems, C, C++ and shellscript coding, debugging and working blind - all fun stuff!

There is a lot more detail at [the current HADK site](/Develop/HADK/).

# Hardware Abstraction Layer

The [Architecture](/Reference/Architecture) section shows how Sailfish OS sits on top of a HAL - a Hardware Abstraction Layer; in the case of Sailfish OS this layer is itself split into a BSP layer and a hybris layer. Typically the hardware vendor provides an Android Board Support Package (BSP) which allows the Android operating system to drive the hardware. Sailfish OS then uses the libhybris layer to connect the linux system into the vendor's BSP.

## Board Support Packages

A board support package provides the variety of device drivers and other low-level code components which allow the operating system to access the functionality provided by the hardware platform, including CPU features like power-saving, the GPU, and various sensors. In many cases, the BSP will include components which are proprietary, binary blobs, and so the source code will not be available.

## Libhybris

By utilising [libhybris](https://github.com/mer-hybris/libhybris) within Sailfish OS, applications and libraries based on GNU Libc can access functionality provided by libraries and services based upon Bionic. This allows Sailfish OS to connect the Linux system into a board support package from the vendor. This is possible since there is a large degree of commonality between the low level Android and Sailfish OS components.

## Development

The goal of a Hardware Adaptation developer is the creation of a board specific HAL to address the [ hardware components](/Develop/HW_Adaptation).

As mentioned this is covered in great detail in the Hardware Adaptation Development Kit which is a highly technical document which explains how to port Sailfish OS to an Android device. You may [download a PDF of the HADK](/Develop/HADK/).
