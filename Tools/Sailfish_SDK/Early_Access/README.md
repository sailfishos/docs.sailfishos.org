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

## Early Access Build Targets

The early access build targets are supported in both the Sailfish SDK and Sailfish SDK Early Access releases.

The latest early access targets can be installed by using the SDKMaintenanceTool:

1\. Open the **SDKMaintenanceTool**

2\. Choose **Add or remove components** and click **Continue**

3\. Click the **Sailfish OS Build Targets** branch open from the components list

4\. **Check** `SailfishOS-ea-armv7hl` and/or `SailfishOS-ea-i486` component(s) for installation

5\. Click **Continue** and follow through with the installation

The early access build targets will be released in sync with the early access releases of the Sailfish OS. Generally these releases will be available about a week earlier than the official public release. This allows developers to test and refine their apps before the public release.

If you have installed an early access build target or targets by using the SDKMaintenanceTool, you will get an update notification automatically when a newer early access build target release is available.

Please, remember, that the Early Access build targets should not be used for submitting apps to the Jolla Harbour. For that purpose, you should always use the latest non-EA (`SailfishOS-latest-armv7hl` or `SailfishOS-latest-i486`) build targets.

## Latest Early Access SDK Release

The latest Sailfish SDK Early Access release can be downloaded for Linux, macOS and Windows platforms from below.

### **Sailfish SDK 3.7**

| Linux                                                                                                                                 | macOS                                                                                                                         | Windows                                                                                                                               |
| ------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------- |
| [**SailfishSDK-3.7.4-linux64-online.run**](https://releases.sailfishos.org/sdk/installers/3.7.4/SailfishSDK-3.7.4-linux64-online.run) | [**SailfishSDK-3.7.4-mac-online.dmg**](https://releases.sailfishos.org/sdk/installers/3.7.4/SailfishSDK-3.7.4-mac-online.dmg) | [**SailfishSDK-3.7.4-windows-online.exe**](https://releases.sailfishos.org/sdk/installers/3.7.4/SailfishSDK-3.7.4-windows-online.exe) |

**Please, read the section [Installing the Early Access SDK](/Tools/Sailfish_SDK/Early_Access#installing-the-early-access-sdk) before using these installers. The Early Access SDK repository should be taken into use before installation.**

### Release Notes

The release notes for this SDK release are available at [Sailfish OS Forum](https://forum.sailfishos.org/t/8418).

### All Download Options

| Filename                                                                                                                                | Size                    | MD5 Hash                                                                                                                               |
| --------------------------------------------------------------------------------------------------------------------------------------- | ----------------------- | -------------------------------------------------------------------------------------------------------------------------------------- |
| [**SailfishSDK-3.7.4-linux64-online.run**](https://releases.sailfishos.org/sdk/installers/3.7.4/SailfishSDK-3.7.4-linux64-online.run)   | 29M (29628362 bytes)    | [**e5caa5554479801e9d9a06bf31df24df**](https://releases.sailfishos.org/sdk/installers/3.7.4/SailfishSDK-3.7.4-linux64-online.run.md5)  |
| [**SailfishSDK-3.7.4-linux64-offline.run**](https://releases.sailfishos.org/sdk/installers/3.7.4/SailfishSDK-3.7.4-linux64-offline.run) | 1.9G (1961066832 bytes) | [**e6ae951b68f8ce70b446010074ed0627**](https://releases.sailfishos.org/sdk/installers/3.7.4/SailfishSDK-3.7.4-linux64-offline.run.md5) |
| [**SailfishSDK-3.7.4-mac-online.dmg**](https://releases.sailfishos.org/sdk/installers/3.7.4/SailfishSDK-3.7.4-mac-online.dmg)           | 12M (11815265 bytes)    | [**f0eaec693a380fb9f7e25c8d3ad3385b**](https://releases.sailfishos.org/sdk/installers/3.7.4/SailfishSDK-3.7.4-mac-online.dmg.md5)      |
| [**SailfishSDK-3.7.4-mac-offline.dmg**](https://releases.sailfishos.org/sdk/installers/3.7.4/SailfishSDK-3.7.4-mac-offline.dmg)         | 1.8G (1890551500 bytes) | [**12821553bc3ae727b2d20a2031e56007**](https://releases.sailfishos.org/sdk/installers/3.7.4/SailfishSDK-3.7.4-mac-offline.dmg.md5)     |
| [**SailfishSDK-3.7.4-windows-online.exe**](https://releases.sailfishos.org/sdk/installers/3.7.4/SailfishSDK-3.7.4-windows-online.exe)   | 24M (25007428 bytes)    | [**128d1f23f1904b3183f90608c1dd4dbf**](https://releases.sailfishos.org/sdk/installers/3.7.4/SailfishSDK-3.7.4-windows-online.exe.md5)  |
| [**SailfishSDK-3.7.4-windows-offline.exe**](https://releases.sailfishos.org/sdk/installers/3.7.4/SailfishSDK-3.7.4-windows-offline.exe) | 1.8G (1862533524 bytes) | [**b592b190a4302b8f8a800c46edb8a932**](https://releases.sailfishos.org/sdk/installers/3.7.4/SailfishSDK-3.7.4-windows-offline.exe.md5) |

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
