---
title: D-Bus APIs
permalink: Reference/Core_Areas_and_APIs/D-Bus_APIs/
has_children: true
parent: Core Areas and APIs
layout: default
nav_order: 500
---

D-Bus APIs provided by Sailfish OS. Some of the APIs are not available on all hardware due to different enabled features, installed packages or hardware differences.

## System bus services

| Name                                  | Purpose                                                                                                              | Access                                                          | Activation |
| ------------------------------------- | -------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------- | ---------- |
| com.jolla.apkd                        | Integration with Android™ AppSupport. Manages service state and installtion/removal of Android application packages. | Unrestricted, with exceptions for special package installations | Yes        |
| com.meego.usb_moded                   | Controls the USB states.                                                                                             | TBA                                                             | No         |
| com.nokia.diskmonitor                 | Monitor for free space on filesystems.                                                                               | TBA                                                             | No         |
| com.nokia.dsme                        | Device State Management Entity; e.g. battery empty notification and requesting reboot.                               | TBA                                                             | No         |
| com.nokia.location.odnpd              | HERE location services                                                                                               | TBA                                                             | Yes        |
| com.nokia.location.slpgwd             | HERE location services                                                                                               | TBA                                                             | Yes        |
| com.nokia.mce                         | Mode Control Entity; e.g. battery level notification and display state management.                                   | TBA                                                             | No         |
| com.nokia.NonGraphicFeedback1.Backend | TBA                                                                                                                  | TBA                                                             | No         |
| com.nokia.SensorService               | Read sensors for ambient light, orientation or proximity.                                                            | Unrestricted                                                    | No         |
| com.nokia.thermalmanager              | Read temperature sensors.                                                                                            | Unrestricted                                                    | No         |
| com.nokia.time                        | Alarm and time settings.                                                                                             | TBA                                                             | No         |
| com.nokia.timed.backup                | TBA                                                                                                                  | TBA                                                             | No         |
| fi.w1.wpa_supplicant1                 | Wifi management.                                                                                                     | TBA                                                             | Yes        |
| net.connman                           | Internet connection management.                                                                                      | TBA                                                             | No         |
| net.connman.vpn                       | TBA                                                                                                                  | TBA                                                             | Yes        |
| org.bluez                             | Bluetooth daemon                                                                                                     | TBA                                                             | Yes        |
| org.freedesktop.DBus                  | D-Bus management                                                                                                     | TBA                                                             | No         |
| org.freedesktop.hostname1             | Query or change system hostname.                                                                                     | Polkit                                                          | Yes        |
| org.freedesktop.login1                | Logind daemon                                                                                                        | Polkit                                                          | Yes        |
| org.freedesktop.ohm                   | Open Hardware Manager                                                                                                | TBA                                                             | Yes        |
| org.freedesktop.PackageKit            | Package management.                                                                                                  | Polkit                                                          | Yes        |
| org.freedesktop.PolicyKit1            | User authorization and authentication.                                                                               | Polkit                                                          | Yes        |
| org.freedesktop.systemd1              | Systemd daemon control.                                                                                              | Polkit                                                          | Yes        |
| org.freedesktop.UDisks2               | Partition and filesystem management.                                                                                 | Polkit                                                          | Yes        |
| org.maemo.resource.manager            | TBA                                                                                                                  | TBA                                                             | No         |
| org.neard                             | NFC                                                                                                                  | TBA                                                             | No         |
| org.nemomobile.compositor             | TBA                                                                                                                  | TBA                                                             | No         |
| org.nemomobile.devicelock             | Interact with device lock to authenticate and authorize. Query and get signals of device lock state.                 | TBA                                                             | No         |
| [org.nemomobile.lipstick](/Reference/Core_Areas_and_APIs/D-Bus_APIs/D-Bus_service_org.nemomobile.lipstick) | Home Screen                                                            | TBA          | No         |
| org.nemomobile.MmsEngine              | MMS                                                                                                                  | TBA                                                             | Yes        |
| org.nemomobile.MmsHandler             | MMS                                                                                                                  | TBA                                                             | No         |
| org.nemomobile.provisioning           | Cellular data connection management.                                                                                 | TBA                                                             | Yes        |
| org.nemomobile.Route.Manager          | OHM route management.                                                                                                | TBA                                                             | No         |
| org.nemo.passwordmanager              | Developer mode password management.                                                                                  | TBA                                                             | Yes        |
| org.nemo.ssu                          | TBA                                                                                                                  | system                                                          | Yes        |
| org.ofono                             | Phone calls and messaging.                                                                                           | privileged, Unrestricted                                        | No         |
| org.ofono.SmartMessagingAgent         | TBA                                                                                                                  | TBA                                                             | No         |
| org.pacrunner                         | Proxy configuration for connman.                                                                                     | TBA                                                             | Yes        |
| org.sailfishos.abootsettings          | TBA                                                                                                                  | TBA                                                             | No         |
| org.sailfishos.EncryptionService      | Encrypts home partition on request.                                                                                  | privileged                                                      | Yes        |
| org.sailfishos.system_nfc             | TBA                                                                                                                  | TBA                                                             | No         |

