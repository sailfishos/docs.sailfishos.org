---
title: Open Build Service
permalink: Services/Development/Open_Build_Service/
parent: Development
layout: default
nav_order: 100
---

The [Open Build Service](https://en.wikipedia.org/wiki/Open_Build_Service) (OBS) is a distribution platform for creating and managing package builds on multiple platforms.

Sailfish OS has an example OBS at <https://build.sailfishos.org/> for building packages. It takes source code from git repositories to create standalone packages, allowing the building of packages on a variety of supported platforms for testing and release distribution. It performs:

  - Automated building of Sailfish OS packages when triggered by [Webhooks](/Services/Development/Webhooks) from git repositories
  - On-demand building of Sailfish OS packages, when manually triggered

Each package is added under a *project*. For example, there is a [ofono](https://build.sailfishos.org/package/show/mer:core/ofono) package that is linked to the oFono code repository, and this package lives within the [mer:core devel](https://build.sailfishos.org/project/show/mer:core) project, which contains all of the *mer:core* packages that are built for a *devel* image. If a package cannot be built, the OBS web page for that package shows the build error details and the status of the package.

## Building in OBS

After the maintainer has tagged the repository, the CI system will be informed (via webhook) of the change. This will trigger a package build in [OBS](/Services/Development/Open_Build_Service). OBS will attempt to build the package, with a build environment constructed specifically for that package after examining the build requirements which are listed in its RPM .spec file.

If the build fails, either due to a missing dependency specification in the .spec file, or due to a code error, the package will not be tested, and the developer is expected to respond to the failure notification and fix the issue.

If the build succeeds, a set of automated tests will be run (if specified for the package), allowing a first-stage quality gate to be applied. If those automated tests succeed, the package will be accepted to the next stage of releasing.

See [Packaging Software on OBS](/Services/Development/Open_Build_Service/Packaging_for_OBS) for more.

## Promotion in OBS

When a package is promoted, it becomes accessible to any device which has that repository added to their update configuration (modifiable via the `ssu` command). There are different promotion layers which correspond to different release types:

  - The "devel" promotion layer corresponds to "development" devices. These are generally used by developers only. Developers and testers will use packages from these repositories, and when they agree that the content is stable enough, the packages will be promoted to "testing" level.

<!-- end list -->

  - The "testing" promotion layer corresponds to "quality assurance" devices. These are generally used by quality assurance engineers only. These people will thoroughly test the package using an array of automated and manual test cases, and only when they are satisfied that the package is of high quality and causes no regressions will they allow promotion of the package from "testing" to "release" level.

<!-- end list -->

  - The "release" promotion layer corresponds to "release" devices. These devices are used by consumers. Packages at this level are considered stable and able to form part of a release image during the next release cycle.

## QA images in IMG

Before a release image is made, the release level packages are combined into a series of release-candidate images for quality-assurance purposes. These images are tested thoroughly in order to catch any regressions or other major issues which managed to slip through the previous quality gates. Images are built by the [Image Creator](/Services/Development/Image_Creator).

See the [OBS](https://build.sailfishos.org) page for more information.
