---
title: Alarms
permalink: Reference/Core_Areas_and_APIs/Apps_and_MW/Alarms/
parent: Apps and MW
grand_parent: Core Areas and APIs
layout: default
---

## Alarms and Reminders

Multi-modal interaction is an important paradigm for modern devices. The interface between the user and the device involves touch input, sound playback, vibration and haptics, and visual feedback (either on the screen or via LEDs). Sailfish OS includes support for hardware-triggered (watchdog timer, deep-sleep real-time-clocks) alarms and reminders which can make use of these various forms of feedback to notify the user of a scheduled event or alarm, or to initiate more complicated user-interaction.

### timed

The time daemon in Sailfish OS provides time-tracking for the system, and handles alarms and timer notifications from the hardware platform to trigger user-visible notifications and non-graphical-feedback. The code for this component is fully open-source and available at <https://github.com/sailfishos/timed> under a permissive license.

Internally, timed can use a variety of clocks (including hardware real-time clocks, network time protocol packets from data networks, and NITZ packets from cellular service providers) to synchronise and trigger events. Heartbeat timers can be defined to wake the system from deeper sleep modes periodically in order to send and receive network data in a coalesced fashion to avoid constant wakeups which are battery-hungry.

### ngfd

The non-graphical-feedback daemon in Sailfish OS provides capability and API for the system (and permitted applications) to trigger various multi-modal user notifications. The code for this component is fully open-source and available at <https://github.com/sailfishos/ngfd> under a permissive license. This same component is useful not only for alarms and reminders, but also for notifications and a variety of other cases where non-graphical-feedback is desired.

The ngfd defines a plugin system whereby different providers of non-graphical-feedback may be registered with the daemon. Some examples of such plugins can be found at <https://github.com/mer-hybris/ngfd-plugin-droid-vibrator> and <https://github.com/sailfishos/ngfd-plugin-pulse>

### Clock Alarms

One common use-case on mobile devices is user-defined alarms which trigger at a particular time, e.g. an alarm clock or egg timer. These alarm types are supported by timed as events, and specific actions can be defined for those events (including notifications, visual and non-visual feedback, and user interaction).

### Calendar Reminders

The calendar backend in Sailfish OS also ensures that reminders for calendar events are implemented via timed events. Similarly to clock alarms, these events can have a variety of different feedback and interaction actions associated with them.
