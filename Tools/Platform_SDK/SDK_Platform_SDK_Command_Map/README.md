---
title: SDK ↔ Platform SDK Command Map
permalink: Tools/Platform_SDK/SDK_Platform_SDK_Command_Map/
parent: Sailfish Platform SDK
layout: default
nav_order: 500
---

As described in the other articles, it is possible to use either the Sailfish SDK or the Sailfish Platform SDK for developing both the platform and the applications. This article provides you with a reference chart, making it easier to find the command to use if you already know the command for the other environment.

## Managing Targets

| Action                               | Platform SDK command          | Sailfish SDK command        |
|--------------------------------------|-------------------------------|-----------------------------|
| List targets                         | sdk-assistant target list     | sfdk tools target list      |
| List toolings                        | sdk-assistant tooling list    | sfdk tools tooling list     |
| List both targets and toolings       | sdk-assistant list            | sfdk tools list             |
| List targets available in repos      | -                             | sfdk tools list -a          |
| Install target from repo             | -                             | sfdk tools install          |
| Install tooling/target from URL/file | sdk-assistant create          | sfdk tools install-custom   |
| Clone tooling/target                 | sdk-assistant clone           | sfdk tools clone            |
| Updating tooling/target              | sdk-assistant update          | sfdk tools update           |
| Register tooling/target              | sdk-assistant register        | sfdk tools register         |
| Remove tooling/target                | sdk-assistant remove          | sfdk tools remove           |
| Search packages in tooling/target    | sdk-assistant package-search  | sfdk tools package-search   |
| Install packages in tooling/target   | sdk-assistant package-install | sfdk tools package-install  |
| Remove packages from tooling/target  | sdk-assistant package-remove  | sfdk tools package-remove   |
| Execute maintenance commands         | sdk-assistant maintain        | sfdk tools exec             |
|                                      | mb2 build-shell --maintain    | sfdk build-shell --maintain |
|                                      | mb2 build-requires diff       | sfdk build-requires diff    |
|                                      | mb2 build-requires reset      | sfdk build-requires reset   |


## Building Packages

| Action                        | Platform SDK command                | Sailfish SDK command          |
|-------------------------------|-------------------------------------|-------------------------------|
| Choosing build target         | alias mb2='mb2 --target ...'        | sfdk config target=...        |
| Initialize build directory    | mb2 build-init                      | sfdk build-init               |
| Execute arbitrary commands    | mb2 build-shell                     | sfdk build-shell              |
| Building package              | mb2 build                           | sfdk build                    |
| Execute individual build step | mb2 qmake                           | sfdk qmake                    |
|                               | mb2 make                            | sfdk make                     |
|                               | mb2 make-install                    | sfdk make-install             |
|                               | mb2 package                         | sfdk package                  |
| Setting output dir            | alias mb2='mb2 --output-prefix ...' | sfdk config output-prefix=... |
|                               | alias mb2='mb2 --task'              | sfdk config task              |

## Deploying packages

| Action            | Platform SDK command | Sailfish SDK command |
|-------------------|----------------------|----------------------|
| Deploy package(s) | mb2 deploy           | sfdk deploy          |

Note: With platform packages, it is often most convenient to use the `--zypper-dup` deployment method, and with application packages, it is often most convenient to use the `--sdk` deployment method. Both methods are available on both tools.

As Platform SDK does not come with a tool to configure devices, `--shared-folder` parameter has to be used for pointing it to Sailfish SDK shared directory, e.g.: `mb2 deploy --shared-folder ~/SailfishOS/vmshare`

## Quality assurance

| Action        | Platform SDK command | Sailfish SDK command |
|---------------|----------------------|----------------------|
| Execute tests | mb2 check            | sfdk check           |

