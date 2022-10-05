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

You can use the command `sdk-assistant list` to list available  [build targets](/Tools/Platform_SDK/Target_Installation/#sailfish-platform-sdk-targets-and-toolings):
```nosh
$ sdk-assistant list
SailfishOS-4.4.0.58
├─SailfishOS-4.4.0.58-aarch64
├─SailfishOS-4.4.0.58-armv7hl
└─SailfishOS-4.4.0.58-i486
```

Each build target lets you build software for a specific operating system version running on a specific hardware. Each target is listed under one tooling supporting the given OS version. So, in our example, we have installed one tooling (SailfishOS-4.4.0.58) and three targets for it (aarch64, armv7hl and i486).

## Selecting build target

The Platform SDK comes with a convenient tool for building packages, called `mb2`. It accepts build target name with the command line option `--target` (or briefly `-t`). You can also set the default target by creating a shell alias or by similar means:
```nosh
$ alias mb2='mb2 --target SailfishOS-4.4.0.58-aarch64'
```

## Building packages

Enter a package directory. If you don’t have an existing package available, you can use the sample application as in the following example.
```nosh
$ git clone https://github.com/sailfishos/sample-app-cppqml.git
$ cd sample-app-cppqml
```

You can now perform an all-in-one build procedure using the `mb2 build` command. After a succesfull build the resulting RPM package(s) can be found under the RPMS directory:
```nosh
$ mb2 build
$ ls ./RPMS
cppqml-1.0-1.aarch64.rpm
```

The recipe for building the package can be found in a SPEC file in the rpm directory, in our exacmple case `rpm/cppqml.spec`.

## Running arbitrary commands

When you don't have a SPEC file, or you want to execute a command which is not in the SPEC file, you can use the `mb2 build-shell` command to enter the build environment and execute commands directly. You can give the actual command you want to execute as an additional parameter.
```nosh
$ cat >hello.cpp <<END
#include <iostream>
int main() { std::cout << "Hello!" << std::endl; return 0; }
END
$ mb2 build-shell g++ -o hello hello.cpp
```

If you leave the command out, an interactive shell is opened:
```nosh
$ mb2 build-shell
[SailfishOS-4.4.0.58-aarch64] $
```

### Maintenance mode

Pass the `--maintain` option when running maintenance commands - such that are used to inspect and/or modify the build environment itself. Failure to do so leads to undefined results.
```nosh
$ mb2 build-shell --maintain zypper se ...
$ mb2 build-shell --maintain zypper in ...
```

Just like without the `--maintain` parameter, you can leave out the command to open an interactive shell:
```nosh
$ mb2 build-shell --maintain
[SailfishOS-4.4.0.58-aarch64] #
```

Any changes done under the build environment are persisted under build targets. Unless the `--no-snapshot` option is used, mb2 uses a working copy (a "snapshot") of the actual build target to persist your build environment. Thanks to this you can revert any modifications to the build environment using the 'build-requires reset' command, so don't be afraid to experiment, but be aware that changes may get reset implicitly under certain conditions (read more in the built-in help of mb2).

Use the 'build-requires diff' command to see how the current build environment differs from the clean build environment in terms of package installations, removals and replacements.

**Note:** Installing packages with maintenance mode might be handy when experimenting, but you should always add the packages required for building packages as BuildRequires in the SPEC file. It is a good habit to always verify that building a package works with a clean build enviroment.

## Further reading

The `mb2` tool comes with comprehensive built-in documentation. It is accessible with command `mb2 --help`.
