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

### **Sailfish SDK 3.6**

| Linux                                                                                                                                 | macOS                                                                                                                         | Windows                                                                                                                               |
| ------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------- |
| [**SailfishSDK-3.6.6-linux64-online.run**](https://releases.sailfishos.org/sdk/installers/3.6.6/SailfishSDK-3.6.6-linux64-online.run) | [**SailfishSDK-3.6.6-mac-online.dmg**](https://releases.sailfishos.org/sdk/installers/3.6.6/SailfishSDK-3.6.6-mac-online.dmg) | [**SailfishSDK-3.6.6-windows-online.exe**](https://releases.sailfishos.org/sdk/installers/3.6.6/SailfishSDK-3.6.6-windows-online.exe) |

**Please, read the section [Installing the Early Access SDK](/Tools/Sailfish_SDK/Early_Access#installing-the-early-access-sdk) before using these installers. The Early Access SDK repository should be taken into use before installation.**

### Release Notes

The release notes for this SDK release are available at [Sailfish OS Forum](https://forum.sailfishos.org/t/8418).

### All Download Options

| Filename                                                                                                                                | Size                    | MD5 Hash                                                                                                                               |
| --------------------------------------------------------------------------------------------------------------------------------------- | ----------------------- | -------------------------------------------------------------------------------------------------------------------------------------- |
| [**SailfishSDK-3.6.6-linux64-online.run**](https://releases.sailfishos.org/sdk/installers/3.6.6/SailfishSDK-3.6.6-linux64-online.run)   | 29M (29628354 bytes)    | [**e86ea72e4748ff66b592376cfcd0bf4e**](https://releases.sailfishos.org/sdk/installers/3.6.6/SailfishSDK-3.6.6-linux64-online.run.md5)  |
| [**SailfishSDK-3.6.6-linux64-offline.run**](https://releases.sailfishos.org/sdk/installers/3.6.6/SailfishSDK-3.6.6-linux64-offline.run) | 1.9G (1970062868 bytes) | [**3aeef76effa725b93ebce69a7ab145db**](https://releases.sailfishos.org/sdk/installers/3.6.6/SailfishSDK-3.6.6-linux64-offline.run.md5) |
| [**SailfishSDK-3.6.6-mac-online.dmg**](https://releases.sailfishos.org/sdk/installers/3.6.6/SailfishSDK-3.6.6-mac-online.dmg)           | 12M (11815299 bytes)    | [**5848607e1da2f5c5cea84b8e5e642699**](https://releases.sailfishos.org/sdk/installers/3.6.6/SailfishSDK-3.6.6-mac-online.dmg.md5)      |
| [**SailfishSDK-3.6.6-mac-offline.dmg**](https://releases.sailfishos.org/sdk/installers/3.6.6/SailfishSDK-3.6.6-mac-offline.dmg)         | 1.8G (1899423995 bytes) | [**1ac0c8656f5dbbfd682319e339eaf4e6**](https://releases.sailfishos.org/sdk/installers/3.6.6/SailfishSDK-3.6.6-mac-offline.dmg.md5)     |
| [**SailfishSDK-3.6.6-windows-online.exe**](https://releases.sailfishos.org/sdk/installers/3.6.6/SailfishSDK-3.6.6-windows-online.exe)   | 24M (25007420 bytes)    | [**0dfe7371247f5f705bf1b22d4a6632c4**](https://releases.sailfishos.org/sdk/installers/3.6.6/SailfishSDK-3.6.6-windows-online.exe.md5)  |
| [**SailfishSDK-3.6.6-windows-offline.exe**](https://releases.sailfishos.org/sdk/installers/3.6.6/SailfishSDK-3.6.6-windows-offline.exe) | 1.8G (1871530495 bytes) | [**1614977215826ab98da5f0c84464cc6e**](https://releases.sailfishos.org/sdk/installers/3.6.6/SailfishSDK-3.6.6-windows-offline.exe.md5) |

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
