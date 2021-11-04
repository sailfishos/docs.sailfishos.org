---
title: Software Packaging
permalink: Reference/Software_Packaging/
layout: default
nav_order: 200
---

Sailfish OS uses modern software packaging systems to allow controlled over-the-air updates. A given device will be registered for a specific variation of the operating system, where the variant specifies which packages (and which versions of which packages) that device should have access to.

## Device Variants

Each device variant is defined by a pattern file which describes the initial filesystem content and packages to be installed in the device. Device variants can be defined for different regions, different operators, different device platforms, or any combination of those or other variation inputs. Individual variants can have entirely different content or packages defined, and the patterns are defined in such a way to maximise reuse capability while minimising maintenance overhead, while enforcing variant segregation at both image-creation and device-update stages of the product lifecycle.

The variation system also allows for vendor-specific licenses, artwork, and other content to be preinstalled on the devices they ship, via package inclusion or via a secure filesystem partition.

Please see the documentation about [SSU](/Services/Deployment/SSU) and about the [Store](/Services/Deployment/Store) for more information about the deployment services for Sailfish OS and how updates are controlled for specific variants.

## RPM

Sailfish OS uses RPM packages to handle native software distribution, [ which can be build using the SDK](/Tools/Sailfish_SDK/Building_packages). PackageKit with libzypp backend are used as the middleware components to handle the on-device RPM database. It supports binary diffing and delta-rpm package upgrades to minimise bandwidth required for package upgrades.

### RPM packaging Guidelines

We are following quite closely Fedora's packaging guidelines, which you can read from <https://docs.fedoraproject.org/en-US/packaging-guidelines/>

#### Recent changes in Sailfish OS packaging

  - **URL** should point to our upstream git tree location for open source packages, e.g. <https://github.com/sailfishos/sailjail>, to ensure that it is easy to find where the package is located, see more info of the current locations at [Sailfish OS Source](/Services/Development/Sailfish_OS_Source)
  - For any license files one should have them marked with **%license** macro instead of **%doc** macro, more info at <https://docs.fedoraproject.org/en-US/packaging-guidelines/LicensingGuidelines/>
  - Ensure that opensource license strings in **License:** match to shortnames at <https://fedoraproject.org/wiki/Licensing:Main#Software_License_List>
  - **Group:**, **Buildroot:** and **%clean** should not be used, see also <https://docs.fedoraproject.org/en-US/packaging-guidelines/#_tags_and_sections>
  - Use **%autosetup** instead of **%setup**
  - Packages having .desktop files don't need to anymore manually execute update-desktop-database in %post or %postun. It's now automatically handled by rpm file triggers.

#### Differences to Fedora guidelines

  - For [tar_git](/Tools/Sailfish_SDK/Building_packages#tar-git-packaging-structure) based packages the **Source:** line should be in format %{name}-%{version}.tar.bz2

## APK

Sailfish OS with Android App Support, can use applications in apk format from Android. One core service provided by Sailfish OS is called apkd, which mediates installation, deinstallation, upgrades and other interaction with apk packages within Sailfish OS.

## Commands

[Sailfish OS Cheat Sheet](/Reference/Sailfish_OS_Cheat_Sheet#package-handling) lists the most common package handling commands.
