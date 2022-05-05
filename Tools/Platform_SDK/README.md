---
title: Sailfish Platform SDK
permalink: Tools/Platform_SDK/
has_children: true
layout: default
nav_order: 200
---

**Attention: Platform development is now more convenient with the regular [Sailfish SDK](/Develop/Platform) through its command line frontend 'sfdk', available on all Linux, macOS and Windows. The Linux-only chroot based Sailfish Platform SDK remains available for special applications. It also remains the default (documented) option for [Hardware Adaptation Development](/Tools/Hardware_Adaptation_Development_Kit), although the regular Sailfish SDK can be used for that purpose as well.**

# Overview

The Sailfish Platform SDK is a flexible and powerful command line environment which provides access to a range of [Development tools](/Tools/Development) in order to build, test and deploy Sailfish OS packages.

Installation is covered in the [Sailfish Platform SDK Installation](/Tools/Platform_SDK/Installation) and the [Sailfish Platform SDK Target Installation](/Tools/Platform_SDK/Target_Installation) guides.

# SDK Design and Terminology

The SDK is a flexible system which consists of a chroot environment which provides an array of host tools, including a ScratchBox2 container in which architecture-specific binaries can be built using QEMU based emulation.

It helps to understand that the goal of the SDK is to:

1.  run on a wide variety of host PCs (without needing to explicitly support them all)
2.  use a consistent set of tools
    and
3.  be able to cross-compile for multiple devices with different architectures (ARM or x86) or OS versions

To achieve this, we'll assume a modern linux based development machine the top level OS which is running linux and has a filesystem which the platform SDK can access.

For the first goal: The platform SDK is a minimal virtual installation of the Sailfish OS which runs inside a simple container/virtualisation and shares access to many of the outer linux machine's data files (ie source code) but uses it's own executables and libraries. This is the first level of nesting the SDK itself. The platform SDK is typically accessed as a chroot system in a shell/console on linux based hosts although other options such as VirtualBox or lxc are also used if required.

For the second goal: The platform SDK (not the host computer's OS) provides all the development tools and CPU-architecture-specific toolchains. It does not have any Sailfish OS library/header files (although it \*does\* have libraries/headers which can be used for building more tools).

Finally, the third goal is met by having one or more "Target"s **inside** the platform SDK. A Target is a collection of libraries/headers for a specific version/CPU-architecture of Sailfish OS (or other platforms). This is the second level of nesting - the device environment - and access to it is via the [Scratchbox2](/Scratchbox2 "brokenlink") system (which is part of the SDK).

How this affects things in practice:

1.  The host machine does not need very much software installed into the native OS
2.  Development tools are installed into the SDK container (and this is done the same way on Linux/Windows/Mac)
3.  Build time dependencies for a given package (ie libraries and headers) are installed into the relevant Target container(s)

# Setup

## Installation

Installing the SDK requires a few steps:

1.  install the Sailfish Platform SDK
2.  add suitable repositories for Sailfish OS development
3.  install toolchains
4.  install and set up suitable targets

For details follow the [Sailfish Platform SDK Installation](/Tools/Platform_SDK/Installation) guide.

## Setup Target(s)

A Target provides the development environment for the device you're building for; typically this will be an ARM device running Sailfish OS.

Targets are easy to install:

1.  Enter the SDK
2.  Download the Target tarball
3.  Use the sdk-assistant to install the target

See the [Sailfish Platform SDK Target Installation](/Tools/Platform_SDK/Target_Installation) guide for details.
