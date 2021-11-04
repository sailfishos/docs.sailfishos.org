---
title: Deploying packages
permalink: Tools/Sailfish_SDK/Deploying_packages/
parent: Sailfish SDK
layout: default
nav_order: 500
---

## Deploying Packages

Once a package has been built, it must be deployed to the device (or SDK build target, in the case of -devel packages). Depending on whether the package was built locally or remotely, there are different ways to deploy the package to the device.

### Deploying Local RPMs

For packages built locally with `sfdk`, the developer will have .rpm files which they wish to deploy. To deploy these packages to a device previously registered within the Sailfish IDE, the developer can use `sfdk deploy --manual` to transfer the packages to the device. Then, the packages can be installed by issuing the `rpm -Uvh --force RPMS/*.rpm` command from a devel-su prompt (e.g., `devel-su rpm -Uvh --force RPMS/*.rpm`). In some cases, rebooting the device may be necessary to force any changes to take effect.

Note that packages installed in this fashion ("sideloaded") may cause conflicts with packages installed from repositories. Future upgrades will not necessarily succeed cleanly if a sideloaded .rpm with incorrect version information is installed.

Some of the possible issues can be avoided by deploying with `zypper`, pointing it to the directory where the .rpm files were copied using the `-p|--plus-repo` option. New packages can be initially deployed with
```nosh
zypper -p <rpms-dir> -v in <package>...
```

Packages that are already installed can be updated with
```nosh
zypper -p <rpms-dir> -v dup
```

With this command zypper upgrades the system using the latest .rpm packages found in <rpms-dir>. As `sfdk` produces evergrowing version numbers (unless told otherwise), this command always updates to the latest built version found in the directory while obeying package dependencies. When the repositories contain newer package versions, the `--from ~plus-repo-1` option to `zypper dup` helps.

A shorthand syntax exists for this approach – it is the `--zypper-dup` deployment method:
```nosh
sfdk deploy --zypper-dup
```

Add `--dry-run` to preview the effect before actually applying it.

### Deploying Local RPMs into Build Targets

When multiple packages are modified under a task and build time dependencies exist between those, one needs to ensure that the updated versions of the required packages are available under the build target. See [Working with dependent packages](/Develop/Apps/Tutorials/Building_packages_-_advanced_techniques#working-with-dependent-packages) to learn how to achieve that conveniently.

### Deploying From Repository

When the [Open Build Service](/Services/Development/Open_Build_Service) builds a package, that package becomes available in a repository (usually, the user's home project repository). The package may then either be downloaded directly as an .rpm and installed as described in the above section on deploying local .rpm files, or the repository can be added to the device or SDK target as a [software update repository](/Services/Deployment/SSU), and the device or SDK target can be updated to install the package from that newly added repository.

The OBS repository can be added to the device or SDK target rootfs repository via:
```nosh
ssu ar <repo_name> <repo_url>
```

The available packages can then be installed to the device via
```nosh
devel-su pkcon refresh
```

followed by
```nosh
devel-su pkcon install <pkg_name>
```

or to the SDK via:
```nosh
zypper ref -f
```

followed by
```nosh
zypper in <pkg_name>
```

from a maintenance shell (e.g., `sfdk tools exec SailfishOS-4.3.0.12-armv7hl`).

You can use `ssu lr` to list the available repositories.
