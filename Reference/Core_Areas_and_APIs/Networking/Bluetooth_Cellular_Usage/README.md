---
title: Bluetooth Cellular Usage
permalink: Reference/Core_Areas_and_APIs/Networking/Bluetooth_Cellular_Usage/
parent: Networking
grand_parent: Core Areas and APIs
layout: default
nav_order: 100
---

Bluetooth Cellular Usage is a part of the [Cellular Telephony Architecture](/Reference/Core_Areas_and_APIs/Networking/Cellular_Telephony_Architecture)

## Bluetooth Cellular Usage

Bluetooth wireless headsets can be used to receive and transmit audio during the voice call and for a call control. The call control can consist of accepting, rejecting or ending the call as well as making a call to the last called number. It is also possible to make a voice call in the form of voice dialling, which means using a voice recognition for a call creation.

[Bluez](https://github.com/sailfishos/bluez5#readme) uses oFono as a cellular telephony support provider. For example, when a Bluetooth device is used for initiating a voice call, Bluez sends a message to the oFono interface to make a dialling request and during the call it keeps receiving the call states. If a Bluetooth device is connected while an incoming call is received, Bluez will receive an indication of this and if the Bluetooth device is used to answer the call, Bluez tells the oFono to answer.
