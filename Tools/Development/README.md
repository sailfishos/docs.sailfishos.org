---
title: Development
permalink: Tools/Development/
layout: default
nav_order: 400
---

Sailfish OS development uses a variety of tools. The basic use is explained in various guides but for more details you'll need to look at the reference information below

## Build and Development

  - [sfdk](/Develop/Apps/#sfdk-command-line-tool): The CLI frontend to the Sailfish SDK
  - [git](https://github.com/sailfishos-mirror/git/#readme) : Sailfish OS uses git extensively for change control. We have a [separate repo for packaging git](https://github.com/sailfishos/git)
  - [scratchbox2](/Reference/Toolchain/#scratchbox-2) : a powerful cross-compilation suite
  - [mic](https://github.com/sailfishos/mic/#readme) : Local image generation tool
  - [osc](https://github.com/sailfishos-mirror/osc/#readme) : a client for the [OBS](/Services/Development/Open_Build_Service). We have [separate repo for packaging osc](https://github.com/sailfishos/osc/) as well.

## Toolchain

  - Linaro [gcc](https://github.com/sailfishos/gcc) toolchain : GNU Compiler Collection
  - [gdb](https://github.com/sailfishos-mirror/gdb/#readme) : GNU Debugger. We have a [separate repo for packaging](https://github.com/sailfishos/gdb/)

## Analysis

  - Valgrind is available in the tools repository
  - strace is available in the tools repository

## Testing

  - testrunner-lite (available from tools repository) can be used to automate unit test execution (see <https://wiki.merproject.org/wiki/Quality/QA-tools/Testrunner-lite> for more information)
