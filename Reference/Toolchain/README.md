---
title: Toolchain
permalink: Reference/Toolchain/
layout: default
nav_order: 700
---

## Sailfish SDK Toolchain

### Scratchbox 2

Sailfish SDK builds on the Scratchbox 2 cross-compilation toolkit. Scratchbox 2 solves the problem of cross-compilation by creating a virtual development environment that looks like a target system while allowing execution of both target-compatible and host-compatible binaries transparently (where "host" means the machine where software is built).

Scratchbox 2 achieves this by employing target CPU emulation and by composing a single virtual file system view from four physical locations:

  - Host filesystem
      - Contains Scratchbox 2 itself
      - Contains generic (as opposite to target-specific) tools (e.g SCM tools, build automation tools, code editors)
      - Host-compatible binaries

<!-- end list -->

  - Tools distribution
      - Contains target-specific tools (e.g. cross-compiler toolchain)
      - Host-compatible binaries

<!-- end list -->

  - Target device filesystem image
      - Target-compatible binaries
      - Target device filesystem image is needed for each architecture (armv7hl, aarch64, i486)

<!-- end list -->

  - User's working directory
      - Contains source code and build artefacts
      - Target-compatible binaries

The existence of the Tools distribution concept enables development for different target operating systems within single SDK installation.

Here is how the terms native to Scratchbox 2 map to the terms used in Sailfish SDK:

| Scratchbox 2                   | Sailfish SDK           |
| ------------------------------ | ---------------------- |
| Host filesystem                | SDK Build Engine       |
| Tools distribution             | SDK Build Tooling (\*) |
| Target device filesystem image | SDK Build Target       |

(\*) The word "tooling" is used instead of "tools" simply for the possibility to distinguish single from multiple.

Depending on your choice of SDK, please see their corresponding documentation pages for listing and interacting with the toolings and targets: [Sailfish Platform SDK](/Tools/Platform_SDK/Building_Packages#listing-installed-build-targets) and [Sailfish SDK](/Tools/Sailfish_SDK/Building_packages#building-packages-locally)

You can find more information about the internal working of Scratchbox 2 in the [original documentation](https://github.com/sailfishos/scratchbox2/blob/master/docs/SB2_internals_1st_ed_20120425.pdf).

### Build Tools

The cross-compilation toolchain consists of Linaro GCC, the GNU ld linker and GNU libc, run within a ScratchBox 2 virtual machine within the SDK Build Engine. As described before, a single Sailfish SDK installation can include multiple SDK Build Targets. Any particular build target is used to perform builds for a specific HW architecture (e.g., armv7, i586, etc) and OS version. You can check to see which version of the build tools are installed for a given architecture and OS version by checking the version of the `cross-[arch]-gcc` and `cross-[arch]-binutils` packages under the corresponding SDK Build Tooling.

For example:
```
$ sfdk tools list
SailfishOS-4.3.0.12              sdk-provided,latest
├── SailfishOS-4.3.0.12-aarch64  sdk-provided,latest
├── SailfishOS-4.3.0.12-armv7hl  sdk-provided,latest
└── SailfishOS-4.3.0.12-i486     sdk-provided,latest
$ sfdk tools exec SailfishOS-4.3.0.12 zypper info cross-armv7hl-gcc
...
Name           : cross-armv7hl-gcc
Version        : 8.3.0-1.2.7.jolla
...
```

It is this version of GCC which will be available within a build shell when the corresponding build target is used.

For example:
```nosh
$ sfdk config --push target SailfishOS-4.3.0.12-armv7hl
$ sfdk build-shell
[SailfishOS-4.3.0.12-armv7hl] ~ $ gcc -v
...
gcc version 8.3.0 20190222 (Sailfish OS gcc 8.3.0-3) (Linaro GCC 8.2-2018.08~dev)
```

Note that to build packages, the build-shell prompt is not usually necessary as the `sfdk build` and related commands perform all the necessary steps to build and package a project for the developer.

### Other Tools

There are tools that are not meant to be used from the build shell, i.e., under Scratchbox 2. This is also the case of higher level tools which themselves use Scratchbox 2, like `mic` for image creation and `osc` for OBS integration. These tools are available directly from the build engine shell:
```nosh
$ sfdk engine exec mic ...
```

## Android BSP Support

Sailfish OS utilises [libhybris](https://github.com/libhybris/libhybris) to leverage existing Android board support packages and allow using libraries and binary-only device drivers built with the Android toolchain to be used within Sailfish OS.
