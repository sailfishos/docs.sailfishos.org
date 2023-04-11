---
title: Networking
permalink: Reference/Core_Areas_and_APIs/Networking/
has_children: true
parent: Core Areas and APIs
layout: default
nav_order: 400
---

Networking capabilities are primarily implemented through:

  - ConnMan for general network connection management
  - oFono for cellular networking
  - BlueZ for Bluetooth connectivity
  - D-Bus and MCE for system state management

## ConnMan

[ConnMan](https://01.org/connman) manages all internet connectivity features on Sailfish OS. This includes:

  - Wi-Fi and cellular mobile data scanning and connections
  - WLAN hotspot connection sharing
  - Flight mode handling for disabling/restoring connectivity

The Sailfish OS adaptation of ConnMan is available at <https://github.com/sailfishos/connman>. Generally, Sailfish app developers will find it easier to use [libconnman-qt](https://github.com/sailfishos/libconnman-qt) instead, as that provides a Qt-based API as well as a QML module for accessing ConnMan functionality.

## oFono

[oFono](https://01.org/ofono) is the base library used for all cellular-related features. For example:

  - Cellular network registration and operator queries
  - Core modem management
  - Phone calls, SMS and MMS
  - Bluetooth connections for making calls via the Bluetooth Handsfree Profile (HFP)
  - SIM operations, including PIN and PUK codes and SIM ToolKit (STK) access
  - Supplementary service code handling including USSD/GSM Codes

The Sailfish OS adaptation of oFono is available at <https://github.com/sailfishos/ofono>. Generally, Sailfish app developers will find it easier to use [libqofono](https://github.com/sailfishos/libqofono) and [libqofonoext](https://github.com/sailfishos/libqofonoext); these provide Qt-based APIs and QML modules for accessing oFono functionality.

## Bluetooth

[BlueZ](http://www.bluez.org/) is the base library for all Bluetooth-related features.

Currently, Sailfish OS provides the following profiles:

  - Audio Gateway for Headset Profile (HSP) and Handsfree Profile (HFP) for making calls via Bluetooth headsets
  - Advanced Audio Distribution Profile (A2DP) for playback of multimedia audio over a Bluetooth connection
  - SyncML client & server (SyncML) for synchronization of contact data
  - OBEX Object Push (OPP) for file exchange services
  - Phone Book Access Profile (PBAP) for exchanging phonebook data with a car kit
  - AVCTP 1.3 (Audio/Video Control Transport Protocol), AVDTP 1.2 (Audio/Video Distribution Transport Protocol) and AVRCP 1.3 (Audio/Video Remote Control Profile). Allows using your Sailfish device as a rudimentary remote control to other Bluetooth devices: "play, stop, pause" etc. commands to devices.
  - HID 1.0 (Human Interface Device Profile). Allows use of HIDs with a Sailfish device, for example keyboards and mice.

The Sailfish OS adaptation of BlueZ is available at <https://github.com/sailfishos/bluez>. Generally, Sailfish app developers will find it easier to use [libbluez-qt](https://github.com/sailfishos/libbluez-qt) instead, as that provides a Qt-based API and QML module for accessing BlueZ functionality.

Bluetooth audio distribution is managed through [PulseAudio](https://www.freedesktop.org/wiki/Software/PulseAudio/).

## MCE

MCE provides mode-control for Sailfish OS. This includes management of screen modes (on, dimmed, off, locked), power modes (including deep-sleep and other low-power modes) and radio states which may affect network connectivity or latency (for example, allowing network packet I/O to be synchronised to a heartbeat timer to achieve power-saving efficiencies). The source code for MCE can be found [here](https://github.com/sailfishos/mce/).
