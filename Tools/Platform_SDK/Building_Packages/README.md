---
title: Building Packages
permalink: Tools/Platform_SDK/Building_Packages/
parent: Sailfish Platform SDK
layout: default
nav_order: 300
---

If you have already learned how to build packages using command line interface of the regular [Sailfish SDK](/Tools/Sailfish_SDK/Building_packages), you will find the Platform SDK environment quite familiar. There is no surprise about because `sfdk`, the CLI frontend of the regular Sailfish SDK, is rather a lightweight dispatcher, redirecting your commands to the Platform SDK tools running behind the scene.

The most frequently used Platform SDK tool is `mb2`, and much of the `sfdk` commands [translate](https://github.com/sailfishos/sailfish-qtcreator/blob/master/share/qtcreator/sfdk/modules/20-building-mb2/manifest.json) directly to `mb2` invocations as in this example:
```nosh
(host) $ sfdk config --push OPTION1 VALUE
(host) $ sfdk config --push OPTION2
(host) $ sfdk SUBCOMMAND [ARGS...]
     ⇣
(PlatformSDK) $ mb2 --OPTION1 VALUE --OPTION2 SUBCOMMAND [ARGS...]
```

Here follows a brief introduction for those who jumps directly to Platform SDK use.

## Listing installed build targets

You can use the command `sdk-assistant list` to list available build targets:
```nosh
$ sdk-assistant list
SailfishOS-4.4.0.58
├─SailfishOS-4.4.0.58-aarch64
│ └─SailfishOS-4.4.0.58-aarch64.default  (snapshot)
├─SailfishOS-4.4.0.58-armv7hl
│ └─SailfishOS-4.4.0.58-armv7hl.default  (snapshot)
└─SailfishOS-4.4.0.58-i486
  └─SailfishOS-4.4.0.58-i486.default  (snapshot)
```

Each build target lets you build software for a specific operating system version running on a specific hardware. Each target is listed under one tooling supporting the given OS version. Under each build target are listed existing snapshots of the target. So, in our example, we have installed one tooling (SailfishOS-4.4.0.58) and three targets for it (aarch64, armv7hl and i486). Each target has one snapshot (default).

## Selecting build target

The Platform SDK comes with a convenient tool for building packages, called `mb2`. It accepts build target name with the command line option `--target` (or briefly `-t`). You can also set the default target by creating a shell alias or by similar means:
```nosh
$ alias mb2='mb2 --target SailfishOS-4.4.0.58-aarch64'
```

## Building packages

Enter a package directory. If you don’t have an existing package available, you can use the sample application as in the following example.
```nosh
$ git clone https://github.com/sailfishos/cppqml-sample.git
$ cd cppqml-sample
```

You can now perform an all-in-one build procedure using the `mb2 build` command. After a succesfull build the resulting RPM package(s) can be found under the RPMS directory:
```nosh
$ mb2 build
$ ls ./RPMS
cppqml-1.0-1.aarch64.rpm
```

The recipe for building the package can be found in a .spec file in the rpm directory, in our exacmple case `rpm/cppqml.spec`.

## Further reading

The `mb2` tool comes with comprehensive built-in documentation. It is accessible with command `mb2 --help`.
