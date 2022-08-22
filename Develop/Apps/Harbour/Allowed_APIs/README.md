---
title: Allowed APIs
permalink: Develop/Apps/Harbour/Allowed_APIs/
parent: Harbour
grand_parent: Apps
layout: default
nav_order: 200
---

This information is valid as of Sailfish OS 4.4.0 release

You can always check the up-to-date list from the [validator config files](https://github.com/sailfishos/sdk-harbour-rpmvalidator)

## Allowed Libraries

Your application can link against the following libraries:

### Qt 5 Core libraries

  - libQt5Core.so.5
  - libQt5Quick.so.5
  - libQt5Qml.so.5
  - libQt5Network.so.5
  - libQt5Gui.so.5

### Sailfish Silica library, Application Library + booster helper library

  - libsailfishapp.so.1
  - libmdeclarativecache5.so.0
  - libsailfishsilica.so.1

### Sailfish WebView library

  - libqt5embedwidget.so.1
  - libsailfishwebengine.so.1

### Amber Web Authorization framework

  - libamberwebauthorization.so.1

### OpenGL ES 1.1, 2.0 and EGL

  - libEGL.so.1
  - libGLESv1_CM.so.1
  - libGLESv2.so.2

### Standard system and C/C++ runtime libraries

  - ld-linux.so.2
  - ld-linux-armhf.so.3
  - ld-linux-aarch64.so.1
  - libpthread.so.0
  - libstdc++.so.6
  - libm.so.6
  - libgcc_s.so.1
  - libc.so.6
  - librt.so.1
  - libdl.so.2
  - libz.so.1
  - libresolv.so.2

### Nemo Libraries

  - libnemonotifications-qt5.so.1
  - libnemothumbnailer-qt5.so.1
  - libkeepalive.so.1

### Additional Qt 5 modules

  - libQt5Concurrent.so.5
  - libQt5Multimedia.so.5
  - libQt5Sql.so.5
  - libQt5Svg.so.5
  - libQt5XmlPatterns.so.5
  - libQt5Xml.so.5
  - libQt5DBus.so.5
  - libQt5Sensors.so.5
  - libQt5Positioning.so.5
  - libQt5WebSockets.so.5

### Various additional libraries that are useful

  - libmlite5.so.0
  - libpng16.so.16
  - libdbus-1.so.3
  - libcurl.so.4
  - libfontconfig.so.1
  - libssl.so.1.1
  - libcrypto.so.1.1
  - liblzma.so.5
  - libxml2.so.2
  - libbz2.so.1
  - libexpat.so.1
  - libsqlite3.so.0

### GLib

  - libgio-2.0.so.0
  - libglib-2.0.so.0
  - libgmodule-2.0.so.0
  - libgobject-2.0.so.0
  - libgthread-2.0.so.0

### Low-level PulseAudio and Audio APIs

  - libpulse.so.0
  - libpulse-simple.so.0
  - libaudioresource.so.1

### Low-level Wayland Protocol APIs

  - libwayland-client.so.0
  - libwayland-cursor.so.0
  - libwayland-egl.so.1

### Multimedia

  - libogg.so.0
  - libvorbis.so.0
  - libvorbisenc.so.2
  - libvorbisfile.so.3
  - libsndfile.so.1

### SDL2

  - libSDL2-2.0.so.0
  - libSDL2_gfx-1.0.so.0
  - libSDL2_image-2.0.so.0
  - libSDL2_mixer-2.0.so.0
  - libSDL2_net-2.0.so.0
  - libSDL2_ttf-2.0.so.0

## Allowed QML Imports

Your app is not allowed to have QML imports matching the following patterns:

### Disallowed QML Imports

  - Amber.*
  - Bluetooth.*
  - Meego.*
  - Mer.*
  - Nemo.*
  - NemoMobile.*
  - Sailfish.*
  - Qt*
  - org.nemomobile.*
  - org.sailfishos.*
  - com.jolla.*
  - com.nokia.*
  - com.meego.*
  - org.kde.bluezqt

The exceptions to this rule are the following imports:

### Sailfish API

  - Sailfish.Silica 1.0
  - Sailfish.Pickers 1.0
  - Sailfish.Share 1.0
  - Sailfish.WebView 1.0
  - Sailfish.WebView.Controls 1.0
  - Sailfish.WebView.Pickers 1.0
  - Sailfish.WebView.Popups 1.0
  - Sailfish.WebEngine 1.0

### Amber Web Authorization framework

  - Amber.Web.Authorization 1.0

### Amber MPRIS Library

  - Amber.Mpris 1.0

### Qt APIs

  - QtQml 2.0
  - QtQml 2.1
  - QtQml 2.2
  - QtQuick 2.0
  - QtQuick 2.1
  - QtQuick 2.2
  - QtQuick 2.3
  - QtQuick 2.4
  - QtQuick 2.5
  - QtQuick 2.6
  - QtQuick.Layouts 1.0
  - QtQuick.Layouts 1.1
  - QtQuick.LocalStorage 2.0
  - QtQuick.Particles 2.0
  - QtQuick.Window 2.0
  - QtQuick.Window 2.1
  - QtQuick.Window 2.2
  - QtQuick.XmlListModel 2.0

### Additional QML modules

  - QtMultimedia 5.0
  - QtMultimedia 5.1
  - QtMultimedia 5.2
  - QtMultimedia 5.3
  - QtMultimedia 5.4
  - QtMultimedia 5.5
  - QtMultimedia 5.6
  - QtWebSockets 1.0
  - QtWebSockets 1.1
  - QtSensors 5.0
  - QtSensors 5.1
  - QtSensors 5.2
  - QtGraphicalEffects 1.0
  - QtPositioning 5.2
  - QtPositioning 5.4
  - QtQml.Models 2.1
  - QtQml.Models 2.2
  - QtQml.Models 2.3

### QtFeedback hasn't been declared stable, but we allow a restricted part

  - QtFeedback 5.0

### ContextKit

  - org.freedesktop.contextkit 1.0

### Python support

  - io.thp.pyotherside 1.0
  - io.thp.pyotherside 1.1
  - io.thp.pyotherside 1.2
  - io.thp.pyotherside 1.3
  - io.thp.pyotherside 1.4
  - io.thp.pyotherside 1.5

### Nemo QML modules

  - Nemo.Notifications 1.0
  - Nemo.DBus 2.0
  - Nemo.Configuration 1.0
  - Nemo.Thumbnailer 1.0
  - Nemo.KeepAlive 1.2

## Allowed package dependencies

Usually you shouldn't add library depencencies or python module dependencies to your package manually, as these dependencies are generated automatically. Your rpm packages can require the following:

### Core libraries

  - libc.so.6
  - libpthread.so.0
  - librt.so.1
  - libm.so.6
  - libdl.so.2
  - ld-linux.so.2
  - ld-linux-armhf.so.3
  - ld-linux-aarch64.so.1
  - libz.so.1
  - libgcc_s.so.1

### C++ standard library

  - libstdc++.so.6

### Other libraries

  - libpng16.so.16

### PulseAudio

  - libpulse.so.0
  - libpulse-simple.so.0

### Sailfish Silica QML API

  - sailfishsilica-qt5
  - libsailfishapp
  - mapplauncherd-booster-silica-qt5
  - libqt5embedwidget.so.1
  - sailfish-components-webview-qt5
  - sailfish-components-webview-qt5-popups
  - sailfish-components-webview-qt5-pickers
  - libsailfishwebengine.so.1

### Amber Web Authorization framework

  - amber-web-authorization
  - libamberwebauthorization.so.1

### Amber MPRIS Library

  - amber-qml-plugin-mpris
  - qml(Amber.Mpris)

### QML Imports

  - qt5-qtdeclarative-import-xmllistmodel
  - qt5-qtdeclarative-import-folderlistmodel
  - qt5-qtdeclarative-import-localstorageplugin
  - qt5-qtdeclarative-import-multimedia
  - qt5-qtdeclarative-import-websockets
  - qt5-qtdeclarative-import-particles2
  - qt5-qtdeclarative-qtquickparticles
  - qt5-qtsvg
  - qt5-qtgraphicaleffects
  - qt5-qtdeclarative-import-positioning
  - qt5-qtdeclarative-import-sensors
  - qt5-qtquickcontrols-layouts
  - qt5-qtdeclarative-import-models2
  - qt5-qtwebsockets

### Nemo QML Imports

  - nemo-qml-plugin-notifications-qt5
  - nemo-qml-plugin-dbus-qt5
  - nemo-qml-plugin-configuration-qt5
  - nemo-qml-plugin-thumbnailer-qt5
  - nemo-qml-plugin-contextkit-qt5
  - qml(org.freedesktop.contextkit)
  - libkeepalive

### Qt Modules

  - qt5-qtmultimedia
  - qt5-qtmultimedia-plugin-audio-pulseaudio
  - qt5-qtpositioning

### Image format plugins

  - qt5-plugin-imageformat-gif
  - qt5-plugin-imageformat-ico
  - qt5-plugin-imageformat-jpeg
  - qt5-qtsvg-plugin-imageformat-svg

### Other libraries

  - mlite-qt5
  - libcrypto.so.1.1
  - libssl.so.1.1
  - liblzma.so.5
  - libbz2.so.1
  - libexpat.so.1
  - libsqlite3.so.0

### Python support

  - pyotherside-qml-plugin-python3-qt5
  - python3-gobject
  - python3-sqlite
  - python3dist(sqlite3)
  - python3dist(curses)
  - python3dist(attrs)
  - python3dist(pygobject)
  - python3dist(idna)
  - python3dist(lxml)
  - python3dist(pyopenssl)
  - python3dist(six)
  - python3dist(pyyaml)
  - python3dist(zope-interface)
  - python3dist(sortedcontainers)
  - python3dist(toml)
  - python3dist(twisted)

### libxml2

  - libxml2
  - libxml2.so.2

### Multimedia

  - libogg.so.0
  - libvorbis.so.0
  - libvorbisenc.so.2
  - libvorbisfile.so.3
  - libsndfile.so.1

### SDL2

  - libSDL2-2.0.so.0
  - libSDL2_gfx-1.0.so.0
  - libSDL2_image-2.0.so.0
  - libSDL2_mixer-2.0.so.0
  - libSDL2_net-2.0.so.0
  - libSDL2_ttf-2.0.so.0

## Deprecated libraries

The following libraries have been deprecated, and they should no longer be used in new code. They will be dropped from allowed libraries in a future release:

### Deprecated from Sailfish OS 1.1.8.x onward

  - libpng15.so.15

### Deprecated in Sailfish OS 4.0.1

  - libssl.so.10
  - libcrypto.so.10

### deprecated in Sailfish OS 4.4.0

  - libQt5WebKit.so.5

## Deprecated QML Imports

The following QML Imports have been renamed. The old imports should no longer be used in new code. They will be dropped from allowed imports in a future release:

  - org.nemomobile.notifications 1.0
    - Renamed as 'Nemo.Notifications 1.0'
  - org.nemomobile.dbus 2.0
    - Renamed as 'Nemo.DBus 2.0'
  - org.nemomobile.configuration 1.0
    - Renamed as 'Nemo.Configuration 1.0'
  - org.nemomobile.thumbnailer 1.0
    - Renamed as 'Nemo.Thumbnailer 1.0'
  - QtWebKit 3.0
    - Deprecated in Sailfish 4.4.0
