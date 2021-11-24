---
title: Installation
permalink: Tools/Sailfish_SDK/Installation/
parent: Sailfish SDK
layout: default
nav_order: 100
---

We provide a graphical installer to make it easy to setup the Sailfish SDK.

## Supported Environments

Sailfish SDK functionality has been verified on the following systems:

  - Ubuntu 20.04 64 bit
  - Windows 10 64 bit
  - OS X 10.12.6

Sailfish SDK should work on other Linux flavours as well, but at this stage, its functionality on other host environments has not been fully verified.

## Pre-requisites

### Virtualization Platform

The native platform for Sailfish OS software development is GNU/Linux (Linux). In order to enable development on macOS and Windows as well as to support miscellaneous Linux variants more easily, Sailfish SDK encapsulates its back-end in a virtual machine running a specifically tailored Linux distribution, the so called SDK Build Engine.

In addition to that, Sailfish SDK provides virtualized runtime environment for testing Sailfish OS applications - the Sailfish OS Emulator.

On Linux and Windows, both Oracle VM VirtualBox (version 4.1.18 or higher) and Docker (version 18.09.3 or higher) are supported by the SDK Build Engine. On macOS, only VirtualBox is supported.

  - Oracle VM VirtualBox\
    ➕ Fully fledged solution\
    ➖ Less optimal build performance
  - Docker\
    ➕ Optimal build performance\
    ➖ Not as matured as the other option\
    ➖ Compatibility issues with Sailfish OS emulators (Windows only)

For Sailfish OS Emulator, Oracle VM VirtualBox is needed regardless of the host platform.

On Linux, you should install the virtualization platform packages supplied by your distribution. On other operating systems, we recommend using installation packages from <http://www.virtualbox.org> or <https://hub.docker.com/search/?q=&type=edition>.

A few hints on Docker installation:

  - Follow the [generic instructions](https://hub.docker.com/search/?type=edition&offering=community)
  - Linux users may need
    - [extra steps](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user) to ensure that Sailfish SDK can manage Docker as a non-root user
    - [extra steps](https://blog.christophersmart.com/2019/12/15/enabling-docker-in-fedora-31-by-reverting-to-cgroups-v1/) to ensure their host is using cgroups v1
  - Windows users should ensure that Docker is set up to use [Linux containers](https://docs.docker.com/desktop/windows/#switch-between-windows-and-linux-containers) (instead of Windows containers)

### MSYS2 (Windows only)

MSYS2 is not just the recommended environment in case you plan command line use of Sailfish SDK on Windows. It also satisfies certain dependencies of the Sailfish IDE.

Follow the general installation instructions on <https://www.msys2.org/>, then install the tools required by Sailfish SDK by issuing the following command under the shell invoked with the "MSYS2 MSYS" Start menu item:

    pacman -S --needed base-devel git

You may also consider configuring MSYS2 to use your Windows user home directory. Otherwise it will use a directory located under MSYS2 installation directory. This can be changed by editing `/etc/nsswitch.conf` under MSYS2 shell, applying the following configuration:

    db_home: windows cygwin desc

_Sailfish SDK 3.6 and older:_ Ensure that the `usr\bin` directory from MSYS2 installation tree is on Windows PATH.

### System Requirements
  - About 15GB of free disk space for the default component selection
  - 4GB of RAM or more is recommended.

### Others

#### libtinfo.so.5 (Linux only)

In order to maintain compatibility with older Linux distributions, Sailfish SDK links to this library, which is usually not installed by default on more recent distributions:

  - On Ubuntu 20.04, the package libtinfo5 must be installed
  - On Fedora the package ncurses-compat-libs must be installed
  - If you find no way to fix libtinfo.so.5 on your system, you may try creating it as a symbolic link to your system libncurses.so.5 (or even libncurses.so.6 or libtinfo.so.6)

#### Modern bash

_Sailfish SDK 3.7 and newer._

Command completion for sfdk, the command line frontend to the Sailfish SDK, is only provided for bash shell interpreter. This requirement concerns especially macOS users, where the default shell is either a too old bash or zsh. If you plan to use Sailfish SDK from CLI on macOS, it is recommended to use newer `bash` and `bash-completion@2` packages from [Homebrew](https://brew.sh).

See also [Sailfish SDK Known Issues](/Tools/Sailfish_SDK/Known_Issues).

## Sailfish SDK Installer

### SDK Installer on Linux

1.  [Download](/Tools/Sailfish_SDK#latest-sdk-release) the run file
2.  Open the Terminal application on your host system.
3.  Provide executable permissions to it: `$ chmod +x ~/Downloads/<installer_name>`
4.  Run the installer as a normal user (i.e. not as root user). By default it will install to `SailfishOS/` in your home directory.
    ```
    $ ./Downloads/<installer_name>
    ```

### SDK Installer on Windows

1.  [Download](/Tools/Sailfish_SDK#latest-sdk-release) SDK Installer application to your downloads folder and locate it with Explorer.
2.  Open SDK installer by double-clicking the SDK Installer application.

### SDK Installer on OS X

1.  [Download](/Tools/Sailfish_SDK#latest-sdk-release) SDK Installer package.
2.  Open SDK Installer package by double-clicking the icon.
3.  Open the SDK Installer application found from the package.

## Common installation flow

The SDK installer window will open as shown below. The installation itself is pretty simple.

<a href="Installer_01.png" style="width:30em;display:block">
    <img src="Installer_01.png"
         alt="Installer_01.png"
         class="md_thumbnail" style="max-width:100%"/>
</a>

Click **Next**, follow the setup wizard and read and accept the license agreement. The default values are usually OK. If you wish, you can see the details of the files being installed. After a successful installation you should see a window like the one shown below.

<a href="Installer_02.png" style="width:30em;display:block">
    <img src="Installer_02.png"
         alt="Installer_02.png"
         class="md_thumbnail" style="max-width:100%"/>
</a>

Click **Finish**. The Sailfish IDE launches automatically once the setup wizard exits.

## Launching the Sailfish IDE

  - The SDK will be added to your system menus and a launch icon will be available for future sessions.
  - On Linux you can launch the Sailfish IDE from desktop launcher by typing `Sailfish IDE` and choosing the appropriate icon. Alternatively, you can stat it from command line by running `~/SailfishOS/bin/qtcreator`.
  - On Windows you can launch the Sailfish IDE by pressing Start and typing `Sailfish IDE` and choosing the appropriate application.
  - On OS X you can launch the Sailfish IDE by opening Launchpad and typing `Sailfish IDE`. (With Spotlight it can be found by typing `Qt Creator`.)

Once the SDK is installed, proceed to creating your [first application](/Tools/Sailfish_SDK/#guides)!
