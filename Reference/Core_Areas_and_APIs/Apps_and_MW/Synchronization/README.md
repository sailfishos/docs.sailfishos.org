---
title: Synchronization
permalink: Reference/Core_Areas_and_APIs/Apps_and_MW/Accounts_and_SSO/Synchronization/
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



