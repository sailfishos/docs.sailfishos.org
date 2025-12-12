---
title: Target Installation
permalink: Tools/Platform_SDK/Target_Installation/
parent: Sailfish Platform SDK
layout: default
nav_order: 200
---

## Sailfish Platform SDK Targets and Toolings

Sailfish SDK abstracts the support for cross-development for particular target HW architectures and Sailfish OS versions (forward compatibility applies) in form of add-on SDK Build Tools.

Two types of SDK Build Tools are recognized:

1. SDK Build Target - a target-compatible Sailfish OS image, and
2. SDK Build Tooling - a host-compatible collection of programs used at build time.

The shorter terms "build tools", "(build) tooling(s)" and "(build) target(s)" are used instead of the official terms where the context admits.

Single build tooling is required to enable development for a particular Sailfish OS version, accompanied with one or more build targets for each target HW architecture to support.

## Installing SDK Targets and Tooling Tarballs

Build targets and tooling images matching the latest public releases of Sailfish OS can be downloaded through the following links:

* [Sailfish_OS-latest-Sailfish_SDK_Tooling-i486.tar.7z](https://releases.sailfishos.org/sdk/targets/Sailfish_OS-latest-Sailfish_SDK_Tooling-i486.tar.7z) ([md5](https://releases.sailfishos.org/sdk/targets/Sailfish_OS-latest-Sailfish_SDK_Tooling-i486.tar.7z.md5sum))
* [Sailfish_OS-latest-Sailfish_SDK_Target-aarch64.tar.7z](https://releases.sailfishos.org/sdk/targets/Sailfish_OS-latest-Sailfish_SDK_Target-aarch64.tar.7z) ([md5](https://releases.sailfishos.org/sdk/targets/Sailfish_OS-latest-Sailfish_SDK_Target-aarch64.tar.7z.md5sum))
* [Sailfish_OS-latest-Sailfish_SDK_Target-armv7hl.tar.7z](https://releases.sailfishos.org/sdk/targets/Sailfish_OS-latest-Sailfish_SDK_Target-armv7hl.tar.7z) ([md5](https://releases.sailfishos.org/sdk/targets/Sailfish_OS-latest-Sailfish_SDK_Target-armv7hl.tar.7z.md5sum))
* [Sailfish_OS-latest-Sailfish_SDK_Target-i486.tar.7z](https://releases.sailfishos.org/sdk/targets/Sailfish_OS-latest-Sailfish_SDK_Target-i486.tar.7z) ([md5](https://releases.sailfishos.org/sdk/targets/Sailfish_OS-latest-Sailfish_SDK_Target-i486.tar.7z.md5sum))

Images corresponding to other releases, including the Early Access release, may be found on the [full list](https://releases.sailfishos.org/sdk/targets/).

Use the sdk-assistant tool within Sailfish Platform SDK to create new targets and toolings from the downloaded images:
```nosh
sdk-assistant create SailfishOS-latest Sailfish_OS-latest-Sailfish_SDK_Tooling-i486.tar.7z
sdk-assistant create SailfishOS-latest-armv7hl Sailfish_OS-latest-Sailfish_SDK_Target-armv7hl.tar.7z
sdk-assistant create SailfishOS-latest-aarch64 Sailfish_OS-latest-Sailfish_SDK_Target-aarch64.tar.7z
sdk-assistant create SailfishOS-latest-i486 Sailfish_OS-latest-Sailfish_SDK_Target-i486.tar.7z
```

You will always install SDK tooling before SDK targets that depends on that tooling. Removal would be done in the opposite order. Note that while SDK targets are target-cpu specific, SDK toolings are always i486 which is the only supported host platform.

You can also use a direct URL with this tool:

```nosh
sdk-assistant create SailfishOS-latest https://releases.sailfishos.org/sdk/targets/Sailfish_OS-latest-Sailfish_SDK_Tooling-i486.tar.7z
sdk-assistant create SailfishOS-latest-armv7hl https://releases.sailfishos.org/sdk/targets/Sailfish_OS-latest-Sailfish_SDK_Target-armv7hl.tar.7z
sdk-assistant create SailfishOS-latest-aarch64 https://releases.sailfishos.org/sdk/targets/Sailfish_OS-latest-Sailfish_SDK_Target-aarch64.tar.7z
sdk-assistant create SailfishOS-latest-i486 https://releases.sailfishos.org/sdk/targets/Sailfish_OS-latest-Sailfish_SDK_Target-i486.tar.7z
```

This will create three generic (i.e., hardware agnostic) SDK targets, "SailfishOS-latest-armv7hl" for ARMv7, "SailfishOS-latest-aarch64" for ARM64, and "SailfishOS-latest-i486" for i486 platform. Their names are to be used as an argument to `mb2`'s `-t` option. The single created SDK tooling "SailfishOS-latest" will be picked up automatically based on the OS release. If multiple toolings exist for one OS release, the selection can be done explicitly with the `--tooling <name>` option.

You can also use this tool for listing your installed toolings and targets:
```nosh
sdk-assistant list
```

And for removing them:

```nosh
sdk-assistant remove <tooling-or-target-name>
```

It also supports updating a target and the tooling used by the target in one step:

```nosh
sdk-assistant update <target-name>
```

This is also the recommented way of updating SDK targets - it can save you from some known issues with the upgrading process in special cases.

See `sdk-assistant --help` for more information.

## Separate Targets

It is often useful to have separate targets for different devices as well as for different architectures, in case some particular package you are building requires low-level, hardware specific packages. An example of this is Hybris-related components. In general, these have to be built against hardware-specific libraries, and so for these it is usually best to create a separate, device-specific target to build your package in.

In most SDK targets, hardware agnostic libraries are provided where possible. For example, Mesa3D libraries provide the OpenGL symbols to avoid requiring hardware-specific libraries to be installed into a generic ARMv7 arch SDK target.
