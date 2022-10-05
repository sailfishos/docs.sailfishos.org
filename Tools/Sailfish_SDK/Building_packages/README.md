---
title: Building packages
permalink: Tools/Sailfish_SDK/Building_packages/
parent: Sailfish SDK
layout: default
nav_order: 400
---

This page deals specifically with building platform packages without the help of the Sailfish IDE. See the [Application Development](/Develop/Apps) overview to learn how to build packages with the help of the Sailfish IDE.

Packages may either be built locally (using `sfdk`, the CLI frontend to the Sailfish SDK), or remotely (using the Sailfish OBS). Building locally has the advantage of being quick, simple, and low-latency. Building remotely has the advantage that build dependencies and other packaging requirements are enforced more strictly.

See also [Tutorial - Building packages - advanced techniques](/Develop/Apps/Tutorials/Building_packages_-_advanced_techniques).

## Building Packages Remotely

Packages may be built using the [Open Build Service](/Services/Development/Open_Build_Service) instance. This requires the user to create a home project, and then create a package under that project, with the appropriate `_service` file to specify how the project should be built and packaged. Once the build has been triggered, OBS will attempt to pull in the required dependencies and build the package.

See the page about [deploying packages](/Tools/Sailfish_SDK/Deploying_packages) for information on how to install the package once built.

## Building Packages Locally

Once the user has installed the [Sailfish SDK](/Tools/Sailfish_SDK/Installation), they can build packages locally for the target architecture using the tool called `sfdk`. This tool provides a number of sub-commands wrapping around `rpmbuild` and others in a way which makes it simple to cross-compile packages from source repositories, given an RPM specification (.spec) file.

The `sfdk` tool can be found in the `bin` subdirectory of the Sailfish SDK installation directory. Further code examples assume the tool is available on `PATH` or by other means simply as `sfdk`.

Start by choosing the build target. List the available build tools.
```
$ sfdk tools list
SailfishOS-3.0.2.8                           sdk-provided
├─SailfishOS-3.0.2.8-armv7hl                 sdk-provided
└─SailfishOS-3.0.2.8-i486                    sdk-provided
SailfishOS-4.3.0.12                          sdk-provided,latest
├── SailfishOS-4.3.0.12-aarch64              sdk-provided,latest
├── SailfishOS-4.3.0.12-armv7hl              sdk-provided,latest
└── SailfishOS-4.3.0.12-i486                 sdk-provided,latest
```

Each build target lets you build software for a specific operating system version running on a specific hardware. Each target is listed under one tooling supporting the given OS version.

Pick the latest aarch64 target.
```nosh
$ sfdk config --push target SailfishOS-4.3.0.12-aarch64
```

Enter a project directory and perform an all-in-one build procedure using the `build` command. If you don't have an existing project available, you can create one as in the following example.
```nosh
$ mkdir my-app && cd my-app
$ sfdk init --type qtquick2-app
$ sfdk build
```

After successful build the resulting RPM package(s) can be found under the `RPMS` directory.
```nosh
$ ls ./RPMS
my-app-0-1.aarch64.rpm
```

These `.rpm` files may be installed to the device or the build target as described in the page on [deploying packages](/Tools/Sailfish_SDK/Deploying_packages).

See `sfdk --help-building` for more information on building packages or jump directly to the all-in-one manual with `sfdk --help-all`.

### Installing Missing Dependencies

In some cases, the developer will have to add or enable repositories within their build target, if the `sfdk` tools complains that a dependency cannot be installed. This can be done by issuing maintenance commands under the build target with the help of the `tools exec` command:
```nosh
sfdk tools exec <name> [<command> [<arg>...]]
```

Use the command
```nosh
ssu ar <repo_name> <repo_url>
```

to add repositories, and
```nosh
ssu er <repo_name>
```

to enable repositories, and then
```nosh
zypper ref -f
```

to update the installable package information. `ssu lr` may be used to list known repositories, and `ssu rr <repo_name>` will remove a repository.

