---
title: Uninstallation
permalink: Tools/Sailfish_SDK/Uninstallation/
parent: Sailfish SDK
layout: default
nav_order: 700
---

## SDK Uninstallation

The Sailfish SDK comes with a maintenance tool, named `SDKMaintenanceTool` that can be used to remove the complete installation (for Windows 8 read [known issues](/Tools/Sailfish_SDK/Known_Issues)). You can find it listed in your host distribution’s system menu or directly in the installed directory, for example in Linux `~/SailfishOS`.

### Pre-requisites

  - The emulator and build engine virtual machines are powered off.
  - The VirtualBox software is not running.
  - The Sailfish IDE (Qt Creator) is not running.

### Uninstallation

Run the SDKMaintenanceTool

  - On Linux open terminal and type `$ ~/SailfishOS/SDKMaintenanceTool`
  - On Windows press Start and type `SDKMaintenanceTool`
  - In OS X open Spotlight (cmd+space) and type `SDKMaintenanceTool`

Select **Remove all components** and click **Next**.

<a href="Uninstall_01.png" style="width:30em;display:block">
    <img src="Uninstall_01.png"
         alt="Uninstall_01.png"
         class="md_thumbnail" style="max-width:100%"/>
</a>

Follow the instructions on the wizard. Once the uninstallation has completed successfully, you will see the following screen. Click **Finish** to exit the wizard.

<a href="Uninstall_02.png" style="width:30em;display:block">
    <img src="Uninstall_02.png"
         alt="Uninstall_02.png"
         class="md_thumbnail" style="max-width:100%"/>
</a>
