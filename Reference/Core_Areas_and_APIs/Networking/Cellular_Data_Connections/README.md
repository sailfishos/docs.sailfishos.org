---
title: Cellular Data Connections
permalink: Reference/Core_Areas_and_APIs/Networking/Cellular_Data_Connections/
parent: Networking
grand_parent: Core Areas and APIs
layout: default
nav_order: 200
---

Cellular Data Connections is a part of the [Cellular Telephony Architecture](/Reference/Core_Areas_and_APIs/Networking/Cellular_Telephony_Architecture)

## Cellular Data Connections

ConnMan is the main daemon managing network connections from multiple technologies, both wired and wireless, (such as WiFi, Bluetooth, USB and Cellular) used in mobile devices. It offers a high-level D-Bus API for use by networking applications.

It supports different technologies through a plugin design similar to oFono's. This modular design makes ConnMan extendable, ie: support for new connection technologies can be added. Besides new technologies, extensions for various services can also be implemented as plugins, such as configuration methods like DHCP (Dynamic Host Communication Protocol) and domain name resolution.

The desired plugins can be enabled/disabled and configured at runtime using a configuration file. The file can, for example, define the preference order of technologies and a list of network interfaces that will not be handled by ConnMan.

ConnMan plugins are also configured at compile time and using a build-time configuration and options, amongst which is the possibility to exclude built-in plugins, such as WiFi.

ConnMan uses oFono as a cellular technology provider and ConnMan’s oFono support is, naturally, implemented by an oFono plugin. ConnMan tracks the oFono daemon as it starts, stops and restarts.

Libconnman-qt consists of two libraries that provide access to the Connman D-Bus interfaces as Qt bindings and a plugin for QML applications. These bindings are a direct reflection of the interfaces provided by Connman.

Nemo-qml-plugin-connectivity is a dynamically loadable custom QML extension plugin for QML networking/connectivity applications using TCP/IP (Transmission Control Protocol / Internet Protocol). It uses Libconnman-qt for communicating with ConnMan to provide the required services.

The main purpose of ConnectionAgent is to provide a daemon and a plugin library for QML applications to access ConnMan’s Agent interface, ie: “net.connman.Agent”, using the UserAgent class provided by the Libconnman-qt library. ConnectionAgent also provides support for the ConnMan “autoconnect” feature to turn the connection/networking technology power on if the corresponding ConnMan service has “autoconnect” set to as “True”.

Provisioning-service is used for Over the Air (OTA) provisioning, ie: using the operator provided data coming as a push message to initialise oFono Internet data and MMS (Multimedia Messaging Service) data contexts. The data is first received by oFono, which recognizes it as a push message and forwards it to the Provisioning-service to be further processed. Based on the received data, the Provisioning-service then initializes the oFono data and MMS contexts. After processing the data, the Provisioning-service emits a signal expressing the result (“apnProvisioningSucceeded”, “apnProvisioningPartiallySucceeded”, “apnProvisioningFailed”). It is not mandatory to include the Provisioning-service into an operating system. It only automates the provisioning of the MMS and Internet connections. In a mobile phone using Sailfish OS Core, the same data can be provided by the end-user through the UI application.
