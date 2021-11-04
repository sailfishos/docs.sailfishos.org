---
title: Cellular Modem Abstraction
permalink: Reference/Core_Areas_and_APIs/Networking/Cellular_Modem_Abstraction/
parent: Networking
grand_parent: Core Areas and APIs
layout: default
nav_order: 300
---

Cellular Modem Abstraction is a part of the [Cellular Telephony Architecture](/Reference/Core_Areas_and_APIs/Networking/Cellular_Telephony_Architecture)

## oFono

OFono is a daemon that essentially provides a modem adaptation with a modem independent D-Bus interface for the telephony application development. The aim of the oFono software project is to offer a 3GPP GSM/UMTS (Global System for Mobile communications / Universal Mobile Telecommunications System) standard compliant software framework. Note that oFono explicitly does not support all the GSM features, most notably the SIM phonebook writing. The compliancy includes such items as the decoding and de-fragmentation of an SMS message. The Sailfish OS has its own fork of oFono that has added support to that of upstream project. There is added support for features such as Network Identity and Time Zone (NITZ) indication support and some added SMS handling to enable MMS support in the Sailfish OS platform as well as some other platform specific fixes.

## libqofono

The libqofono package provides both a library for accessing the oFono daemon and a plugin to allow QML applications to access oFono using the Qt Quick module. Libqofono is basically just a Qt wrapper of oFono.

Note that although QML UI applications can use Libqofono to communicate with oFono, this can be problematic in some cases. The first reason is that typically the QML UI application is closed when the end-user exits the application, hence the application stops receiving indications and replies to requests it has made. The second reason is the behaviour of the oFono interface. For example, if the application makes a request to start the network scan and is restarted while the scan is still in progress, it cannot in some cases know that the scan is still in progress. Calling the oFono “NetworkRegistration” D-Bus interface methods “Scan” or “Register”, or the “NetworkOperator” interface method “Register”, while the “Scan” is still in progress, will return with an error “InProgress”. So although it is the “Scan” that is still in progress, it cannot be distinguished from the “NetworkRegistration” interface method call “Register”.

## oFono Details

oFono has four main components, the core daemon, the atoms, the drivers, and the plugins.

The oFono core provides the internal interface that the plugins and the drivers must implement, thus enabling the common D-BUS API to exist. It also loads the plugins and drivers. The core manages each connected device independently providing support for multiple modems and multiple SIM cards to be present at the same time. Besides these core functionalities, it also provides common utility functions for reading and writing the SIM card and interpreting the contents of the SIM low-level Element File contents. There are also utility functions for decoding, encoding and fragmentation of binary SMS protocol data units as well as functions for decoding, duplicate detection and pagination of cell broadcasts and character set conversion. The core also provides functions for detection of and communication between oFono atoms.

oFono atoms are an integral part of the core. The oFono atom is more a concept rather than an actual module as there are no separate libraries, folders or files for atoms. There is an atom for each main telephony/modem feature such as SMS, CBS (Cell Broadcast Service) and SIM but they can represent other things too. It is the atoms that provide the oFono D-Bus interface. To simplify, each oFono driver is linked to an atom and an atom is attached to a modem. The atoms detect each other and communicate between themselves using the information provided by other atoms for their own needs. For example, the GPRS (General Packet Radio Service) atom requests the Network Registration atom to notify about changes in the network registration status.

The oFono drivers provide a means to integrate multiple device technologies. Drivers handle the adaptation of a specific protocols. They translate generic oFono requests, such as a dial request, to a protocol specific request and forward the request to the correct device. For example, in an AT command based modem a voice call dial request to a number 1234567 is translated to a command "ATD1234567;". This way the oFono can support multiple types of devices based on a variety of communication protocols. The upstream oFono has support for multiple modems using the AT command set, and it includes an ISI protocol based driver and a Qualcomm QMI modem driver. The oFono plugins make it possible for developers to tailor oFono for their purposes. The main purpose of the plugins is to provide a means to recognize the available modem or modems and enable the use of them by loading the correct communication protocol, atoms and drivers. Besides these, a plugin can be made to either provide optional interface support, such as network time support, or simply extend the existing functionality, such as provisioning the GPRS context.

Another helpful way to describe the architecture or structure of oFono is to divide it into five areas as shown below: Core, plugins, a common modem and a protocol independent D-Bus interface, a modem or vendor specific drivers, and a protocol specific communication layer.

Figure: OFono overview

In this division the core is considered the same as the previously explained one but the concept of atoms is considered as being part of it. The D-Bus interface is implemented within the core or into a plugin but is considered as a separate entity. The drivers and the plugins are also as explained earlier but the biggest difference is to consider the communication layer and the drivers as separate entities.

The communication layer takes care of the message scheduling and the queue mechanism and provides a protocol specific communication channel. The idea behind this division is that there can be several modems with their own command set needing their own driver implementations but which can use the same communication layer implementation.

The Sailfish OS project has modified and added features to their fork of oFono. These include an enhanced GPRS context provisioning, a signalling of the changed operator list, an interface for sending arrays of raw bytes to the modem, a signalling of received SMS message status reports and support for forwarding WAP push messages to Mms-engine as well as support for a ringback tone and network time (NITZ). However, the main addition is the Android RIL support. This means that if the system can utilize the Android binaries, the oFono can use the Android RIL to communicate with the modem. The Sailfish OS oFono RIL support was initially based on the one provided by Canonical. but has since diverged from that version. The RIL support consists of drivers providing RIL interface support; a communication layer enabling the socket communication with the RIL daemon; and a set of plugins for recognizing the existence of the RIL daemon, loading the related drivers and starting the communication using the communication layer.
