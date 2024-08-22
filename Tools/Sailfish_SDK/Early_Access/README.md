---
title: Early Access
permalink: Tools/Sailfish_SDK/Early_Access/
parent: Sailfish SDK
layout: default
nav_order: 600
---

## Early Access SDK

Sailfish SDK Early Access releases will provide the new SDK features and fixes a week or two before the final SDK release. By using the Early Access SDK you can be sure to get the latest and greatest SDK features first.

If you are looking for the regular SDK release or general information about the SDK itself, check out the [Sailfish SDK](/Tools/Sailfish_SDK) page.

## Early Access Build Targets and Emulator

The early access build targets and emulator are supported in both the Sailfish SDK and Sailfish SDK Early Access releases.

Installation is possible by using the SDKMaintenanceTool:

1\. Open the **SDKMaintenanceTool**

2\. Choose **Add or remove components** and click **Continue**

3\. Click the **Build Targets** branch open from the components list and check any of those `SailfishOS-ea-<arch>` component(s) for installation

4\. Click the **Emulators** branch open from the components list and check the `SailfishOS-ea` component for installation

5\. Click **Continue** and follow through with the installation

Unattended installation is possible with the `sfdk tools install` and `sfdk emulator install` commands.

The early access build targets and emulator will be released in sync with the early access releases of the Sailfish OS. Generally these releases will be available about a week earlier than the official public release. This allows developers to test and refine their apps before the public release.

If you have installed early access build targets or emulators, you will get an update notification under the Sailfish IDE automatically when a newer early access release is available.

Please, remember, that the Early Access build targets should not be used for submitting apps to the Jolla Harbour. For that purpose, you should always use the latest non-EA (`SailfishOS-latest-armv7hl` or `SailfishOS-latest-i486`) build targets.

## Latest Early Access SDK Release

The latest Sailfish SDK Early Access release can be downloaded for Linux, macOS and Windows platforms from below.

### **Sailfish SDK 3.11**

| Linux                                                                                                                                 | macOS                                                                                                                         | Windows                                                                                                                               |
| ------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------- |
| [**SailfishSDK-3.11.1-linux64-online.run**](https://releases.sailfishos.org/sdk/installers/3.11.1/SailfishSDK-3.11.1-linux64-online.run) | [**SailfishSDK-3.11.1-mac-online.dmg**](https://releases.sailfishos.org/sdk/installers/3.11.1/SailfishSDK-3.11.1-mac-online.dmg) | [**SailfishSDK-3.11.1-windows-online.exe**](https://releases.sailfishos.org/sdk/installers/3.11.1/SailfishSDK-3.11.1-windows-online.exe) |

**Please, read the section [Installing the Early Access SDK](/Tools/Sailfish_SDK/Early_Access#installing-the-early-access-sdk) before using these installers. The Early Access SDK repository should be taken into use before installation.**

### Release Notes

The release notes for this SDK release are available at [Sailfish OS Forum](https://forum.sailfishos.org/t/19748).

### All Download Options

| Filename                                                                                                                                   | Size                    | MD5 Hash                                                                                                                                 |
| ------------------------------------------------------------------------------------------------------------------------------------------ | ----------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| [**SailfishSDK-3.11.1-linux64-online.run**](https://releases.sailfishos.org/sdk/installers/3.11.1/SailfishSDK-3.11.1-linux64-online.run)   | 29M (30408496 bytes)    | [**2305fc4658fc88a34eee32eb88abcfa4**](https://releases.sailfishos.org/sdk/installers/3.11.1/SailfishSDK-3.11.1-linux64-online.run.md5)  |
| [**SailfishSDK-3.11.1-linux64-offline.run**](https://releases.sailfishos.org/sdk/installers/3.11.1/SailfishSDK-3.11.1-linux64-offline.run) | 2.1G (2240528607 bytes) | [**29ff20aa4496718a6c9daffcd3c8adf3**](https://releases.sailfishos.org/sdk/installers/3.11.1/SailfishSDK-3.11.1-linux64-offline.run.md5) |
| [**SailfishSDK-3.11.1-mac-online.dmg**](https://releases.sailfishos.org/sdk/installers/3.11.1/SailfishSDK-3.11.1-mac-online.dmg)           | 12M (11840243 bytes)    | [**bc3c3be651b8ae3eeed0ad0295e26ffb**](https://releases.sailfishos.org/sdk/installers/3.11.1/SailfishSDK-3.11.1-mac-online.dmg.md5)      |
| [**SailfishSDK-3.11.1-mac-offline.dmg**](https://releases.sailfishos.org/sdk/installers/3.11.1/SailfishSDK-3.11.1-mac-offline.dmg)         | 2.0G (2104320962 bytes) | [**61f37f813a6c7aebec48479ffbb316ec**](https://releases.sailfishos.org/sdk/installers/3.11.1/SailfishSDK-3.11.1-mac-offline.dmg.md5)     |
| [**SailfishSDK-3.11.1-windows-online.exe**](https://releases.sailfishos.org/sdk/installers/3.11.1/SailfishSDK-3.11.1-windows-online.exe)   | 25M (25211084 bytes)    | [**4b05a93fe76284392e1729b7ae69f634**](https://releases.sailfishos.org/sdk/installers/3.11.1/SailfishSDK-3.11.1-windows-online.exe.md5)  |
| [**SailfishSDK-3.11.1-windows-offline.exe**](https://releases.sailfishos.org/sdk/installers/3.11.1/SailfishSDK-3.11.1-windows-offline.exe) | 2.0G (2134264291 bytes) | [**b64cf64b7168e4504da194bcf768e913**](https://releases.sailfishos.org/sdk/installers/3.11.1/SailfishSDK-3.11.1-windows-offline.exe.md5) |

Offline installers allow Sailfish SDK installation with VirtualBox-based build engine, latest build targets and latest emulator on hosts with limited network access.

## Installing the Early Access SDK

1\. Follow the regular [installation instructions](/Tools/Sailfish_SDK/Installation) up to the point where the Sailfish SDK installer is running and the initial screen is displayed

2\. Click **Settings**

3\. Go to the **Repositories** page

4\. **Uncheck** (Disable) the `updates` repository

5\. **Check** (Enable) the `updates-ea` repository

6\. Click **OK** and return to the regular installation instructions left in step 1

## Enabling Early Access SDK Updates

If you installed the regular SDK before and you want to start receiving the Early Access SDK updates now, enable the Early Access repository in your SDK:

1\. Open the **SDKMaintenanceTool**

2\. Choose **Update components**

3\. Click **Settings**

4\. Go to the **Repositories** page

5\. **Uncheck** (Disable) the `updates` repository

6\. **Check** (Enable) the `updates-ea` repository

7\. Click **OK** and check for updates
