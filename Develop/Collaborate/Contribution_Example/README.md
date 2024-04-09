---
title: Contribution Example
permalink: Develop/Collaborate/Contribution_Example/
parent: Collaborate
layout: default
nav_order: 100
---

This document describes contribution example how to contribute the code:

For this example, we will consider a hypothetical bug which affects the Sailfish Browser. A community member discovers that for some content-aggregator sites, a wrong User Agent string seems to be used when fetching the content. These are the steps that should be taken in contributing a fix:

1\) File a new issue using the [example issue template](/Develop/Collaborate/Issue_Report_Example/) to <https://github.com/sailfishos/sailfish-browser/issues>.

2\) Comment on the issue that you will start investigating it.

3\) First place to look for the issue is the upstream code repository: <https://github.com/sailfishos/sailfish-browser>. In this case, a closer inspection reveals that the user agent override behaviour is defined in code from the `embedlite-components-qt5` package.

4\) To find the upstream repository for the `embedlite-components-qt5` package, the following command can be used on a Sailfish OS device: `rpm -qi embedlite-components-qt5 | grep URL`. The upstream repository URL in this case is <https://github.com/sailfishos/embedlite-components>.

5\) Create a personal fork of that repository using the web interface at <https://github.com/sailfishos/embedlite-components>

6\) Clone the personal fork to the local host machine with `git clone https://github.com/username/embedlite-components.git username-embedlite-components`

7\) Build the package with sfdk:
```nosh
# cd into the local clone dir
~ $ cd username-embedlite-components

# attempt to build the package for SailfishOS-4.3.0.12-armv7hl target
~/username-embedlite-components $ sfdk config target=SailfishOS-4.3.0.12-armv7hl
~/username-embedlite-components $ sfdk build
```

8\) Now that the package is successfully built it can be deployed:
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

9\) Reboot the device and open the browser to test that it still works. After this the development on the fork can start. First create a new branch for the changes `git checkout -b user_agent_fixes` and then the changes and debug statements can be added. Compile the package and deploy it to the device. Before using the modified browser, open up a terminal to see logging output from the journal with `devel-su journalctl -af | grep browser`.

10\) After the issue is resolved and the fixes are committed locally, the commits need to be pushed to the personal fork. Next, a pull request to the upstream repository is to be created. This will look something like <https://github.com/sailfishos/embedlite-components/pull/14>

11\) After the work is complete, update the issue report with the findings and add a link to the pull request.

12\) After receiving review comments, the commit is to be updated with `git commit --amend <changed_file>`. Then force push the branch to the personal fork via `git push origin user_agent_fixes --force`. Add a comment into the merge request about the updates.

13\) The maintainer merges the patch and tags it. Then the original bug report is commented that the tagged version will be in a future release.
