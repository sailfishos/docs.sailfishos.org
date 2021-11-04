---
title: Messaging
permalink: Reference/Core_Areas_and_APIs/Apps_and_MW/Messaging/
parent: Apps and MW
grand_parent: Core Areas and APIs
layout: default
---

## Messaging

Sailfish OS includes a unified messaging framework which allows messages from a variety of sources to be sent and received using a variety of protocols and services, all from the messaging application.

### SMS and MMS

Short Messaging Service messages and Multimedia Messaging Service messages are sent and received over the telephony stack, via the [Telepathy messaging framework](/Reference/Core_Areas_and_APIs/Networking/Telepathy_Framework). More information about the telephony stack on Sailfish OS is included in the Telephony page, including links to the repositories for ofono, libqofono, libqofonoext and the Hybris-based RIL interface. Once sent or received, SMS and MMS messages are recorded in the communications history via libcommhistory. All of the SMS and MMS APIs in Sailfish OS are fully open-source.

The Telepathy Ring (GSM messaging) plugin repository can be found at: <https://github.com/sailfishos/telepathy-ring>

### IM

Instant Messaging services like Google Chat use XMPP over TCP/IP as the transport protocol. Sailfish OS supports XMPP via the [Telepathy framework](/Reference/Core_Areas_and_APIs/Networking/Telepathy_Framework), which provides support for a large number of instant messaging protocols and services. Once sent or received, IM messages are recorded in the communications history via libcommhistory. All of the IM messaging API and storage components in Sailfish OS are fully open-source.

The Telepathy Gabble (XMPP) plugin repository can be found at: <https://github.com/sailfishos/telepathy-gabble>

### Proprietary and Other Messaging

Proprietary messaging protocols, as well as other currently unsupported protocols, could be supported in Sailfish OS through either Telepathy plugins or Buteo plugins. Such plugins should interface with libcommhistoryd to ensure that communication history is retained. Contributions of such plugins for proprietary messaging protocols such as VKontakte Chat, Ricochet, Telegram, etc would be appreciated.

### Communications History

Communications events in Sailfish OS are recorded in real time by the commhistory-daemon process. These events are then made accessible to other processes in the system via the libcommhistory library. These components are fully open-source.

The commhistoryd repository can be found at: <https://github.com/sailfishos/commhistory-daemon>

The libcommhistory repository can be found at: <https://github.com/sailfishos/libcommhistory/>

Note that communications events are recorded independently from any contact information that may be present on the device at the time at which they occurred. Resolving from communications events to contacts can be automatically performed by libcommhistory, or optionally can be performed manually using the Contacts middleware described on the [Contacts page](/Reference/Core_Areas_and_APIs/Apps_and_MW/Contacts#ui-layer-api).

### UI Layer APIs

QML APIs for the messaging domain have been developed for Sailfish OS and the Nemo Mobile project. These provide models for listing, grouping and sorting messaging events, and abstractions for exchanging messages.

These APIs are fully open-source and can be found at: <https://github.com/sailfishos/libcommhistory/> and <https://github.com/sailfishos/nemo-qml-plugin-messages/>
