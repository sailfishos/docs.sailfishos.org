---
title: Launchers
permalink: Reference/Core_Areas_and_APIs/Apps_and_MW/Lipstick/Launchers/
parent: Lipstick
grand_parent: Apps and MW
layout: default
---

Launchers are defined with files in _/usr/share/applications_ following [Desktop Entry
Specification](https://specifications.freedesktop.org/desktop-entry-spec/desktop-entry-spec-latest.html).
They are read by [Lipstick](/Reference/Core_Areas_and_APIs/Apps_and_MW/Lipstick/) and
[Sailjail](https://github.com/sailfishos/sailjail) components.

## Sailfish OS specific additions
Desktop Entry Specification allows extending the specification with product specific keys. Sailfish
OS uses that to specify some extensions to support certain functions better.

### Launcher and Booster Type
_X-Nemo-Application-Type_, and _X-Nemo-Single-Instance_ can be used instead
of giving the the `--single-instance`, and `--type` options to invoker in the
_Exec_ key.  
Note however that _X-Nemo-Application-Type_ will have no effect for sandboxed
apps, which will always be treated as _generic_.

See the documentation for SailJail, Invoker, and the
[Harbour FAQ](https://harbour.jolla.com/faq#.desktop-Files) for more.

### Hiding app from launcher grid
To hide an desktop entry form the Launcher Grid, use _NoDisplay=true_.
This is mainly useful for registering a MIME Type launchers.

In case of multi-platform apps sharing the same .desktop file, app developers
can use _NotShowIn=X-MeeGo_, to hide the launcher only in Sailfish OS.

### Localization
In addition to the _Name[xx]_ method from the Desktop spec, launcher names can
be localized using an existing Qt translation (.qm) file.

See [I18N Documentation](Reference/I18n/I18n_Conventions/#application-names)
about the keys _X-Amber-Translation-Catalog_ and _X-Amber-Logical-Id-*_.

### Application sandboxing profile
Application developers can control their app's
[sandbox](https://github.com/sailfishos/sailjail-permissions#sailfish-os-application-sandboxing-and-permissions)
with _X-Sailjail_ section. They may define _OrganizationName_, _ApplicationName_ and _Permissions_
keys. Additionally it's possible to disable sandboxing of an application with _Sandboxing=Disabled_.

_OrganizationName_ and _ApplicationName_ define the D-Bus bus name that the application may own on
session bus. This bus name is formed by concatenating the value of _OrganizationName_, a dot and the
value of _ApplicationName_ in this order so that they form a reverse domain name uniquely
identifying the application. _OrganizationName_ should contain at least one dot while
_ApplicationName_ should not contain any dots. This name can be used for notifications, sharing and
D-Bus activation like described below. The values of these keys also define the directories in user
home directory that the application may use to store application private data.

_Permissions_ value is a list of [Sailjail
permissions](https://github.com/sailfishos/sailjail-permissions#permissions). Lipstick checks this
list of permissions for approval before launching the app.

### D-Bus activation
As of Sailfish OS 4.3.0 there is support for automatically generating D-Bus service files using
_ExecDBus_ key in _X-Sailjail_ section. That way it's possible to have D-Bus activation without
shipping such files as part of the application and to have the platform in control of the launching
process. These files are generated to _/run/user/\*/dbus-1/services/_ by Sailjail on user session
startup and modified whenever a desktop file changes, e.g. when an application is installed, updated
or removed. That new key is used the same way as regular _Exec_ key in _Desktop Entry_ section but
it enables use of different arguments.

Defining distinct arguments for _ExecDBus_ allows to detect when D-Bus activation is used. This is
useful for launching the application first as a background service that doesn't show a window and
then when a suitable trigger method is called on the D-Bus API, a window can be shown. This way just
introspecting the D-Bus API doesn't show a window and interfaces can avoid graphical gliches due to
showing a window too early.

Sailfish OS 4.5.0 and later support using [_org.freedesktop.Application_ D-Bus
interface](https://specifications.freedesktop.org/desktop-entry-spec/desktop-entry-spec-latest.html#dbus)
for opening files and activating windows. However, Sailfish's implementation extends the
specification in two important ways: Firstly, in addition to _DBusActivatable=true_ key in _Desktop
Entry_ section, a prefixed custom _X-DBusActivatable=true_ key is also supported. They behave
identically. Secondly, Lipstick also supports using D-Bus bus name derived from _X-Sailjail_ section
instead of deriving it from the file name of the Desktop Entry file. See [Application sandboxing
profile](#application-sandboxing-profile) above for more information on that bus name derivation.
These additions were implemented as currently Sailfish does not use reverse domain name notation for
Desktop Entry file names but some tools enforce these rules.

By specifying _X-DBusActivatable=true_ in _Desktop Entry_ section Lipstick can be instructed to call
that above-mentioned D-Bus API instead of executing a new process. When _Open_ or _Activate_ are
called, they should also activate the window of the application. Failing to do that may lead to
users being unable to open the application. Note that Lipstick does not support _ActivateAction_
method currently.

#### Errata
In Sailfish OS 4.3.0 _ExecDBus_ is not considered when validating the arguments for an application
launched via D-Bus which limits usefulness of that key. To work around that, the launch arguments
used for D-Bus activation must match _Exec_ key in _Desktop Entry_ section. This issue is fixed in
Sailfish OS 4.4.0.

## D-Bus method calls
The keys _X-Maemo-Service_, _X-Maemo-Object-Path_, _X-Maemo-Method_ can be
used to specify a D-Bus method on a certain object path, which is called when
the launcher is activated.

The optional _X-Maemo-Fixed-Args_ tag can pass arguments to the call.

This is similar to, but different from D-Bus activation above. The D-Bus
Service must already be registered (e.g. using the method above, or from the app
after launch), and `path` and `method` must exist for that service.

This is used e.g. by MimeType .desktop files to open an app at a certain page.

## Legacy and Deprecated

 - _X-MeeGo-Translation-Catalog_ and _X-MeeGo-Logical-Id_.  Used for translations. Replaced by the _X-Amber-_ variants.