## Session bus services

| Name                                                                        | Purpose                                                                | Access       | Activation |
| --------------------------------------------------------------------------- | ---------------------------------------------------------------------- | ------------ | ---------- |
| ca.desrt.dconf                                                              | dconf, low-level key/value database designed for environment settings. | TBA          | Yes        |
| com.google.code.AccountsSSO.SingleSignOn                                    | Single Sign On framework                                               | TBA          | Yes        |
| com.jolla.ambienced                                                         | Ambience management.                                                   | TBA          | Yes        |
| com.jolla.apkd.interaction                                                  | Interaction with Apkd                                                  | TBA          | Yes        |
| com.jolla.Bluetooth                                                         | TBA                                                                    | TBA          | Yes        |
| com.jolla.camera                                                            | Camera application                                                     | TBA          | Yes        |
| com.jolla.clock                                                             | Clock application                                                      | TBA          | Yes        |
| com.jolla.Connectiond                                                       | TBA                                                                    | TBA          | Yes        |
| com.jolla.contacts.ui                                                       | Contacts application                                                   | TBA          | Yes        |
| com.jolla.csd                                                               | TBA                                                                    | TBA          | Yes        |
| com.jolla.email.ui                                                          | Email application                                                      | TBA          | Yes        |
| com.jolla.gallery                                                           | Gallery application                                                    | TBA          | Yes        |
| com.jolla.jollastore                                                        | Store application                                                      | TBA          | Yes        |
| com.jolla.keyboard                                                          | Get on-screen keyboard server socket address.                          | Unrestricted | No         |
| com.jolla.lipstick                                                          | Home screen                                                            | TBA          | No         |
| com.jolla.lipstick.ConnectionSelector                                       | TBA                                                                    | TBA          | No         |
| com.jolla.mediaplayer                                                       | Mediaplayer application                                                | TBA          | Yes        |
| com.jolla.notes                                                             | Notes application                                                      | TBA          | Yes        |
| com.jolla.obex                                                              | TBA                                                                    | TBA          | Yes        |
| com.jolla.ObexCallData                                                      | TBA                                                                    | TBA          | Yes        |
| com.jolla.PinQuery                                                          | TBA                                                                    | TBA          | No         |
| com.jolla.settings                                                          | Settings UI                                                            | TBA          | Yes        |
| com.jolla.settings.system.flashlight                                        | Control flashlight.                                                    | Unrestricted | Yes        |
| com.jolla.voicecall.ui                                                      | Dialer application                                                     | TBA          | Yes        |
| com.jolla.weather                                                           | Weather application                                                    | TBA          | Yes        |
| com.jolla.windowprompt                                                      | Window prompts to inform user.                                         | privileged   | Yes        |
| com.meego.msyncd                                                            | Buteo sync daemon.                                                     | TBA          | No         |
| com.nokia.contactsd                                                         | Telepathy and QtContacts bridge for contacts.                          | TBA          | No         |
| com.nokia.CrashReporter.AutoUploader                                        | Upload crash reports from Crash Reporter.                              | TBA          | Yes        |
| com.nokia.CrashReporter.Daemon                                              | TBA                                                                    | TBA          | Yes        |
| com.nokia.policy.telephony                                                  | TBA                                                                    | TBA          | No         |
| com.nokia.profiled                                                          | TBA                                                                    | TBA          | Yes        |
| com.nokia.SingleSignOn.Backup                                               | TBA                                                                    | TBA          | Yes        |
| com.nokia.singlesignonui                                                    | TBA                                                                    | TBA          | Yes        |
| com.nokia.telephony.callhistory                                             | TBA                                                                    | TBA          | No         |
| com.nokia.voland                                                            | TBA                                                                    | TBA          | Yes        |
| com.sailfish.easdaemon                                                      | TBA                                                                    | TBA          | Yes        |
| org.bluez.obex                                                              | Bluetooth OBject EXchange                                              | TBA          | Yes        |
| org.freedesktop.DBus                                                        | D-Bus management                                                       | TBA          | No         |
| org.freedesktop.Geoclue.Master                                              | TBA                                                                    | TBA          | Yes        |
| org.freedesktop.Geoclue.Providers.Here                                      | TBA                                                                    | TBA          | Yes        |
| org.freedesktop.Geoclue.Providers.Hybris                                    | TBA                                                                    | TBA          | Yes        |
| org.freedesktop.Geoclue.Providers.Mlsdb                                     | TBA                                                                    | TBA          | Yes        |
| org.freedesktop.Notifications                                               | Desktop notifications                                                  | TBA          | No         |
| org.freedesktop.ohm_session_agent                                           | TBA                                                                    | TBA          | Yes        |
| org.freedesktop.systemd1                                                    | Systemd user session daemon control.                                   | TBA          | Yes        |
| org.freedesktop.Telepathy.AccountManager                                    | TBA                                                                    | TBA          | Yes        |
| org.freedesktop.Telepathy.ChannelDispatcher                                 | TBA                                                                    | TBA          | No         |
| org.freedesktop.Telepathy.Client.CommHistory                                | TBA                                                                    | TBA          | No         |
| org.freedesktop.Telepathy.Client.qmlmessages                                | TBA                                                                    | TBA          | Yes        |
| org.freedesktop.Telepathy.Client.SaslSignonAuth                             | TBA                                                                    | TBA          | Yes        |
| org.freedesktop.Telepathy.Client.voicecall                                  | TBA                                                                    | TBA          | No         |
| org.freedesktop.Telepathy.ConnectionManager.gabble                          | TBA                                                                    | TBA          | Yes        |
| org.freedesktop.Telepathy.ConnectionManager.ring                            | TBA                                                                    | TBA          | Yes        |
| org.freedesktop.Telepathy.Connection.ring.tel.\<ID\>                        | TBA                                                                    | TBA          | No         |
| org.freedesktop.Telepathy.MissionControl5                                   | TBA                                                                    | TBA          | Yes        |
| org.freedesktop.Tracker1                                                    | Tracker object and metadata database, search tool and indexer.         | TBA          | Yes        |
| org.freedesktop.Tracker1.Miner.Extract                                      | Tracker indexer                                                        | TBA          | Yes        |
| org.freedesktop.Tracker1.Miner.Files                                        | Tracker indexer                                                        | TBA          | Yes        |
| org.freedesktop.Tracker1.Miner.Files.Index                                  | Tracker indexer                                                        | TBA          | No         |
| org.freedesktop.Tracker1.Writeback                                          | Tracker indexer                                                        | TBA          | Yes        |
| org.maemo.Playback.Manager                                                  | TBA                                                                    | TBA          | No         |
| org.maliit.server                                                           | Get on-screen keyboard server socket address.                          | Unrestricted | Yes        |
| org.nemomobile.AccountPresence                                              | TBA                                                                    | TBA          | No         |
| org.nemomobile.calendardataservice                                          | TBA                                                                    | TBA          | Yes        |
| org.nemomobile.ClassZeroSmsNotification                                     | TBA                                                                    | TBA          | Yes        |
| org.nemomobile.CommHistory                                                  | TBA                                                                    | TBA          | No         |
| org.nemomobile.DevicePresence                                               | TBA                                                                    | TBA          | No         |
| org.nemomobile.FileOperations                                               | Filemanager plugin                                                     | TBA          | Yes        |
| [org.nemomobile.lipstick](/Reference/Core_Areas_and_APIs/D-Bus_APIs/D-Bus_service_org.nemomobile.lipstick) | Home Screen                                                            | TBA          | No         |
| org.nemomobile.qmlmessages                                                  | TBA                                                                    | TBA          | Yes        |
| org.nemomobile.Thumbnailer                                                  | Simple service to generate thumbnails.                                 | TBA          | Yes        |
| org.nemomobile.voicecall                                                    | Voicecall daemon for dialer.                                           | TBA          | No         |
| org.nemo.transferengine                                                     | Transfer Engine for uploading media content and tracking transfers.    | TBA          | Yes        |
| org.PulseAudio1                                                             | Pulse Audio                                                            | TBA          | No         |
| org.pulseaudio.Server                                                       | Pulse Audio                                                            | TBA          | No         |
| org.sailfish.office                                                         | Documents application                                                  | TBA          | Yes        |
| org.sailfishos.archive                                                      | TBA                                                                    | TBA          | Yes        |
| org.sailfishos.browser                                                      | Control Sailfish OS browser.                                           | Unrestricted | Yes        |
| org.sailfishos.browser.ui                                                   | Control Sailfish OS browser.                                           | Unrestricted | Yes        |
| org.sailfishos.coveraction.pid\<PID\>.id\<ID\>                              | TBA                                                                    | privileged   | No         |
| org.sailfishos.installationhandler                                          | Install and remove RPM packages.                                       | privileged   | Yes        |
| org.sailfishos.osupdate                                                     | Query and download OS updates.                                         | privileged   | Yes        |
| org.sailfish.simkit                                                         | TBA                                                                    | TBA          | No         |

