---
title: Cellular Network Time
permalink: Reference/Core_Areas_and_APIs/Networking/Cellular_Network_Time/
parent: Networking
grand_parent: Core Areas and APIs
layout: default
nav_order: 400
---

Cellular Network Time is a part of the [Cellular Telephony Architecture](/Reference/Core_Areas_and_APIs/Networking/Cellular_Telephony_Architecture)

## Cellular Network Time

Timed is a daemon for managing the device system time, time zone, time events and related settings used, for example, by clock applications. Timed provides a D-Bus interface that can be used directly or via C++ Qt-bindings. More information about timed can be found [here](/Reference/Core_Areas_and_APIs/Apps_and_MW/Alarms#timed).

OFono is used by Timed to query the cellular network time. If NITZ is supported by the network this information may be received by oFono and thus by Timed in the following cases:

  - when registering on the network
  - the device geographically relocates to a different local time zone
  - the network changes its local time zone (eg: between the summer and winter time)
  - the network changes its identity
  - or at any time during a signalling connection with a mobile station.
