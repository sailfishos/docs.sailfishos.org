---
title: Events View widgets
permalink: Develop/Apps/Tutorials/Events_View_Widgets/
parent: Tutorials
grand_parent: Apps
layout: default
nav_order: 375
---

The Events View is the screen you reach by swiping right from the Home screen. Besides notifications, calendar entries, and the built-in weather widget, Sailfish OS can load **third-party Events View widgets** supplied by installed applications.

This tutorial explains how to register such a widget without replacing system QML files (for example the stock weather banner). The approach described here is based on packaging a small QML component plus a JSON descriptor into your application's RPM.

> **Note:** Third-party Events View widgets are not yet documented as a supported public API. The registration format described below was reverse-engineered from platform packages and validated with a working Harbour app ([Helmsman](https://github.com/Pauligrinder/HomeAssistant)). It may change between Sailfish OS releases.

## How it fits together

Lipstick loads Events View widgets from JSON files installed under:

```
/usr/share/lipstick/eventswidgets/
```

Each JSON file describes one or more widgets and points to a QML file on disk. The QML file is loaded **inside the Lipstick process**, not inside your application process. That has two important consequences:

1. Your widget cannot use application-private QML types (for example a custom `image://` provider registered by your app).
2. If the widget needs live data from your app, use D-Bus (or another IPC mechanism) and keep the app running in the background.

The recommended pattern is therefore:

- Ship a standalone widget QML file in your application data directory.
- Ship a JSON registration file in `/usr/share/lipstick/eventswidgets/`.
- Expose a small D-Bus API from your running application for reads and actions.

Do **not** override files from `lipstick-jolla-home-qt5` or `Sailfish/Weather` in `/usr/share/lipstick-jolla-home-qt5/`. That approach is fragile across OS updates. Register your own widget under a unique name instead.

## Registration JSON

Create one JSON file per application. The file name should match your package name, for example `harbour-myapp.json`.

Install it to:

```
/usr/share/lipstick/eventswidgets/harbour-myapp.json
```

A minimal descriptor looks like this:

```json
{
    "widgets": [
        {
            "title": "My App",
            "icon": "/usr/share/icons/hicolor/86x86/apps/harbour-myapp.png",
            "order": 3,
            "path": "/usr/share/harbour-myapp/eventsview/MyEventsWidget.qml",
            "default_enabled": true,
            "available_path": "/usr/share/harbour-myapp/eventsview/MyEventsWidget.qml"
        }
    ]
}
```

| Field | Purpose |
| --- | --- |
| `title` | Name shown in Events View settings and above the widget |
| `icon` | Path to a 86×86 application icon used in settings |
| `order` | Sort order relative to other widgets (lower numbers appear earlier) |
| `path` | Absolute path to the QML file Lipstick should load |
| `available_path` | Path checked to decide whether the widget is available (usually the same as `path`) |
| `default_enabled` | When `true`, the widget is enabled after installation until the user changes it |

After installing or upgrading the RPM, open **Settings → Events view** and confirm your widget appears in the list. A Lipstick restart may be required on some releases:

```nosh
systemctl --user restart lipstick
```

## Widget QML

Place the widget QML in your application data directory, for example:

```
/usr/share/harbour-myapp/eventsview/MyEventsWidget.qml
```

The Events View loader sets the widget width and derives its height from `implicitHeight`. Your root item must therefore report a correct implicit height for its content.

A minimal skeleton:

```qml
import QtQuick 2.6
import Sailfish.Silica 1.0

Item {
    id: root

    width: parent ? parent.width : Screen.width
    implicitWidth: width
    implicitHeight: column.height
    height: implicitHeight

    // Lipstick sets visibility; treat visible && on Events View as "active".
    property bool active: visible

    // Optional: collapse long content behind a "Show more" row.
    property bool expanded: false

    function refresh() {
        // Fetch or reload widget data.
    }

    function reload() {
        refresh()
    }

    function save() {
        // No-op is fine if the widget has no settings to persist.
    }

    Component.onCompleted: if (active) refresh()
    onActiveChanged: if (active) refresh()

    Column {
        id: column
        width: parent.width
        spacing: Theme.paddingSmall

        Label {
            x: Theme.horizontalPageMargin
            width: parent.width - 2 * x
            text: "My App"
            color: Theme.highlightColor
            font.pixelSize: Theme.fontSizeMedium
            font.family: Theme.fontFamilyHeading
        }
    }
}
```

Practical guidelines:

- **Only work while active.** Poll timers, D-Bus signal subscriptions, and network requests should run when `active` is `true` and stop when the user leaves the Events View.
- **Use Silica theming.** Read colours and spacing from `Theme` so the widget matches the active ambience.
- **Use file paths for images.** `Image { source: "file:///path/to/icon.png" }` works; `image://` providers registered by your app do not.
- **Keep the root lightweight.** Heavy logic belongs in your application process, exposed over D-Bus.

## Talking to your application over D-Bus

Because the widget QML runs in Lipstick, use [Nemo.DBus](https://sailfishos.org/develop/docs/nemo-qml-plugin-dbus/) from the widget and register a D-Bus service from your application.

In C++, export a scriptable object on the session bus:

```cpp
Q_CLASSINFO("D-Bus Interface", "com.example.myapp.Widget")
// ...
bool ok = QDBusConnection::sessionBus().registerService("com.example.myapp");
ok = ok && QDBusConnection::sessionBus().registerObject(
    "/widget", this,
    QDBusConnection::ExportScriptableSlots
    | QDBusConnection::ExportScriptableSignals);
```

From the widget QML:

```qml
import Nemo.DBus 2.0

DBusInterface {
    id: widgetIface
    service: "com.example.myapp"
    path: "/widget"
    iface: "com.example.myapp.Widget"
    signalsEnabled: root.active

    function dataChanged() {
        root.refresh()
    }
}
```

Design the D-Bus surface to be small and stable: a method that returns JSON or a QVariantList for display, methods for user actions, and a change signal. Avoid blocking calls on the QML thread.

## Packaging

### qmake

Add the widget files to `DISTFILES`, then install them with `INSTALLS`:

```qmake
DISTFILES += \
    eventsview/MyEventsWidget.qml \
    eventsview/harbour-myapp.json

eventsWidgetQml.files = eventsview/MyEventsWidget.qml
eventsWidgetQml.path = /usr/share/harbour-myapp/eventsview

eventsWidgetJson.files = eventsview/harbour-myapp.json
eventsWidgetJson.path = /usr/share/lipstick/eventswidgets

INSTALLS += eventsWidgetQml eventsWidgetJson
```

### RPM spec

List the JSON file in `%files` so the package owns it:

```spec
%files
%{_datadir}/lipstick/eventswidgets/%{name}.json
```

The QML file is installed under `%{_datadir}/%{name}/eventsview/` by qmake.

Rebuild and install the RPM on a device, then verify:

```nosh
rpm -ql harbour-myapp | grep -E 'eventsview|eventswidgets'
```

## Complete example

[Helmsman](https://github.com/Pauligrinder/HomeAssistant) (a Home Assistant client) ships an Events View widget for selected lights:

- Registration JSON: `app/eventsview/harbour-helmsman.json`
- Widget QML: `app/eventsview/HelmsmanEventsWidget.qml`
- D-Bus backend: `app/src/widgetcoordinator.{h,cpp}`

The widget polls only while the Events View is visible, renders MDI icons from files written by the app (because Lipstick cannot use the app's image provider), and calls D-Bus methods to toggle lights and adjust brightness.

## Related documentation

- [Lipstick](/Reference/Core_Areas_and_APIs/Apps_and_MW/Lipstick/) — home screen, Events View, and notifications
- [Application covers](/Develop/Apps/Code_Walkthrough/) — a different integration point for backgrounded apps
- [DBus API](/Develop/Apps#dbus-api) — Nemo.DBus plugin used from widget QML
- [Packaging Apps](/Develop/Apps/Packaging/) — RPM packaging basics