## Access levels

  - *Unrestricted* means that any client can connect and use the APIs.
  - *Polkit* means that accesses are verified from polkit when needed. I.e. user may be prompted for authorization.
  - Any lower case word means that processes need to have that effective group to use the API.
  - If API provides interfaces with differing levels of access, they are listed separated by comma (,).
  - If API provides interfaces with alternating levels of access, they are listed separated by slash (/), i.e. more than one user group can access the API.
  - In general root can access all APIs without restrictions.

## How to query for D-Bus APIs

D-Bus provides introspection that can query for available services, their paths and interfaces.

Listing names of running services on the bus:

  - Service: org.freedesktop.DBus
  - Path: /org/freedesktop/DBus
  - Interface: org.freedesktop.DBus
  - Method: ListNames()

Listing activatable names on the bus:

  - Service: org.freedesktop.DBus
  - Path: /org/freedesktop/DBus
  - Interface: org.freedesktop.DBus
  - Method: ListActivatableNames()

Also every service and path in D-Bus should provide `org.freedesktop.DBus.Introspectable.Introspect` which can be used to gather paths and interfaces.

### qdbus command

Introspection is easiest with `qdbus` command. That command is found on Sailfish OS from *qt5-qttools-qdbus* at `/usr/lib/qt5/bin/qdbus`.

