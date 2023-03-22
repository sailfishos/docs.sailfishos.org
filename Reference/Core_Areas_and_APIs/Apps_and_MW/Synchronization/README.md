---
title: Synchronization
permalink: Reference/Core_Areas_and_APIs/Apps_and_MW/Synchronization/
parent: Apps and MW
grand_parent: Core Areas and APIs
layout: default
---

## Synchronization Framework

The synchronization framework used in Sailfish OS is [Buteo](https://github.com/sailfishos/buteo-syncfw). It is a generic framework for creating sync plugins that can perform sync operations across devices and cloud.

The Buteo Synchronization Framework comes with extensive documentation. You can access it by cloning and building the framework sources:
```
git clone https://github.com/sailfishos/buteo-syncfw.git
cd buteo-syncfw/
sfdk build
firefox doc/html/index.html
```

### Buteo client plugins

Buteo client plugins act as clients to services running outside of a device. They are loaded when sync is started and unloaded once the sync has been completed.

The plugins are shared libraries with the file name starting with `lib` and ending with `-client.so`. They are placed in a directory called `buteo-plugins-qt5/oopp` under the standard library directory, i.e. on a device running 64-bit Sailfish OS, `/usr/lib64/buteo-plugins-qt5/oopp`.

### Sync profiles

Buteo sync profile provides information about the synchronization service that the user has synchronized with. The profile contains dynamic information that is created when a plugin is configured, and also information that is generated after a sync has been initiated. The profiles are stored in XML format in a writable data location, as of Sailfish OS 4.5.0 `.local/share/system/privileged/msyncd/sync`. During plugin configuration, which is part of account creation, a sync profile template is copied from `/etc/buteo/profiles/sync/` 

### Client profiles

Each sync profile has a client profile as a subprofile. The client profiles consists of fields, which must have set values. The fields are defined in XML files in `/etc/buteo/profiles/client`. The actual values are defined as key/value pairs in the sync profile XML file.
