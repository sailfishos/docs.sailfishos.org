---
title: Calendar
permalink: Reference/Core_Areas_and_APIs/Apps_and_MW/Calendar/
parent: Apps and MW
grand_parent: Core Areas and APIs
layout: default
---

## Calendar

The Calendar system in Sailfish OS allows users to view, create, and share calendar events, and to schedule reminders for various events. Event information from a variety of sources is separated in the database into distinct calendar collections.

### API

The Calendar stack in Sailfish OS includes several API components. All of the native API components are fully open-source.

#### Platform API

Sailfish OS uses the [KCalendarCore](https://invent.kde.org/frameworks/kcalendarcore) API. It is a well-maintained KDE API that provides access to calendar information like events, to-dos, journals, alarms, ... It is also providing serialisation and deserialisation to iCalendar format through [libical](https://github.com/libical/libical). On top of it, mKCal is responsible for storage of calendar data on device. Sailfish OS is currently the defacto upstream for mKCal, which was previously open-sourced by Nokia.

The KCalendarCore repository can be found at: <https://github.com/sailfishos/kf5-calendarcore>

The mKCal repository can be found at: <https://github.com/sailfishos/mkcal>

#### UI Layer API

A set of QML bindings for the platform API have been written to allow calendar and event information to be accessed and modified in QtQuick applications on Sailfish OS. These APIs have been developed specifically for Sailfish OS and the Nemo Mobile project, and are fully open-source. The repository also includes tools to inspect, import, and export calendar event information.

The nemo-qml-plugin-calendar repository can be found at: <https://github.com/sailfishos/nemo-qml-plugin-calendar>

#### Android Compatibility

Calendar data is shared with Android applications which have been allowed the appropriate permissions by the user, via a device-local bridge database. Android applications can access that information via the normal Android APIs once they have been granted permission by the user.

### Storage And Middleware

Sailfish OS includes a variety of middleware pieces related to the calendar domain, and specific storage and synchronization implementations exist for the platform.

#### Storage Backend

The mKCal platform API also includes an sqlite-based storage backend.

#### Synchronization

As with other data-related domains, synchronization of calendar data is controlled by Buteo (the synchronization framework used in Sailfish OS). Synchronization with a variety of data sources is supported through a number of data-source-specific synchronization plugins. Each plugin is independent, although many of them share significant amounts of code to ease maintenance.

The various synchronization plugins are listed below:

  - CalDAV: <https://github.com/sailfishos/buteo-sync-plugin-caldav>
  - Google: <https://github.com/sailfishos/buteo-sync-plugins-social/tree/master/src/google/google-calendars>
  - Facebook: <https://github.com/sailfishos/buteo-sync-plugins-social/tree/master/src/facebook/facebook-calendars>
  - VKontakte: <https://github.com/sailfishos/buteo-sync-plugins-social/tree/master/src/vk/vk-calendars>
  - SyncML (over Bluetooth or HTTP): <https://github.com/sailfishos/buteo-sync-plugins/tree/master/clientplugins/syncmlclient>
  - Proprietary synchronization plugins (e.g. for Microsoft Exchange ActiveSync) also exist but are not open-source.

### Contribution

Community or third-party contributions to various components of the calendar stack in Sailfish OS is encouraged and appreciated. The vast majority of the components are open-source, found on <https://github.com/sailfishos>, with discussions via IRC (#sailfishos via oftc.net) and via the forum.

Specifically, contributions would be very welcome in the following areas:

  - unit test improvements both for the current platform API and mKCal storage backend, and for synchronization plugins
  - test accounts on CalDAV instances
  - test robots to perform smoke testing for synchronization plugins

For in-depth information about contributing to the CalDAV synchronisation plugin, please see [CalDAV and CardDAV Community Contributions](/Develop/Collaborate/CalDAV_and_CardDAV_Community_Contributions).
