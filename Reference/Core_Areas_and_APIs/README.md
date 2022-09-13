---
title: Core Areas and APIs
permalink: Reference/Core_Areas_and_APIs/
has_children: true
layout: default
nav_order: 600
---

This page provides a summary of the core areas of Sailfish OS.

## System essentials

Sailfish OS is a GNU/Linux system and as such relies on many of the standard GNU applications (shell tools): bash, coreutils, sed, ncurses, gzip, gawk, findutils, readline, emacs, and so on.

The central C library is glibc 2.30.

## Session management

[Systemd](https://systemd.io) provides the system-level session management for Sailfish OS. It handles transitions between power off, act-dead mode (charging), upgrade mode and normal user-sessions/runtime. Systemd's user-session system is used to manage the user executed code, such as the lipstick process.

Most scheduling is handled by *timed*.

## Networking

Networking capabilities are primarily implemented through:

  - [ConnMan](https://01.org/connman) for general network connection management
  - [oFono](https://01.org/ofono) for cellular networking
  - [BlueZ](http://www.bluez.org/) for Bluetooth connectivity

[More info](/Reference/Core_Areas_and_APIs/Networking)

## Graphics

The graphical display for Sailfish OS is handled by Qt and typically operates via a Wayland driver.

3D-acceleration in Sailfish OS uses [OpenGL ES 2.0](http://www.khronos.org/opengles/2_X/) and [EGL native platform interface](http://www.khronos.org/egl) APIs.

Sailfish OS provides the open source [Mesa 3D Graphics Library](http://mesa3d.org/) containing OpenGL ES 2.0 and EGL libraries to link and build against, which can at image build time be replaced with device-specific OpenGL ES 2.0/EGL implementations.

In the core Mesa is built to use [LLVMpipe](http://www.mesa3d.org/llvmpipe.html) for fast software rendering with no hardware specific drivers enabled.

## Multimedia

*Main article: [Multimedia](/Reference/Core_Areas_and_APIs/Multimedia)*

Sailfish Multimedia uses QtMultimedia, on top of GStreamer 1.0 and ffmpeg. On libhybris devices, hardware codecs, camera support and hardware video buffers from the Android HAL are exposed in a custom open-source GStreamer plugin, [gst-droid](https://github.com/sailfishos/gst-droid), that interacts with a custom android multimedia service, [droidmedia](https://github.com/sailfishos/droidmedia).

Media indexing is provided by [GNOME Tracker](https://wiki.gnome.org/Projects/Tracker/), using ffmpeg for video metadata extraction.

Low level audio is handled by pulseaudio with routing and policy managed by [ohm](https://github.com/sailfishos/ohm).

## Input

Sailfish OS input is provided by the kernel's evdev layer and is mainly handled by Qt with [mce](/Reference/Core_Areas_and_APIs/Device_Management/Mce) handling the hardware keys and proximity sensors.

## Filesystem

Sailfish OS does not depend on a specific filesystem and can use BTRFS and Ext4.

## D-Bus APIs

Sailfish OS uses D-Bus to provide functionality for applications. The interfaces are listed at [D-Bus APIs](/Reference/Core_Areas_and_APIs/D-Bus_APIs).

## Application / Middleware

Sailfish OS comprises of a variety of middleware and application components; the main components are listed below. Many of these are built upon the [Qt](/Reference/Qt) framework.

### Lipstick

The main home screen and application UI area is driven by the Lipstick subsystem. This handles:

  - Home screen and launcher
  - Primary system UI swipe navigation
  - Application windows/compositing
  - System-level windows and notifications
  - Events screen and notifications
  - Device locking
  - Ambience switching

[More info](/Reference/Core_Areas_and_APIs/Apps_and_MW/Lipstick)

### Contacts

Sailfish OS provides features to store and manage contact data, synchronize with online contact storage services, and transfer contacts between devices.

[More info](/Reference/Core_Areas_and_APIs/Apps_and_MW/Contacts)

### Telephony

The Sailfish OS telephony features include the capabilities for making phone calls, alerting with ringtones, phone call audio routing, SIM management and dual SIM capabilities, GPRS and phone network operator connections, AT command handling, SIM ToolKit interaction and general modem management.

[More info](/Reference/Core_Areas_and_APIs/Apps_and_MW/Telephony)

### Messaging

Sailfish OS includes a unified messaging framework which allows messages from a variety of sources to be sent and received using a variety of protocols and services, all from the messaging application.

[More info](/Reference/Core_Areas_and_APIs/Apps_and_MW/Messaging)

### Calendar

The Calendar system in Sailfish OS allows users to view, create, and share calendar events, and to schedule reminders for various events. Event information from a variety of sources is separated in the database into distinct calendar collections.

[More info](/Reference/Core_Areas_and_APIs/Apps_and_MW/Calendar)

### Accounts & SSO

Sailfish OS allows the user to create an account on the device, sign in on the device, and then have multiple Sailfish OS applications and services able to access the service with that account. Only privileged applications are able to access account information, or use account credentials to sign on to services.

[More info](/Reference/Core_Areas_and_APIs/Apps_and_MW/Accounts_and_SSO)

### Email

Sailfish OS supports a number of email communication protocols and services. These include:

  - SMTP, POP3 and IMAP access
  - Microsoft Exchange ActiveSync access
  - Scheduling of email synchronization through the Buteo synchronization framework
  - All emails, text/plain and text/html, rendered with [Sailfish WebView](https://github.com/sailfishos/sailfish-components-webview/)

[More info](/Reference/Core_Areas_and_APIs/Apps_and_MW/Email)

### Browser

The web browser in Sailfish OS is a fully open-source component which has been developed in active collaboration with community members. It uses Sailfish Silica UI elements for the browser chrome, and an embedded Gecko engine for content rendering.

[More info](/Reference/Core_Areas_and_APIs/Browser)

### Alarms and Timezone

The time daemon in Sailfish OS provides time-tracking for the system, and handles alarms and timer notifications from the hardware platform to trigger user-visible notifications and non-graphical-feedback, as well as more complicated user interaction. It can use a variety of clocks (including hardware real-time clocks, network time protocol packets from data networks, and NITZ packets from cellular service providers) to synchronise the system date time and timezone, and to trigger events.

[More info](/Reference/Core_Areas_and_APIs/Apps_and_MW/Alarms)

### Location and Positioning

Sailfish OS utilises the GeoClue framework to provide positioning information to clients. A variety of GeoClue provider plugins are implemented within Sailfish OS, each of which uses a different method or resource to provide position updates (including GPS and GPS-assistance services). Client applications can use the QtPositioning APIs to receive position and satellite information updates, via the GeoClue backend for the QtPositioning API.

[More info](/Reference/Core_Areas_and_APIs/Apps_and_MW/Positioning)

### Secure Storage and Cryptography

Sailfish OS offers secure storage and cryptographic operation functionality to client applications. These facilities are provided by plugins to a system daemon, and those plugins may optionally use a Secure Peripheral or Trusted Execution Environment application to perform the storage or crypto operations. Clients can use the provided Qt-based APIs to send requests to the system daemon via D-Bus.

[More info](/Reference/Core_Areas_and_APIs/Apps_and_MW/Secrets_and_Crypto)
