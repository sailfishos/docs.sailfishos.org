---
title: Positioning
permalink: Reference/Core_Areas_and_APIs/Apps_and_MW/Positioning/
parent: Apps and MW
grand_parent: Core Areas and APIs
layout: default
---

## Location and Positioning

Sailfish OS utilises the GeoClue framework for positioning, and clients can use the QtPositioning APIs to receive position and satellite information updates, and the QtLocation APIs to access location services (such as querying nearby points of interest, accessing map tiles, and calculating navigation routes between two positions).

Position information is highly confidential, and Sailfish OS supports a policy framework which allows the user to lock the GPS positioning capability.

### API

The location and positioning stack in Sailfish OS includes several API components. All of the native API components are fully open-source.

#### Platform API

Sailfish OS uses the QtPositioning and QtLocation APIs as its platform API, utilising the GeoClue backend for positioning. The latest upstream version of the QtLocation API can be found at: <http://code.qt.io/cgit/qt/qtlocation.git/>

There are some Sailfish OS-specific GeoClue provider plugins which provide position and satellite updates to clients, and also a plugin to connman which allows the GPS technology power state to be controlled by clients using the connman API (whose internal implementation makes DBus calls to the primary GeoClue provider plugin).

The code related to the location and positioning stack can be found in the following repositories:

  - geoclue-provider-hybris, the main GeoClue provider plugin, using libhybris interfaces to control the GPS: <https://github.com/mer-hybris/geoclue-providers-hybris>
  - geoclue-provider-mlsdb, a secondary GeoClue provider plugin, using Mozilla Location Service to provide assisted-GPS position updates: <https://github.com/mer-hybris/geoclue-providers-mlsdb>
  - connman-plugin-jollagps, exposing GPS power state to connman: <https://github.com/sailfishos/connman/blob/master/connman/plugins/jolla-gps.c>
  - Proprietary positioning plugins (e.g. for HERE) also exist but are not open-source.

#### Android Compatibility

Position data is shared with Android applications which have been approved by the user, via a bridge service. This includes position updates as reported by the device GPS if turned on, and also information about satellites which are being used by the GPS.

### Contribution

Community or third-party contributions to various components of the location and positioning stack in Sailfish OS is encouraged and appreciated. The vast majority of the components are open-source, found on <https://github.com/sailfishos>, with discussions via IRC (#sailfishos via oftc.net) and via email.
