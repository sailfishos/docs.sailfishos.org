---
title: Events View widgets
permalink: Develop/Apps/Tutorials/Events_View_Widgets/
parent: Tutorials
grand_parent: Apps
layout: default
nav_order: 375
---

The Events View is the screen you reach by swiping right from the Home screen. Besides notifications, calendar entries, and the built-in weather widget, installed applications can register **third-party Events View widgets**.

This page describes how to do that by packaging a small QML component plus a JSON descriptor into your application's RPM.

## How it fits together

Lipstick loads Events View widgets from JSON files installed under:

```
/usr/share/lipstick/eventswidgets/
```

Each JSON file describes one or more widgets and points to a QML file on disk. The QML file is loaded **inside the Lipstick process**, not inside your application process. That has a few important consequences:

1. Application-private QML types are not automatically available in the widget. For example, an `image://` provider registered only inside your app process will not work unless you also expose it through a QML module import. Using `file://` paths is often the simpler approach.
2. If the widget needs live data from your app, use an IPC mechanism such as D-Bus and keep the app running when the widget is in use.
3. The widget must be stable, secure, and light on resources. It runs as part of the home screen.

The usual pattern is:

- Ship a standalone widget QML file in your application data directory.
- Ship a JSON registration file in `/usr/share/lipstick/eventswidgets/`.
- If needed, expose a small API from your running application for reads and actions. See the [DBus API](/Develop/Apps#dbus-api) documentation.

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
            "default_enabled": true
        }
    ]
}
```

| Field | Purpose |
| --- | --- |
| `title` | Name shown in Events View settings and above the widget |
| `icon` | Path to an application icon used in settings |
| `order` | Sort order relative to other widgets (lower numbers appear earlier) |
| `path` | Absolute path to the QML file Lipstick should load |
| `default_enabled` | When `true`, the widget is enabled after installation until the user changes it |

The top-level JSON object can also include `translation_id`, `description_id`, and `translation_catalog` for localized strings.

`available_path` exists for cases where the homescreen and application ship separately. It is usually not needed for third-party widgets.

After installing or upgrading the RPM, open **Settings → Events view** and confirm your widget appears in the list.

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

- **Only work while active.** Poll timers, signal subscriptions, and network requests should run when `active` is `true` and stop when the user leaves the Events View.
- **Keep the root lightweight.** Heavy logic belongs in your application process.
- **Be careful with resources.** Avoid unnecessary polling, large images, or blocking work on the QML thread.

Install the JSON and QML files with your application's normal [packaging](/Develop/Apps/Packaging/) setup. The JSON file must end up under `/usr/share/lipstick/eventswidgets/` and the QML file under your application data directory.

## Related documentation

- [Lipstick](/Reference/Core_Areas_and_APIs/Apps_and_MW/Lipstick/) — home screen, Events View, and notifications
- [Application covers](/Develop/Apps/Code_Walkthrough/) — a different integration point for backgrounded apps
- [DBus API](/Develop/Apps#dbus-api) — IPC from widget QML to your application
- [Packaging Apps](/Develop/Apps/Packaging/) — RPM packaging basics
