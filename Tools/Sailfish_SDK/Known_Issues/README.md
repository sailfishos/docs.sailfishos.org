---
title: Known Issues
permalink: Tools/Sailfish_SDK/Known_Issues/
parent: Sailfish SDK
layout: default
nav_order: 300
---

These are the known issues with the Sailfish SDK. If you have any questions, feel free to either write it up in <https://forum.sailfishos.org/> or send an e-mail to developer-care at jolla.com. We’ll get back to you as soon as possible. Please review also the [Release notes](/Tools/Sailfish_SDK#release-notes) for the SDK release.

### Installer / Uninstaller

  - If you want to reinstall the SDK to another location it is recommended to first remove SDK installation and then manually delete the config file directory (in Linux and Mac it’s in $HOME/.config/SailfishSDK, in Windows this is not necessary anymore) and then reinstall SDK.
  - When uninstalling – SDKMaintenanceTool might show a dialog of some certain directories not being empty. This is OK and can be bypassed by selecting ‘Ignore’.
  - If your /home dir has free space but / (root dir) does not then installer will complain. Solution: pre-create the destination directory and the installer will continue or if that does not work, additionally set the environment value TMPDIR to a path that has enough space.
  - If installing Sailfish SDK into /opt doesn’t work then please install to /home/$USER/Sailfish OS.
  - On Mac and Windows the automatic check for updates may fail randomly due to an error in Qt Installer Framework. It is possible to start updater manually from menu Help in Sailfish IDE.
  - The Installer and SDK Maintenance Tool is not HTTPS-capable on Windows

### Sailfish IDE (Qt Creator)

  - Sailfish IDE might show a kit called “Desktop”. It cannot be used to create Sailfish OS applications and you should not select it when configuring Sailfish OS projects.
  - When launching applications from the toolbar or using ctrl+R, it is possible to launch multiple instances of an application which need terminating from the Home screen.
  - SDK cannot be installed to a path with whitespace. Projects cannot be created to paths with whitespace.
  - In OS X /tmp directory cannot be used as alternate source directory.
  - The following warnings are produced for build targets older than 3.3.0.x: Could not resolve the prototype "SilicaItem" of "PageHeader". (M301)

### SDK CLI (sfdk)

### Sailfish OS Build Engine

  - Timeout errors when connecting to the Build Engine\
    Some users may experience random connection timeout errors when building and/or deploying applications from Sailfish IDE. This can for example happen in an environment where your computer has no Internet connection or changes WiFi station during the day.

    It may be possible to fix this condition by adding the name SailfishSDK to your computer’s hosts file, e.g.:
    ```
    127.0.0.1 localhost.localdomain localhost SailfishSDK
    ```
  - Issues with Docker-based build engine
      - Old sailfish-os-build-engine images keep piling up (see [this from the FAQ](/Tools/Sailfish_SDK/FAQ#old-sailfish-os-build-engine-images-keep-piling-up-is-this-desired))
      - Failure to deploy from docker based build engine to emulator with customized SSH port
      - Sailfish IDE needs restart after changing SSH port of a Docker based build engine

### Sailfish OS Emulator

  - If the Emulator fails to boot to user interface, the reason might be disabled virtualization technology settings in host computer’s BIOS. By turning on virtualization technology settings from BIOS, the emulator should boot up to user interface.
  - Emulator may display a banner about Charging status when starting up. It can be dismissed by clicking on it. Emulator follows the battery status of the host computer.
  - Emulator might start flickering on slow computers.
  - Timeout problems connecting to emulator
  - Application covers near to the left/right screen edge are rendered incorrectly when emulator is running in landscape mode - part of the cover is darker.

### Debugging

  - GDB may crash occasionally when stepping into code.
  - On Linux the debugger binary depends on `libtinfo.so.5`. On some ditributions this library is not installed by default when symbols normally provided by this library are available from `libncurses.so.5`. E.g. on Fedora the package `ncurses-compat-libs` must be installed manually, on Ubuntu 19.10 it is `libncurses5`. If you find no way to fix `libtinfo.so.5` on your system, you can create it as a symlink to your system `libncurses.so.5` in `~/SailfishOS/lib/` and set `LD_LIBRARY_PATH` accordingly prior to running `~/SailfishOS/bin/qtcreator`.

### General / Other

  - Microsoft Hyper-V is incompatible with Virtualbox ([Virtualbox ticket 16801](https://www.virtualbox.org/ticket/16801)). Please, check that it's disabled in Windows Features before starting the Emulator or the Build Engine. This is a known issue especially with Windows 10.
      - Recent Windows and VirtualBox versions are said to remove this limitation - please check the [What are the compatibility issues with Sailfish OS emulators on Windows?](/Tools/Sailfish_SDK/FAQ#what-are-the-compatibility-issues-with-sailfish-os-emulators-on-windows) entry in our Docker related FAQ.
  - If you need to set a proxy to connect to the Internet, connections from the Emulator are known to fail. Proxy settings for the Build Engine can be configured inside Sailfish IDE, under Options \> Sailfish OS \> Build Engine.
  - The rpmlint validation suite is unusable with 4.3.0.12 build targets. It fails with error “No such file or directory”. If you wish to use rpmlint validation suite, you can fix the tooling by issuing the following command:

        sfdk tools exec SailfishOS-4.3.0.12 zypper in gnu-cpio

    When prompted, select Solution 1.
