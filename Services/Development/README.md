---
title: Development
permalink: Services/Development/
has_children: true
layout: default
nav_order: 100
---

Development for Sailfish OS involves a number of web services to track development tasks, integrate features and bug fix patches into the code mainline, and process built packages for testing and release.

The main services in this process are:

  - [Issue tracking](/Develop/Collaborate#reporting-issues): Issues are reported to Sailfish OS Forum or component specific issue tracker in github.
  - [Git Server](/Services/Development/Sailfish_OS_Source): A git server allowing users to submit code changes.
  - [Webhooks](/Services/Development/Webhooks): A service that accepts git change triggers from git servers and triggers builds in OBS.
  - [Open Build Service](/Services/Development/Open_Build_Service) (OBS): An automated build system that takes source code from a git server and produces standalone packages from the source repositories.
  - [Image Creator](/Services/Development/Image_Creator): A service to build clean and shareable system images for development, testing and release.

For example, a bug is identified in the Sailfish OS Core [lipstick](https://github.com/sailfishos/lipstick) package. To fix this bug:

  - [An issue is reported](/Develop/Collaborate#reporting-issues) and assigned to a developer for fixing.
  - The developer creates a patch to fix the bug, pushes the change to the relevant git server repository in <https://github.com/sailfishos/lipstick>, and creates a Pull Request to merge the change into the mainline branch. Other developers can then review this request and approve it if the change is satisfactory, or provide feedback if it should be improved.
  - Once the change is approved, it is merged into the code mainline, and tagged with *git tag* using the current package version number to indicate that a new *lipstick* package needs to be built. The webhook for the repository detects that there is a new tag, and notifies OBS.
  - The Sailfish [Open Build Service](/Services/Development/Open_Build_Service) takes the source code from the git server and produces a new build of the *lipstick* package for all supported Sailfish OS platforms. If the package cannot be built on all platforms, OBS sends a notification of the build error and the details. Otherwise, the package is accepted into the collection of latest build packages.
  - The Sailfish [Image Creator](/Services/Development/Image_Creator) builds a new device system image using packages fetched from OBS, including the freshly updated *lipstick* package. If the image is successfully built, it is ready to be flashed onto a device for testing or further development.

For more information about filing bugs, and contributing fixes to issues, please see the [Collaborative Development](/Develop/Collaborate) documentation.
