---
title: Tools
permalink: Tools/
nav_exclude: true
layout: default
---

There are a number of key tools around Sailfish OS; most are used from within the Sailfish SDK. Hardware adaption work is done using the Sailfish Hardware Adaptation Development Kit (Sailfish HADK).

## Sailfish SDK

The Sailfish SDK provides an integrated development environment (IDE) as well as command line interface (CLI) tools and uses virtual machine (VM) technologies to provide an extremely portable build system and a Sailfish OS emulator. It is available for Linux, macOS and Windows operating systems.

It consists of

  - Sailfish IDE: A Qt Creator derivative
  - sfdk: The CLI frontend
  - libSfdk: API for SDK control
  - Build Engine: A VM encapsulating the lower level build tools in a portable manner
  - Add-on Sailfish OS emulators for various Sailfish OS versions
  - Add-on Build Tools enabling development for various Sailfish OS versions running on various HW platforms.

Installation and first steps with the Sailfish SDK are covered in the [Application Development](/Develop/Apps) area. Advanced usage and instructions related to developing the core Sailfish OS functionality are further elaborated in the [Platform Development](/Develop/Platform) area.

## Sailfish Platform SDK

The [Sailfish Platform SDK](/Tools/Platform_SDK) is a powerful command line environment for Sailfish operating system component developers.

## Sailfish HADK

The Sailfish Hardware Adaptation Development Kit is a CLI environment enabling to set up a new Sailfish OS based Linux system that will run on an Android device, on top of an existing Android Hardware Adaptation kernel and drivers. It is available on Linux only.

It it divided into two parts:

  - [Sailfish Platform SDK](/Tools/Platform_SDK): A subset of Sailfish SDK used for building the Sailfish OS specific bits and integrating the full solution
  - Android SDK: An Ubuntu based development environment for building the Android specific bits

See the [Hardware Development](/Tools/Hardware_Adaptation_Development_Kit) area for the detailed information.

## Development tools

A number of individual development tools are available such as:

  - scratchbox2 : a powerful cross-compilation suite
  - git : Sailfish OS uses git extensively for change control
  - mic : Local image generation tool
  - osc : a client for the OBS

A more complete list including toolchain, analysis and testing tools can be found in the [Development Tools](/Tools/Development) area.
