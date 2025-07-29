---
title: Known Issues
permalink: Tools/Sailfish_SDK/Known_Issues/
parent: Sailfish SDK
layout: default
nav_order: 300
---

These are the known issues with the Sailfish SDK. If you have any questions, feel free to either write it up in <https://forum.sailfishos.org/> or send an e-mail to developer-care at jolla.com. We’ll get back to you as soon as possible. Please review also the [Release notes](/Tools/Sailfish_SDK#release-notes) for the SDK release.

### Installer / Uninstaller

  - If you want to reinstall the SDK to another location it is recommended to first remove SDK installation and then manually delete the config file directory (in Linux and macOS it’s in $HOME/.config/SailfishSDK, in Windows this is not necessary anymore) and then reinstall SDK.
  - When uninstalling – SDKMaintenanceTool might show a dialog of some certain directories not being empty. This is OK and can be bypassed by selecting ‘Ignore’.
  - If your /home dir has free space but / (root dir) does not then installer will complain. Solution: pre-create the destination directory and the installer will continue or if that does not work, additionally set the environment value TMPDIR to a path that has enough space.
  - If installing Sailfish SDK into /opt doesn’t work then please install to /home/$USER/Sailfish OS.
  - On macOS and Windows the automatic check for updates may fail randomly due to an error in Qt Installer Framework. It is possible to start updater manually from menu Help in Sailfish IDE.
  - The Installer and SDK Maintenance Tool is not HTTPS-capable on Windows

### Sailfish IDE (Qt Creator)

  - Sailfish IDE might show a kit called “Desktop”. It cannot be used to create Sailfish OS applications and you should not select it when configuring Sailfish OS projects.
  - When launching applications from the toolbar or using ctrl+R, it is possible to launch multiple instances of an application which need terminating from the Home screen.
  - SDK cannot be installed to a path with whitespace. Projects cannot be created to paths with whitespace.
  - In macOS /tmp directory cannot be used as alternate source directory.
  - Various warnings are produced by the QML static code checker for Sailfish.Silica types with the build targets matching a few Sailfish OS releases prior to 4.4.0.58, like `Could not resolve the prototype "SilicaItem" of "PageHeader". (M301)`
    - There is a [partial workaround](https://forum.sailfishos.org/t/resolve-error-in-qt-creator/9889/8).
  - Some QML modules are not initially recognized by the IDE
    - This can be fixed by installing the corresponding package under build targets using Options > Sailfish OS > Build Engine > Manage Build Targets… > Manage Packages. All packages corresponding to QML APIs [enabled on Harbour](https://harbour.jolla.com/faq#QML_API) are installed by default and should not need any extra action in this respect.
  - Sailfish IDE may not find header files from packages added as dependencies via PKGCONFIG qmake variable.
    - This is often caused by "qmake system() behavior when parsing" option under Build Settings set to "Ignore". See the next item to learn about the drawbacks before changing it to "Run". (SDK 3.9+)
  - Qmake's system() function is ignored by the project parser under the default configuration.
    - This is controlled by the "qmake system() behavior when parsing" option under Build Settings.
    - It is ignored by default because it runs directly on host, not under the build environment as one would expect.


### SDK CLI (sfdk)
 - `sfdk tools list --available` hangs when SDK updates are available
 - Suspending under terminal (`^Z`) is not always possible
 - Not possible to run multiple builds simultaneously due to conflicts in package creation phase
 - sfdk called from a shell script under Windows/MSYS2 with the help of the `exec` shell built-in fails with the following error: `[D] SOFT ASSERT: "parentPidIt != parentPids.constEnd()" in file ...\session.cpp, line 279`

### Sailfish SDK Build Engine

  - Timeout errors when connecting to the Build Engine\
    Some users may experience random connection timeout errors when building and/or deploying applications from Sailfish IDE. This can for example happen in an environment where your computer has no Internet connection or changes WiFi station during the day.

    It may be possible to fix this condition by adding the name SailfishSDK to your computer’s hosts file, e.g.:
    ```
    127.0.0.1 localhost.localdomain localhost SailfishSDK
    ```
  - Issues with Docker-based build engine
      - Old sailfish-sdk-build-engine images keep piling up (see [this from the FAQ](/Tools/Sailfish_SDK/FAQ#old-sailfish-os-build-engine-images-keep-piling-up-is-this-desired))
      - Failure to deploy from docker based build engine to emulator with customized SSH port
      - Sailfish IDE needs restart after changing SSH port of a Docker based build engine
      - Error starting the build engine on [Linux hosts with cgroups v2](https://forum.sailfishos.org/t/issues-with-installing-sailfish-sdk-docker-with-debian-bullseye-11/4454)
          - It is usually possible to revert back to cgroups v1 by adding `systemd.unified_cgroup_hierarchy=false` to the host kernel command line
      - On some systems package manager gets stuck or crashes due to unreasonably high file descriptor limit and builds will not get past initialization phase. You may stop build engine with `sfdk engine stop` and then use this workaround:

            sfdk engine exec sudo tee /etc/security/limits.d/95-nofile-sdk-fix.conf <<END
            # This is a workaround for issues with package manager
            * hard nofile 4096
            root hard nofile 4096
            END


### Sailfish OS Emulator

  - If the Emulator fails to boot to user interface, the reason might be disabled virtualization technology settings in host computer’s BIOS. By turning on virtualization technology settings from BIOS, the emulator should boot up to user interface.
  - On recent macOS versions, when the emulator crashes during startup, ensure your VirtualBox version is at least 7.1. Alternatively, disabling access to microphone in the corresponding virtual machine settings may help.
  - Emulator may display a banner about Charging status when starting up. It can be dismissed by clicking on it. Emulator follows the battery status of the host computer.
  - Emulator might start flickering on slow computers.
  - Timeout problems connecting to emulator
  - Application covers near to the left/right screen edge are rendered incorrectly when emulator is running in landscape mode - part of the cover is darker.

### Debugging

  - GDB may crash occasionally when stepping into code.

### General / Other

  - Microsoft Hyper-V is incompatible with Virtualbox ([Virtualbox ticket 16801](https://www.virtualbox.org/ticket/16801)). Please, check that it's disabled in Windows Features before starting the Emulator or the Build Engine. This is a known issue especially with Windows 10.
      - Recent Windows and VirtualBox versions are said to remove this limitation - please check the [What are the compatibility issues with Sailfish OS emulators on Windows?](/Tools/Sailfish_SDK/FAQ#what-are-the-compatibility-issues-with-sailfish-os-emulators-on-windows) entry in our Docker related FAQ.
  - If you need to set a proxy to connect to the Internet, connections from the Emulator are known to fail. Proxy settings for the Build Engine can be configured inside Sailfish IDE, under Options \> Sailfish OS \> Build Engine.
  - The rpmlint validation suite is unusable with 4.3.0.12 build targets. It fails with error “No such file or directory”. If you wish to use rpmlint validation suite, you can fix the tooling by issuing the following command:

        sfdk tools exec SailfishOS-4.3.0.12 zypper in gnu-cpio

    When prompted, select Solution 1.
