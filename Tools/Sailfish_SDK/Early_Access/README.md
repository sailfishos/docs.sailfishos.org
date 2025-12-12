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

Please, remember, that the Early Access build targets should not be used for submitting apps to the Jolla Harbour. For that purpose, you should always use the latest non-EA (`SailfishOS-latest-<arch>`) build targets.

## Latest Early Access SDK Release

The latest Sailfish SDK Early Access release can be downloaded for Linux, macOS and Windows platforms from below.

### **Sailfish SDK 3.12**

| Linux                                                                                                                                 | macOS                                                                                                                         | Windows                                                                                                                               |
| ------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------- |
| [**SailfishSDK-3.12.5-linux64-online.run**](https://releases.sailfishos.org/sdk/installers/3.12.5/SailfishSDK-3.12.5-linux64-online.run) | [**SailfishSDK-3.12.5-mac-online.dmg**](https://releases.sailfishos.org/sdk/installers/3.12.5/SailfishSDK-3.12.5-mac-online.dmg) | [**SailfishSDK-3.12.5-windows-online.exe**](https://releases.sailfishos.org/sdk/installers/3.12.5/SailfishSDK-3.12.5-windows-online.exe) |

**Please, read the section [Installing the Early Access SDK](/Tools/Sailfish_SDK/Early_Access#installing-the-early-access-sdk) before using these installers. The Early Access SDK repository should be taken into use before installation.**

### Release Notes

The release notes for this SDK release are available at [Sailfish OS Forum](https://forum.sailfishos.org/t/22398).

### All Download Options

| Filename                                                                                                                                   | Size                    | MD5 Hash                                                                                                                                 |
| ------------------------------------------------------------------------------------------------------------------------------------------ | ----------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| [**SailfishSDK-3.12.5-linux64-online.run**](https://releases.sailfishos.org/sdk/installers/3.12.5/SailfishSDK-3.12.5-linux64-online.run)   | 29M (30408499 bytes)    | [**5f2ac9667bd0e0a12f43576b0dc88a12**](https://releases.sailfishos.org/sdk/installers/3.12.5/SailfishSDK-3.12.5-linux64-online.run.md5)  |
| [**SailfishSDK-3.12.5-linux64-offline.run**](https://releases.sailfishos.org/sdk/installers/3.12.5/SailfishSDK-3.12.5-linux64-offline.run) | 2.1G (2239911139 bytes) | [**2077416d0ed0898ce599eeba343d915c**](https://releases.sailfishos.org/sdk/installers/3.12.5/SailfishSDK-3.12.5-linux64-offline.run.md5) |
| [**SailfishSDK-3.12.5-mac-online.dmg**](https://releases.sailfishos.org/sdk/installers/3.12.5/SailfishSDK-3.12.5-mac-online.dmg)           | 12M (11840636 bytes)    | [**5c371c8c357ca6835b1f3b3737e82d51**](https://releases.sailfishos.org/sdk/installers/3.12.5/SailfishSDK-3.12.5-mac-online.dmg.md5)      |
| [**SailfishSDK-3.12.5-mac-offline.dmg**](https://releases.sailfishos.org/sdk/installers/3.12.5/SailfishSDK-3.12.5-mac-offline.dmg)         | 2.0G (2103701314 bytes) | [**4334e72b25cccd719bc2e0dc3912a637**](https://releases.sailfishos.org/sdk/installers/3.12.5/SailfishSDK-3.12.5-mac-offline.dmg.md5)     |
| [**SailfishSDK-3.12.5-windows-online.exe**](https://releases.sailfishos.org/sdk/installers/3.12.5/SailfishSDK-3.12.5-windows-online.exe)   | 25M (25211087 bytes)    | [**ea3f28a9812c20302db0b4fe2562ec9a**](https://releases.sailfishos.org/sdk/installers/3.12.5/SailfishSDK-3.12.5-windows-online.exe.md5)  |
| [**SailfishSDK-3.12.5-windows-offline.exe**](https://releases.sailfishos.org/sdk/installers/3.12.5/SailfishSDK-3.12.5-windows-offline.exe) | 2.0G (2133646866 bytes) | [**bdeda9a2db1c28e9742862ca752f2bd6**](https://releases.sailfishos.org/sdk/installers/3.12.5/SailfishSDK-3.12.5-windows-offline.exe.md5) |


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
