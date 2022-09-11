---
title: Email
permalink: Reference/Core_Areas_and_APIs/Apps_and_MW/Email/
parent: Apps and MW
grand_parent: Core Areas and APIs
layout: default
---

## E-mail

Sailfish OS supports a number of email communication protocols and services. These include:

  - SMTP, POP3 and IMAP access
  - Microsoft Exchange ActiveSync access
  - Scheduling of email synchronization through the Buteo synchronization framework
  - All emails, text/plain and text/html, rendered with [Sailfish WebView](https://github.com/sailfishos/sailfish-components-webview/)

Email features are primarily implemented by the following packages:

  - [messagingframework](https://github.com/sailfishos/messagingframework) - Jolla fork of Qt Messaging Framework (QMF)
  - [nemo-qml-plugin-email](https://github.com/sailfishos/nemo-qml-plugin-email) - QML plugin for QMF
  - [buteo-sync-plugins-email](https://github.com/sailfishos/buteo-sync-plugins-email) - Buteo plugin for scheduling email synchronization
  - Other internal packages for the Jolla Mail app and Microsoft Exchange services

### Platform Service - QMF

The platform e-mail service on Sailfish OS is the QtMessagingFramework (QMF), a fully open-source email messaging service which supports SMTP, POP3, and IMAP. Account plugins to QMF allow account information and credentials from a variety of sources to be used, including the Accounts&SSO service on Sailfish OS. There are a variety of other plugins for QMF which provide functionality like system notifications for new messages, on Sailfish OS.

The QMF message server process can be easily extended with additional plugins for other message protocols. Messages sent and received via QMF are recorded to an SQLite database, and the framework provides models for accessing the emails stored on the device, and for constructing new messages.

The QMF repository can be found at: <https://github.com/sailfishos/messagingframework>

The QMF system notifications plugin can be found at: <https://github.com/sailfishos/qmf-notifications-plugin>
