---
title: Telephony
permalink: Reference/Core_Areas_and_APIs/Apps_and_MW/Telephony/
parent: Apps and MW
grand_parent: Core Areas and APIs
layout: default
---

### Telephony

The Sailfish OS telephony features include the capabilities for making phone calls, alerting with ringtones, phone call audio routing, SIM management and dual SIM capabilities, GPRS and phone network operator connections, AT command handling, SIM ToolKit interaction and general modem management.

### Relevant development repositories

The oFono framework is used for general modem management, and ConnMan for network connection management:

  - [ofono](https://github.com/sailfishos/ofono) - Jolla fork of <https://01.org/ofono>
  - [libqofono](https://github.com/sailfishos/libqofono) - A Qt library for accessing the ofono daemon, including a QML API
  - [libqofonoext](https://github.com/sailfishos/libqofonoext) - A Qt library for accessing nemomobile-specific ofono extensions, including a QML API
  - [connman](https://github.com/sailfishos/connman) - Jolla fork of <https://01.org/connman>
  - [libconnman-qt](https://github.com/sailfishos/libconnman-qt) - A Qt library for accessing connman, including a QML API

Phone calls are managed through oFono and Telepathy. In addition, the middleware voicecall packages implement plugins to use telepathy with ofono and activate calls, and libcommhistory collects a history of phone calls and messages for later lookup:

  - [telepathy-ring](https://github.com/sailfishos/telepathy-ring) - Telepathy connection manager for GSM and similar mobile telephony
  - [telepathy-qt](https://github.com/sailfishos/telepathy-qt) - Qt library for telepathy clients
  - [telepathy-mission-control](https://github.com/sailfishos/telepathy-mission-control) - account manager and channel dispatcher for Telepathy
  - [voicecall](https://github.com/sailfishos/voicecall) - voicecall and voicecallmanager for implementing dialer UIs and activating calls
  - [libcommhistory](https://github.com/sailfishos/libcommhistory) - central management and collection of call and messaging events

Call audio management and routing is implemented through PulseAudio:

  - [pulseaudio](https://github.com/sailfishos/pulseaudio)
  - [pulseaudio-modules-nemo](https://github.com/sailfishos/pulseaudio-modules-nemo)

### Architecture

See [Cellular Telephony Architecture](/Reference/Core_Areas_and_APIs/Networking/Cellular_Telephony_Architecture).
