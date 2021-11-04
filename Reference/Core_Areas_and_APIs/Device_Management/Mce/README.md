---
title: Mce
permalink: Reference/Core_Areas_and_APIs/Device_Management/Mce/
parent: Device Management
grand_parent: Core Areas and APIs
layout: default
---

Source code: [dashboard entry](http://www.merproject.org/dash/repo/merproject.org/mer-core/mce.html)

MCE stands for Mode Control Entity - it's a daemon that monitors and handles various global modes or states including some sensor and touch input.

Specifically:

  - Touch / tap
  - Power buttons
  - Power state (hibernate etc)
  - Memory

## General Notifications

## OOM Handling

While process specific warnings about oom killer activity are not available, the MCE daemon tracks (absolute) system memory pressure via the memnotify kernel interface. Device specific configuration is used to map that in to 3 logical levels ("normal", "warning", "critical" - or "unknown" in case memnotify support / configuration is not present). On warning level non-essential resources should be released, and on critical level oom killing of some processes can be expected.

These logical levels are exposed on D-Bus system bus. The interface is introspectable and can thus be used for example via nemo-qml-plugin-dbus / inspected via qdbus utility:
```nosh
% /usr/lib/qt5/bin/qdbus --system com.nokia.mce /com/nokia/mce/request|grep memo
method QString com.nokia.mce.request.get_memory_level()
% /usr/lib/qt5/bin/qdbus --system com.nokia.mce /com/nokia/mce/signal|grep memo
signal void com.nokia.mce.signal.sig_memory_level_ind(QString memory_level)
```

As an example, the current state can be queried from command line via:
```nosh
% dbus-send --system --type=method_call --print-reply --dest=com.nokia.mce /com/nokia/mce/request com.nokia.mce.request.get_memory_level
```

And tracked via:
```nosh
% dbus-monitor --system sender=com.nokia.mce,interface=com.nokia.mce.signal,member=sig_memory_level_ind
```
