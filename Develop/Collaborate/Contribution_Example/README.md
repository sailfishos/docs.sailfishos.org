---
title: Contribution Example
permalink: Develop/Collaborate/Contribution_Example/
parent: Collaborate
layout: default
nav_order: 100
---

This document describes contribution example how to contribute the code:

For this example, we will consider a hypothetical bug which affects the Sailfish Browser. A community member discovers that for some content-aggregator sites, a wrong User Agent string seems to be used when fetching content. These are the steps that should be taken in contributing a fix:

1\) File a new issue using the [example issue template](/Develop/Collaborate/Issue_Report_Example/) to <https://github.com/sailfishos/sailfish-browser/issues>.

2\) Comment on the issue that you will start investigating it.

3\) First place to look for the issue is the upstream code repository: <https://github.com/sailfishos/sailfish-browser>. In this case, a closer inspection reveals that the user agent override behaviour is defined in code from the `embedlite-components-qt5` package.

4\) To find the upstream repository for the `embedlite-components-qt5` package, the following command can be used on a Sailfish OS device: `rpm -qi embedlite-components-qt5 | grep URL`. The upstream repository URL in this case is <https://github.com/sailfishos/embedlite-components>.

5\) Create a personal fork of that repository using the web interface at <https://github.com/sailfishos/embedlite-components>

6\) Clone the personal fork to the local host machine with `git clone https://github.com/username/embedlite-components.git username-embedlite-components`

7\) Build the package with sfdk. In this example, the build fails to locate some build time dependencies:
```nosh
# cd into the local clone dir
~ $ cd username-embedlite-components

# attempt to build the package for SailfishOS-4.3.0.12-armv7hl target
~/username-embedlite-components $ sfdk config target=SailfishOS-4.3.0.12-armv7hl
~/username-embedlite-components $ sfdk build
No provider of 'xulrunner-qt5-devel >= 60.9.1' found.
Building target platforms: armv7hl-meego-linux
Building for target armv7hl-meego-linux
error: Failed build dependencies:
    xulrunner-qt5-devel >= 60.9.1 is needed by embedlite-components-qt5-1.0.0-1.armv7hl
    pkgconfig(nspr) is needed by embedlite-components-qt5-1.0.0-1.armv7hl
```

8\) This error means that additional package repositories needs to be enabled in the build environment. To find out which ssu repository provides those packages, run `zypper info` (can also use `pkcon get-details` or search on OBS).
```nosh
~/username-embedlite-components $ ssh defaultuser@device
[defaultuser@XperiaXA2-DualSIM ~]$ devel-su -p pkcon install zypper
## snipped ##
[defaultuser@XperiaXA2-DualSIM ~]$ zypper info xulrunner-qt5-devel
Loading repository data...
Reading installed packages...
Information for package xulrunner-qt5-devel:
--------------------------------------------
Repository     : jolla
Name           : xulrunner-qt5-devel
Version        : 60.9.1+git61-1.11.6.jolla
Arch           : armv7hl
Vendor         : meego
Installed      : No
Status         : not installed
Installed Size : 6.4 MiB
Summary        : Headers for xulrunner
Description    : abzaza
  Development files for xulrunner.
```

9\) The package comes from the "jolla" repository. This repository needs to be enabled in the build environment as suggested in [Enabling Additional Package Repositories](/Tools/Sailfish_SDK/Building_packages/#enabling-additional-package-repositories):
```nosh
~/username-embedlite-components $ sfdk tools exec SailfishOS-4.3.0.12-armv7hl

# This might require registering the SDK depending on the SDK setup.
[SailfishOS-4.3.0.12-armv7hl] ~ # ssu r

# List the available repos
[SailfishOS-4.3.0.12-armv7hl] ~ # ssu lr
## snipped ##
Disabled repositories (global, might be overridden by user config):
 - jolla ... https://releases.jolla.com/releases/4.3.0.12/jolla/armv7hl/
## snipped ##

# Enable the repository.
[SailfishOS-4.3.0.12-armv7hl] ~ # ssu er jolla

# Refresh the available package list from "jolla" repository
[SailfishOS-4.3.0.12-armv7hl] ~ # zypper ref jolla

# Use sfdk to build the package again
[SailfishOS-4.3.0.12-armv7hl] ~ # exit
~/username-embedlite-components $ sfdk build
# Success! The missing package was found now
```

10\) Now that the package is successfully built the package can be deployed:
```nosh
# Use the name of the registered device in the Sailfish IDE, here "my device"
~/username-embedlite-components $ sfdk config device="my device"
# Deploy the package using zypper-dup
~/username-embedlite-components $ sfdk deploy --zypper-dup
# or the forceful way
~/username-embedlite-components $ sfdk deploy --manual
~/username-embedlite-components $ sfdk device exec
[defaultuser@XperiaXA2-DualSIM ~]$ devel-su rpm -Uvh --force RPMS/embedlite-components-qt5-1.0.0-1.armv7hl.rpm
```

11\) Reboot the device and open the browser to test that it still works. After this the development on the fork can start. First create a new branch for the changes `git checkout -b user_agent_fixes` and then the changes and debug statements can be added. Compile the package and deploy it to the device. Before using the modified browser, open up a terminal to see logging output from the journal with `devel-su journalctl -af | grep browser`.

12\) After the issue is resolved and the fixes are committed locally, the commits need to be pushed to the personal fork. Next, a pull request to the upstream repository is to be created. This will look something like <https://github.com/sailfishos/embedlite-components/pull/14>

13\) After the work is complete, update the issue report with the findings and add a link to the pull request.

14\) After receiving review comments, the commit is to be updated with `git commit --amend <changed_file>`. Then force push the branch to the personal fork via `git push origin master:master --force`. Add a comment into the merge request about the updates.

15\) The maintainer merges the patch, tags it, and comments on the original bug report the tagged version which should be in a future release.
