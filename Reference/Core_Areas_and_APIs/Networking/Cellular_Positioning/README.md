---
title: Cellular Positioning
permalink: Reference/Core_Areas_and_APIs/Networking/Cellular_Positioning/
parent: Networking
grand_parent: Core Areas and APIs
layout: default
nav_order: 500
---

Cellular positioning is a part of the [Cellular Telephony Architecture](/Reference/Core_Areas_and_APIs/Networking/Cellular_Telephony_Architecture)

## Cellular Positioning

Geoclue is the component that provides location services offering a D-Bus interface for location aware applications. Geoclue supports multiple technologies and methods for finding the current location. The technology support is implemented as a provider and new providers can be added via a plugin mechanism.

### Mozilla Location Service Provider

Sailfish OS includes a Geoclue provider which uses oFono to fetch MCC, MNC, LAC, CID and SS (Mobile Country Code, Mobile Network Code, Location Area Code, Cell Id and Signal Strength) information about nearby cell towers, and uses that information along with public-domain information sourced from the [Mozilla Location Service](https://location.services.mozilla.com/downloads) to determine approximate device location. It also has an online mode whereby it can perform API requests to the Mozilla Location Service webservers, to get more accurate positioning information, by including information about nearby wireless networks.

The source code for that plugin can be found [here](https://github.com/mer-hybris/geoclue-providers-mlsdb).

### GSM Location Provider

Geoclue has a GSM cell based position provider (gsmloc) that uses oFono to fetch MCC, MNC, LAC and CID (Mobile Country Code, Mobile Network Code, Location Area Code and Cell Id) which it then matches with the data provided by the web service (http://www.opencellid.org/) via a lookup table. The web service is used to fetch the latitude and longitude of the current cell. The lookup table is used to map MCC with ISO (International Organisation for Standardization) country code, eg: MCC 244 equals ISO 3166-1 alpha-2 two letter code FI of Finland.

Currently this plugin is not included in Sailfish OS, but it may be added in the future as an alternative to the existing positioning providers.
