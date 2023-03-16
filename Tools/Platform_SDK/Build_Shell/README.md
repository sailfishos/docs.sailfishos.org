---
title: Build Shell
permalink: Tools/Platform_SDK/Build_Shell/
parent: Sailfish Platform SDK
layout: default
nav_order: 400
---

# Build Shell

If you want to run arbitrary commands on the build environment, you can use the `mb2 build-shell` command. The `build-shell` command needs to be run from the top of a build tree, so before you use it for the first time you need to initialize a build directory with the `mb2 build-init` command.

```nosh
$ git clone https://github.com/sailfishos/sample-app-c.git
$ cd sample-app-c/src
$ mb2 build-init
$ mb2 build-shell
[SailfishOS-4.5.0.18-aarch64] src $ make
cc -o sample-app-c sample-app-c.c -I/usr/include/ssusysinfo -lssusysinfo
```
**Note:** If you actually try the above command, your compilation will likely fail, because you don't have `ssu-sysinfo-devel` package installed. See below on [Maintenance mode](#maintenance-mode) for information on how to install it.

You can give the actual command you want to execute as an additional parameter.
```nosh
$ mb2 build-shell make
```

### Maintenance mode

Pass the `--maintain` option when running maintenance commands - such that are used to inspect and/or modify the build environment itself. Failure to do so leads to undefined results.

We can use the maintenance mode to install the package required for building the sample-app-c from above:
```nosh
$ mb2 build-shell --maintain zypper se ssu-sysinfo-devel
Loading repository data...
Reading installed packages...
S | Name              | Summary                           | Type
--+-------------------+-----------------------------------+--------
  | ssu-sysinfo-devel | Development files for ssu-sysinfo | package
$ mb2 build-shell --maintain zypper in ssu-sysinfo-devel
```

Just like without the `--maintain` parameter, you can leave out the command to open an interactive shell:
```nosh
$ mb2 build-shell --maintain
[SailfishOS-4.4.0.58-aarch64] #
```

Any changes done under the build environment are persisted under build targets. Unless the `--no-snapshot` option is used, mb2 uses a working copy (a "snapshot") of the actual build target to persist your build environment. Thanks to this you can revert any modifications to the build environment using the 'build-requires reset' command, so don't be afraid to experiment, but be aware that changes may get reset implicitly under certain conditions (read more in the built-in help of mb2).

Use the 'build-requires diff' command to see how the current build environment differs from the clean build environment in terms of package installations, removals and replacements.

**Note:** Installing packages with maintenance mode might be handy when experimenting, but you should always add the packages required for building packages as BuildRequires in the [RPM SPEC](/Develop/Apps/Packaging/#the-rpm-spec-file) file. It is a good habit to always verify that building a package works with a clean build enviroment.

