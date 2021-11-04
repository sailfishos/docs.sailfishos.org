---
title: Telepathy Framework
permalink: Reference/Core_Areas_and_APIs/Networking/Telepathy_Framework/
parent: Networking
grand_parent: Core Areas and APIs
layout: default
nav_order: 900
---

[Telepathy Framework](/Reference/Core_Areas_and_APIs/Networking/Telepathy_Framework) is a part of the [Cellular Telephony Architecture](/Reference/Core_Areas_and_APIs/Networking/Cellular_Telephony_Architecture)

The cellular Telepathy implementation consists of Telepathy-glib, Telepathy-qt, Telepathy-mission-control and Telepathy-ring.

The figure below gives an overview of the Telepathy framework.

Telepathy is a modular communications service provider with a unified application protocol interface. Each supported protocol and each client for each protocol is implemented as their own processes. The framework consists of several modules used by Telepathy clients: Connection managers, account managers, channel dispatchers.

Looking at the roles of the modules:

  - The connection managers implement the Telepathy support for the desired protocol and provide an interface for clients.
  - The account manager stores the Telepathy accounts and their parameters. It establishes the connection to account based on the account parameters or if requested by using the associated connection manager.
  - The channel dispatcher transmits the relevant type channels on the connections created by the account manager.

The channel types supported by Telepathy-qt and Telepathy-glib are configured at build time to include:

  - Call
  - Contact List
  - Contact Search
  - DBus Tube
  - File Transfer
  - Room List
  - Server Authentication
  - Server TLS Connection
  - Stream_Tube
  - Streamed Media
  - Text
  - Tubes

Note that Telepathy is technically defined as a set of D-Bus API specifications so there is no single or reference Telepathy implementation; different implementations exist for various high-level language bindings such as Telepathy-glib or Telepathy-qt and there are variations in implementation that can cause some interoperability issues.

## Telepathy-glib

Telepathy-glib is a library for the Telepathy components using GLib (a utility library for software written in C). It provides high-level Telepathy GLib bindings for clients and service providers implemented using the C-language.

One of the design decisions in this impelentations is that the Telepathy-glib design stops the connection manager effectively whenever no connection exists. Therefore, for the connection manager to remain active, it needs to remain in a connected state. In the case of Telepathy-ring, this is cumbersome because a modem connection through oFono may come and go, especially in the case where USB modems are used. Thus, the Telepathy-ring must always remain in a connected state even when no modem connection exists.

## Telepathy-qt

Telepathy-qt is a library for Telepathy components using the Qt framework. It provides Telepathy Qt bindings for clients and service providers implemented with Qt C++.

## Telepathy-mission-control

Telepathy-mission-control handles accounts. When it starts, it loads or creates accounts with each account having a protocol manager associated. The account parameters are stored by Telepathy-mission-control. Using the parameters it brings the account online by communicating with the associated protocol manager, for example with Telepathy-ring. Telepathy-mission-control acts as a channel dispatcher, which dispatches incoming and outgoing communication channels to the relevant applications. Telepathy-mission-control uses Telepathy-glib to provide Telepathy bindings.

## Telepathy-ring

Telepathy-ring is a Telepathy cellular protocol manager handling an SMS and a cellular voice call. Telepathy-ring provides support for a call (for making cellular voice calls), an SMS (for sending, receiving, and manipulating spooled SMS messages) and SIM (Subscriber Identity Module) services (for accessing some SIM information).

Telepathy-ring consists of three main parts: The Telepathy-mission-control plugin, the modem (ie the oFono interface), and the connection manager itself. Telepathy-ring uses Telepathy-glib to provide Telepathy bindings. Telepathy-ring’s Telepathy-mission-control plugin sets the relevant properties and provides the relevant functionality for Telepathy-mission-control to act as a Telepathy-ring account manager. For example, Telepathy-ring’s Telepathy-mission-control plugin sets the “ConnectAutomatically” property as “true” and because of that Telepathy-mission-control will try to connect, ie: to start Telepathy-ring whenever the “ConnectionStatus” property is disconnected.
