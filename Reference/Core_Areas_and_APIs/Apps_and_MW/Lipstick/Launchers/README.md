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
for opening files and activating windows. By specifying _DBusActivatable=true_ in _Desktop Entry_
section Lipstick can be instructed to call that API instead of executing a new process. When _Open_
or _Activate_ are called, they should also activate the window of the application. Failing to do
that may lead to users being unable to open the application. What's different from the specification
however, is that Lipstick also supports using D-Bus bus name derived from _X-Sailjail_ section
instead of deriving it from the file name of the Desktop Entry file. See [Application sandboxing
profile](#application-sandboxing-profile) above for more information on that bus name derivation.
Lipstick does not support _ActivateAction_ method currently.

#### Errata
In Sailfish OS 4.3.0 _ExecDBus_ is not considered when validating the arguments for an application
launched via D-Bus which limits usefulness of that key. To work around that, the launch arguments
used for D-Bus activation must match _Exec_ key in _Desktop Entry_ section. This issue is fixed in
Sailfish OS 4.4.0.
