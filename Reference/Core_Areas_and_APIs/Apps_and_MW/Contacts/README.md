---
title: Contacts
permalink: Reference/Core_Areas_and_APIs/Apps_and_MW/Contacts/
parent: Apps and MW
grand_parent: Core Areas and APIs
layout: default
---

## Contacts

Sailfish OS provides features to store and manage contact data, synchronize with online contact storage services, and transfer contacts between devices.

Contact information is highly personal and confidential. Sailfish OS is designed so that contact data from different sources are separated at the database level, with strict synchronization policies to ensure user privacy.

### API

The contacts stack in Sailfish OS includes several API components. All of the native API components are fully open-source.

#### Platform API

Sailfish OS uses the QtPIM QtContacts API as its platform API. The Qt Project has not officially released Qt Contacts as a module within Qt, as it is still in development phase. As such, it is not offered as an available API for native application developers at this point in time. This will change in the future, once Sailfish OS is able to upgrade to a later version of Qt.

The latest upstream version of the QtPIM API can be found at: <http://code.qt.io/cgit/qt/qtpim.git/>

#### UI Layer API

Various shortcomings in the QML bindings within the QtPIM API means that another API is needed by Sailfish OS at the presentation layer, and so one was developed. Some other API enhancements (including data cache, localisation and internationalisation enablers, and other utility capabilities) are also included. This API is not available for third-party developers, and eventually most of the functionality should be upstreamed into the QtPIM API where appropriate (although some is platform-specific and will always be separate).

These APIs can be found at: <https://github.com/sailfishos/nemo-qml-plugin-contacts> and <https://github.com/sailfishos/libcontacts> Note: the separation between these two projects is historical and artificial. They should be combined into a single repository.

Some components of the Sailfish OS contacts API, such as the Contacts Browser page, are not open source software. They are distributed in the sailfish-components-contacts-qt5 package.

#### Android Compatibility

Contact data is shared with Android applications which have been approved by the user, via a device-local bridge database. Contact data is synchronized with that bridge database periodically. Some contact data from the native contacts database may not be synchronized to the bridge database (if, for example, the terms and conditions of the service from which the data originated prohibit that). Contact data which is synchronized to the bridge database is available to Android applications which have been granted permission to access via the normal Android APIs.

### Storage And Middleware

Sailfish OS includes a variety of middleware pieces related to the contacts domain, and specific storage and synchronization implementations for the platform.

#### Storage Backend

The data storage backend used by Sailfish OS is an implementation of the QtPIM QContactManagerEngine interface, using sqlite3 as its storage database. It also provides various extensions to the QtPIM API specifically to enable synchronization.

The implementation of this backend can be found at: <https://github.com/sailfishos/qtcontacts-sqlite> Note that various improvements to the backend are planned for when Sailfish OS upgrades to the latest version of the QtPIM API, including better support for separated addressbook collections.

#### Synchronization

As with other data-related domains, synchronization of contact data is controlled by Buteo (the synchronization framework used in SailfishOS). Synchronization with a variety of data sources is supported through a number of data-source-specific synchronization plugins. Each plugin is independent, although many of them share significant amounts of code to ease maintenance.

The Jolla forks of the Buteo core libraries are:

  - [buteo-syncfw](https://github.com/sailfishos/buteo-syncfw)
  - [buteo-syncml](https://github.com/sailfishos/buteo-syncml)
  - [buteo-mtp](https://github.com/sailfishos/buteo-mtp)

The various synchronization plugins are listed below:

  - CardDAV: <https://github.com/sailfishos/buteo-sync-plugin-carddav>
  - Google: <https://github.com/sailfishos/buteo-sync-plugins-social/tree/master/src/google/google-contacts>
  - VKontakte: <https://github.com/sailfishos/buteo-sync-plugins-social/tree/master/src/vk/vk-contacts>
  - Telepathy/IM: <https://github.com/sailfishos/contactsd>
  - SyncML (over Bluetooth or HTTP): <https://github.com/sailfishos/buteo-sync-plugins/tree/master/clientplugins/syncmlclient>
  - Proprietary synchronization plugins (e.g. for Microsoft Exchange ActiveSync) also exist but are not open-source.

### Contribution

Community or third-party contributions to various components of the location and positioning stack in Sailfish OS is encouraged and appreciated. The vast majority of the components are open-source, found on <https://github.com/sailfishos>, with discussions via IRC (#sailfishos via oftc.net) and via email.

Some ideas for ways to contribute include:

  - test accounts / servers for testing CardDAV synchronization
  - test robots to perform smoke testing for synchronization plugins
  - test data for specification conformance, for all synchronization plugins
  - complete unit tests for synchronization plugin behaviour correctness (C++ proficiency required)
  - performance improvements (algorithm or datastructure knowledge and C++ proficiency required)
  - storage backend improvements (including helping with the implementation of the new features required in the latest version of the QtPIM API)
  - documentation improvements

For in-depth information about contributing to the CardDAV synchronisation plugin, please see [CalDAV and CardDAV Community Contributions](/Develop/Collaborate/CalDAV_and_CardDAV_Community_Contributions).