Example:
```nosh
# enter the build target
~ $ sfdk tools exec SailfishOS-4.3.0.12-aarch64

# add a repository
[SailfishOS-4.3.0.12-aarch64] ~ # ssu ar my-repo https://repo...

# reload the package list
[SailfishOS-4.3.0.12-aarch64] ~ # zypper ref -f
```

To determine which repository provides a given package, a contributor should use the search feature on an available Sailfish OBS instance or from within their SFOS device or SDK emulator via `devel-su -p pkcon install zypper; zypper info <package_name>`.

It should be noted that device or hardware-platform-specific packages (especially those needed to build hybris-related packages) are best installed into a separate SDK target, to avoid complications. See [Clean Builds](#clean-builds) below to learn how to achieve that conveniently without explicitly installing separate SDK targets.

## Building Binaries Locally

In some cases, you will not want to build an entire package (.rpm) to install, but instead want to build a single binary from a simple (most likely Qt-based) project. This can be handy, for example, during testing or prototyping.

In this case, you simply need to build the project from within a build-shell. For example, to build a simple Qt-based project (called "test", located under `~/test/` of the host) the following steps could be taken:
```nosh
~ $ cd ~/test && sfdk build-shell qmake && sfdk build-shell make
```

The resulting binary can be copied to the device with `scp` and executed directly.

## Packaging formats

There are different repository formatting guidelines for automated building and packaging for Sailfish OS, depending on the relationship between that repository and its upstream origin and state.

### tar_git packaging structure

A special OBS service called 'tar_git' can automatically package sources from a specifically formatted git repository along with any referenced git submodules into a suitable tar archive to be built on OBS. This format is relatively simple and as long as one follows some basic instructions tools like `sfdk` work nicely and if `sfdk` works then it is quite likely that also the package builds fine after integrating as part of the release process. This process can be triggered automatically on OBS when a new git tag is created, using [Webhooks](/Services/Development/Webhooks).

Some basic things to remember: the rpm .spec files are located in `rpm/*.spec`. As described below. the changelog is generated from git commit messages, so there is no need to include a changelog section in the spec file nor a separate .changes file, unless pre-git historical changelog entries need to be included. These can be included in `rpm/*.changes` files. All other files in `rpm/` directory must be marked either with **SourceX:** or **PatchX:**. Package version is determined from the latest suitable Git tag. The **Version:** and **Release:** tags in the .spec file are ignored – setting them to "0" and "1" respectively is the preferred convention.

Packaging should aim to preserve upstream git history whenever possible to allow for easier synchronization of upstream changes. Bearing this in mind, there are several possibilities for packaging, depending on whether there is an upstream repository and the number of modifications of it required for the Sailfish OS version.

#### tar_git package source code location in git

When a package has no upstream, i.e. is a package maintained as part of Sailfish OS, the sources are usually located solely within a single git repository alongside the rpm directory, either in the root of the git tree or src dir or something similar depending a bit on the package. Example of such package is for example the lipstick display manager at <https://github.com/sailfishos/lipstick/>

Otherwise, the package should contain a link to its upstream repository as a git submodule, named the same as the package **Name:** in .spec file, or simply as **upstream**. Please use https format for git submodule url. This makes sure that submodule cloning works for all users. Third-party repositories should be mirrored on <https://github.com/sailfishos-mirror> and referenced there, to avoid future build errors due to upstream moves or removal. New repository mirrors can be requested on IRC.

If the package has upstream somewhere else and there are no heavy modification needed for the sources, the sources are usually built directly from the git submodule. Small modifications and backported commits from later versions can be included as patches stored as `rpm/*.patch`. Locally, those patches can be applied with `sfdk apply` to the submodule or as part of the whole prepare phase using `sfdk prepare`. They can be unapplied with `sfdk apply -R`. PackageKit is an example of such package at <https://github.com/sailfishos/PackageKit>

There is a proposal to use a long-lived topic branch instead of patches, which mirrors the upstream repository directly rather than using a submodule. See [Git_Packaging_-_Upstream_Git_with_Long-Lived_Topic_Branch_Approach](/Develop/Platform/Usage_of_packaging_formats/Upstream_Git_with_Long-Lived_Topic_Branch_Approach).

If there are many modifications to the upstream that are not accepted as a part of the upstream (at least yet), then they may be stored in a separate tree from the upstream submodule. In such cases the submodule should be called **upstream** and the modified copy of the upstream should be a separate directory named after the package name from the .spec file. Synchronization with newer upstream releases is done using [`git``   ``subtree`](/Develop/Platform/Usage_of_packaging_formats#upstream-git-with-subtrees). An example of such a package is 'connman' at <https://github.com/sailfishos/connman>

### Dumb packages

This is an obsolete format and that generally should not be used any more. Any packages using this should be converted to tar_git format whenever the opportunity arises. These use no smart packaging system, instead storing the .spec file, tarball and any patches directly in the root of the git tree. One situation where this might be preferable is if there is no upstream version control and only source tar downloads are available, in which case that archive may be used without modification. An example of such packaging is ncurses, found at <https://github.com/sailfishos/ncurses> .

Such 'dumb' packages do not compile with the `sfdk build` as the packages done with tar_git format. Sometimes it is both necessary and sufficient to unpack and enter the source directory, then tell `sfdk` where the .spec file is located:

```nosh
git clone https://github.com/sailfishos/ncurses.git
cd ncurses
tar xf ncurses-6.1.tar.gz && cd ncurses-6.1
sfdk --specfile ../ncurses.spec build
```

As a fallback method, `rpmbuild` can be invoked manually under the build shell:

```nosh
git clone https://xyz/example-dumb-package.git
cd example-dumb-package
sfdk build-shell rpmbuild --define "_topdir $PWD" --define "_sourcedir $PWD" -bb *.spec
```

Note that when using `rpmbuild` manually, you need to also manually install possible build time dependencies, where `sfdk build` does that automatically.

## Changelog generation

Changelogs are generated from git commits (or from annotated tags in case on forgets the message from the commit) in tar_git packaged packages. This allows change logs to be generated automatically, and for the commit history to contain meaningful back-links to the bug reports which led to the change being made.

Basically how it works is that each line that has the `[ ]` is added to the changelog of the package and rest of the lines from the commit message are ignored:
```
[SHORT] Long description that shall reflect the work done. Bug-ref JB#xxxx
[key] Summary. Contributes to xyz#123
[packaging] Updated Y to version X. Fixes xyz#124
```

**NOTE:** Run `sfdk --help-building` inside the SDK to learn how to generate changelogs when building a package locally

This line does not need to be the first line in the git commit message and there can be multiple lines within one git commit message.

The **SHORT** description is any descriptive word like "backend" or "UI" or "bluetooth". Long description describes the change in plain English and shall contain a reference to a bug.

There are couple of ways to refer bugs in the git commit messages

| Commit suffix           |                                                                                                                                                                                                                                                                                                                            |
| ----------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Contributes to xyz#123  | Means that this change contributes to the referred bug number, but does not fully fix it yet. This kind of lines are usually used when the required fixes to one bug are needed across multiple packages or for example the fix improves the issue, but there might still be some corner case that it might be reproduced. |
| Fixes xyz#124           | Means that this change fixes the bug.                                                                                                                                                                                                                                                                                      |

Currently known and accepted bug tags for the above **xyz** are:

| Tag  |                                                                                 |
| ---- | ------------------------------------------------------------------------------- |
| MER  | Bugs referring to old Mer infrastructure. (Obsolete)                            |
| NEMO | Bugs referring to old Nemo infrastructure. (Obsolete)                           |
| JB   | For bugs in internal Jolla Bugzilla                                             |
| TJC  | To reference issues listed in [together](https://together.jolla.com) (Obsolete) |

These lines are picked to the changelog based on tags, meaning that between two tags all the lines that are following the format are picked up and added to the changelog.