List all services currently running on system bus:
```nosh
/usr/lib/qt5/bin/qdbus --system | grep -v '^:'
```

List D-Bus activated services including those that are not running:
```nosh
/usr/lib/qt5/bin/qdbus --system org.freedesktop.DBus /org/freedesktop/DBus org.freedesktop.DBus.ListActivatableNames
```

List paths of `com.nokia.SensorService`:
```nosh
/usr/lib/qt5/bin/qdbus --system com.nokia.SensorService
```

List interfaces at path `/SensorManager/orientationsensor` of `com.nokia.SensorService`:
```nosh
/usr/lib/qt5/bin/qdbus --system com.nokia.SensorService /SensorManager/orientationsensor
```

For session bus you should omit `--system` and run the commands as user `defaultuser`.

### dbus-send command

`dbus-send` can also be used to introspect services using normal `org.freedesktop.DBus` Introspection APIs.

List D-Bus services running:
```nosh
dbus-send --system --print-reply --dest=org.freedesktop.DBus /org/freedesktop/DBus org.freedesktop.DBus.ListNames
```

List activeable D-Bus services:
```nosh
dbus-send --system --print-reply --dest=org.freedesktop.DBus /org/freedesktop/DBus org.freedesktop.DBus.LisActivatableNames
```

Replace `--system` with `--session` if introspecting session bus.

### D-Bus activated services

D-Bus activated services must have a D-Bus service file in `/usr/share/dbus-1/system-service/` or `/usr/share/dbus-1/service/` directory depending on whether it is system bus or session bus service.
