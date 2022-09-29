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

## Using snapshots

Whenever you make changes to the build targets, the changes persist there. This includes e.g. installing packages as part of the build process. These changes could then interfere with building another package. In order to avoid that, mb2 uses a working copy of a build target to set up the build environment.  These working copies are called snapshots.

You can see all existing snapshots in the [target list](#listing-installed-build-targets). By default, mb2 uses a snapshot called `default`. You can specify another snapshot using the `--snapshot` option:
```nosh
$ mb2 --snapshot=mysnapshot build
```

The original build target defines the clean state of the build environment. You can always reset the snapshot to the clean state using command `mb2 build-requires reset`. If you update the original target, the snapshots will be reset automatically during next build.

If you don't want to use snapshots, you can perform your build operations directly on the original target by specifying the `--no-snapshot` option. But bear in mind, that even though you save a little bit of disk space by not using snapshots, you lose the ability to easily restore the target to a clean state. Also, it is much easier to make packaging errors (forgetting to add BuildRequires in .spec file) when not using clean build targets, i.e. snapshots for building.

Use the `mb2 build-requires diff` command to see how the current build environment differs from the clean build environment in terms of package installations, removals and replacements.

## Running arbitrary commands

When you don't have a spec file, or you want to execute a command which is not in the spec, you can use the `mb2 build-shell` command to enter the build environment and execute commands directly. You can give the actual command you want to execute as an additional parameter.
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
NOTICE: Using the 'SailfishOS-4.4.0.58-aarch64.default' snapshot of the build target
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
NOTICE: Using the 'SailfishOS-4.4.0.58-aarch64.default' snapshot of the build target
[SailfishOS-4.4.0.58-aarch64] #
```

Any changes done under the build environment are persisted under build targets. Just like with the `build` command, mb2 uses a snapshot unless you give the `--no-snapshot` option.

**Note:** Installing packages with maintenance mode might be handy when experimenting, but you should always add the packages required for building packages as BuildRequires in the .spec file. It is a good habit to always verify that building a package works with a clean build enviroment.

## Further reading

The `mb2` tool comes with comprehensive built-in documentation. It is accessible with command `mb2 --help`.
