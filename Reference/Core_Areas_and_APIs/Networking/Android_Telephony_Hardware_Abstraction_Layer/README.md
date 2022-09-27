---
title: Android Telephony Hardware Abstraction Layer
permalink: Reference/Core_Areas_and_APIs/Networking/Android_Telephony_Hardware_Abstraction_Layer/
parent: Networking
grand_parent: Core Areas and APIs
layout: default
nav_order: 1000
---

Android Telephony Hardware Abstraction Layer is a part of the [Cellular Telephony Architecture](/Reference/Core_Areas_and_APIs/Networking/Cellular_Telephony_Architecture)

The Android Telephony HAL is fairly simple; it provides a set of header files that introduce a set messages and/or functions, ie: a HAL API. The HAL API is then implemented in the shared library provided by the BSP vendor. There is still a need for some kind of kernel device driver to exist as with any Linux hardware. However, due to the way HAL is designed, the actual logic as to how a specific hardware is used can be kept as proprietary software and remains to some extent Android specific because of the HAL API.

## Radio Interface Layer : RIL

The RIL is responsible for connecting to the cellular modem via the HAL.

There is no standard for the HAL modem software interface implement and a proprietary command set is typically needed to use the full functionality of the modem. The RIL daemon provides access to a given modem, including the ones using a proprietary command set, via a fairly standard interface.

## RIL Architecture

RIL consists of three main parts located in HAL : The RIL Daemon (RILD), the vendor RIL and the libril. They all share a header file ril.h that defines the modem agnostic interface.

RILD is a relatively small and simple daemon which initializes the vendor specific RIL implementation using configuration to obtain the path to the vendor RIL device file.

Libril is a shared library linked by both RILD and the vendor RIL statically; a part of the AOSP like RILD, libril provides the RIL event mechanism and implements the communication mechanism between the application framework and vendor RIL.

The vendor RIL handles the actual communication with the modem driver and the modem specific abstraction. A simple reference implementation of a vendor RIL exists, supplied as a part of AOSP. However, the vendor RIL may be restructured as the supplier prefers and it can consist of several modules.

## Communication with the RIL

Communication between RIL and the application framework is through a socket. There are two types of commands used in RIL interaction : commands and events. The commands are originated by the application framework and include their responses. The events are indications originating from the modem. For example, the indication of incoming call is received as an event.

The data passed in a command is constructed as a Binder parcel object. (A Parcel object is a container for an IPC message used by libbinder in Android.)

In Sailfish OS the RIL is handled by oFono.
