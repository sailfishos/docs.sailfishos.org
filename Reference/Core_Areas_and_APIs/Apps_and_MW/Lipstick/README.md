---
title: Lipstick
permalink: Reference/Core_Areas_and_APIs/Apps_and_MW/Lipstick/
parent: Apps and MW
grand_parent: Core Areas and APIs
layout: default
---

The main home screen and application UI area is driven by the Lipstick subsystem. This handles:

  - Home screen and launcher
  - Primary system UI swipe navigation
  - Application windows/compositing
  - System-level windows and notifications
  - Events screen and notifications
  - Device locking
  - Ambience switching

The home screen shows essential device status information (such as battery level, active mobile connections and system time) and the App Grid along with any backgrounded apps. From the home screen, you can:

  - Swipe left or right to navigate inside Home between Home, Events and Super Apps
  - Swipe down over the top edge of the screen to view Top Menu with ambiences
  - Swipe up over the bottom edge of the screen to access App Grid with your installed apps

## Lipstick framework

The essential Lipstick architecture is implemented by the Lipstick framework in <https://github.com/sailfishos/lipstick>. Sailfish OS builds its own QML-based Lipstick UI layer on top of this with a customised look and feel, but essential operations are handled by the Lipstick library, which provides:

  - A QML-based UI entry point
  - Window compositor layer
  - App launcher framework
  - Screen lock capabilities
  - Event notification management
  - Built-in support for common UI notifications such as volume changes, battery levels and network connections
  - Start-up and shutdown screen handling

The app launcher framework provides easy access for adding and removing apps from the the launcher via a D-Bus API; see the source package for doxygen-based documentation on this API.

## Compositor

The Lipstick Compositor manages all displayed windows. It uses [Qt Wayland](https://wiki.qt.io/QtWayland) to manage displayed surfaces and includes handling for [Android™ AppSupport](/AppSupport "brokenlink") application windows. It also handles screen orientation changes and turning the display on/off.

Aside from managing ordinary application windows, the Compositor also manages the layering of special window types such as the Lock screen, system windows (such as the USB connection dialog) and alarm dialogs. It also implements the core system swipe gesture capabilities for "peeking" behind the current application window and swiping between the Home screen and other main system screens.

## Events

Events provides quick access to:

  - Date
  - Current weather and forecast
  - Notifications like received emails, messages and missed calendar alarms
  - Upcoming calendar events
  - Quick Actions and Settings Shortcuts for essential Sailfish OS functions (these are user-customisable)
  - Other extensions like Twitter tweets

Quick Actions and Settings Shortcuts are accessed by dragging downwards within the Events screen. Quick Actions provide one-click access to common functions such as setting an alarm and performing a web search, while Settings Shortcuts are settings embedded within the Events screen, that make it possible to access system settings without navigating through the Settings application. Both Quick Actions and Settings Shortcuts can be added or removed in the Settings application.

Past event notifications are automatically displayed in the Events screen, unless they have been configured otherwise.

## Event notifications

The Lipstick notifications framework allows apps to send user notifications to Lipstick in order to display them in the UI. This can range from system-level notifications about low battery levels to user space -level notifications about new emails. The notification framework implements the [Desktop Notifications Specification](https://people.gnome.org/~mccann/docs/notification-spec/notification-spec-latest.html) and receives notification information via D-Bus.

See the the <https://github.com/sailfishos/lipstick> Lipstick source package for detailed doxygen-based documentation on the notifications framework.
