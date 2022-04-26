---
title: FAQ
permalink: Tools/Sailfish_SDK/FAQ/
parent: Sailfish SDK
layout: default
nav_order: 200
---

## How do I launch or shutdown the build engine or the emulator?

When you have a Sailfish OS project open in the IDE, you can see two additional control icons in the left toolbar. Click on ![Build_Engine_Icon.png](Build_Engine_Icon.png "Build_Engine_Icon.png")
icon to start the build engine and the ![Emulator_Icon.png](Emulator_Icon.png "Emulator_Icon.png")
icon to start the emulator. These buttons will also allow you to shut them down.

Control icon colour key:

  - Green – stopped, click to start
  - Gray – starting
  - Red – started, click to shut down

## How do I stop an application running in the emulator?

In the IDE editor view, at the lower edge, you can see a search box followed by four tabs. Click on the **Application Output** tab. Click on the red **Stop** button to stop the running application.

## How do I add additional development headers to the Sailfish OS target?

In the IDE,

1.  Go to **Options → Sailfish OS → Build Engine → Manage Build Targets...**
2.  Select build target from the list on top
3.  Choose **Manage packages** below, proceed to next page
4.  Enter search pattern(s) and click **Search packages** (read the tool tip of the search pattern field for more information)
5.  Select packages for installation and/or removal
6.  Repeat from step 4 if needed
7.  Proceed to next page to apply required changes

***With Sailfish SDK older than 3.0:***

The SDK control center provides options to extend the default Sailfish OS target. In the IDE,

1.  Click on the **Sailfish OS** icon in the left toolbar to open the SDK control center.
2.  Click on the **manage** button next to the SailfishOS-i486 target.
3.  The list of development headers available for install is displayed.
4.  Choose the package you wish to install and click on the **install** button next to it.

## How do I login into the emulator or build engine?

### Emulator

For the purpose of opening a shell or running simple commands inside the emulator, sfdk provides a convenient interface:
```nosh
$ sfdk emulator exec [<command> [<args>...]]
```

Using native SSH clients is possible too. The Emulator has a Developer settings application, which you can use to set the password for the defaultuser user. After that you can login to the emulator as user defaultuser. Alternatively, you can login using the SSH keys.
```nosh
# as user defaultuser
$ ssh -p 2223 defaultuser@localhost
$ ssh -p 2223 -i ~/SailfishOS/vmshare/ssh/private_keys/sdk defaultuser@localhost

# as root
$ ssh -p 2223 -i ~/SailfishOS/vmshare/ssh/private_keys/sdk root@localhost
```

**Note:** For connecting to other than the latest emulator, check Qt Creator's Options under the Devices category, where you will find the `SSH port` number under the corresponding device, or use `sfdk device list` on command line to retrieve the same information.

**Note:** SSH key path changed in SDK 3.6. Use the above tip about SSH port number to determine the SSH key path with SDK older than 3.6.

### Build Engine

For the purpose of opening a shell or running simple commands inside the build engine, sfdk provides a convenient interface:
```nosh
$ sfdk engine exec [<command> [<args>...]]
```

Using native SSH clients is possible too.
```nosh
# as user mersdk
$ ssh -p 2222 -i ~/SailfishOS/vmshare/ssh/private_keys/sdk mersdk@localhost

# as root
$ ssh -p 2222 -i ~/SailfishOS/vmshare/ssh/private_keys/sdk root@localhost
```

**Note**: Prior to SDK 3.6 a separate key pair existed for each build engine user under the "engine" subdirectory

The SSH daemon (and other network services) on the virtual machines can only be accessed from the host.

If you make any changes to the target on the build engine, be sure to re-sync with the host using **Options → Sailfish OS → Build Engine → Manage Build Targets... → Synchronize** from the IDE. (With Sailfish SDK older than 3.0 use **Control Center → Targets → SailfishOS-i486 → manage → sync**.)

## How do I install packages to emulator?

See [Advanced techniques](https://docs.sailfishos.org/Develop/Apps/Tutorials/Building_packages_-_advanced_techniques/) when using using sfdk tool.

Alternatively you can use scp as follows.

```nosh
scp -P 2223 -i ~/SailfishOS/vmshare/ssh/private_keys/sdk <path-to-rpm-package>/<my-package>.i486.rpm defaultuser@localhost:
```

Then login to emulator as root and install package using rpm.

```nosh
$ ssh -p 2223 -i ~/SailfishOS/vmshare/ssh/private_keys/sdk root@localhost
$ cd /home/defaultuser
$ rpm -U <my-package>.i486.rpm
```

## Why are you using virtual machines?

The native platform for Sailfish OS software development is GNU/Linux (Linux). Use of virtual machines allows us to efficiently deliver a consistent build environment to a wide range of platforms. Whilst there is a small performance penalty, we think this is a worthwhile tradeoff for the benefits it gives us all. Best build performance can be achieved with Docker-based build engine on Linux – in this case the performance penalty is near to zero when compared to a native build environment setup. We have further optimisations planned for other host platforms.

## What are the shared folders for?

  - To securely share the SSH keys on the emulator and build engine.
  - So the build engine can see your code.
  - So Qt Creator can see the target in the build engine.

This essentially means that the "mersdk" user account in the build engine is, as far as possible, your account. If you wish to share additional directories then please discuss this with the community.

## I see scrollbars in the emulator window. How do I scale it to the window size?

Modern handheld devices have high display resolutions, often higher than desktop computers have. Sailfish OS Emulator is capable of scaling down its display resolution. This can be controlled under Sailfish IDE with **Options → Sailfish OS → Emulator → Emulator Mode...**. For the emulator used by the active **Run Configuration** a shortcut exists as **Tools → Sailfish OS → Emulator Mode...**. As a fallback option it is also possible to select **View → Scale** or press Host + ‘C’ in the emulator window.

## Now I’ve built an awesome application – where do I share it?

The official place to share Sailfish OS applications is the [Jolla Harbour](http://harbour.jolla.com/).

## I get the following error, it can’t create symlinks, what is the problem?
```
ln -s libfoo.so.1.0.0 libfoo.so
ln: creating symbolic link `libfoo.so.1':
Protocol error make[1]: [libfoo.so.1.0.0] Error 1 (ignored)
```

This happens when `TARGET=library` is set in your library’s `.pro` file. In Linux a library gets three additional symlinks:
```nosh
libfoo.so -> libfoo.so.1.0.0
libfoo.so.1 -> libfoo.so.1.0.0
libfoo.so.1.0 -> libfoo.so.1.0.0
```

Since the build location is on the shared home directory from Windows which does not support symlinks, this error happens. You can work around this problem by setting `TARGET=plugin`, then a non-versioned library will be created during build time. If you want the symlinks in the RPM file, you could create them in the `%install` section of your `.spec` file like this:
```specfile
mv %{buildroot}/%{_libdir}/libfoo.so %{buildroot}/%{_libdir}/libfoo.so.1.0.0
ln -s -t %{buildroot}/%{_libdir}/libfoo.so.1.0.0 %{buildroot}/%{_libdir}/libfoo.so
ln -s -r %{buildroot}/%{_libdir}/libfoo.so.1.0.0 %{buildroot}/%{_libdir}/libfoo.so.1
ln -s -r %{buildroot}/%{_libdir}/libfoo.so.1.0.0 %{buildroot}/%{_libdir}/libfoo.so.1.0
```

## How can I avoid issues with incompatible line endings?

It is recommended that text files under Sailfish OS projects use Unix-style line endings by default and exceptions are done explicitly.

It helps a lot when the version control system is configured in a way that other people get existing files checked out with the desired line endings on all platforms. This is not the default usually. Git clients are usually configured so that they do line endings conversion during commit and check out operations. They maintain Unix-style line endings in the repository and host-native line endings in the working tree. This can be conveniently overriden at per-repository basis as in the following example.

Store the following content in the '.gitattributes' file under the root of the repository,
```gitattributes
# Use target-compatible line endings as the safe default for cross compilation.
* text=auto eol=lf
```

add it to the index and renormalize existing files under repository.
```nosh
$ git add .gitattributes
$ git add --renormalize .
$ git commit -m 'Normalize line endings'
```

Finally renormalize the line endings under the working tree as well.
```nosh
$ git rm --cached -r .
$ git reset --hard
```

Since now, Git will warn you when a file with other than Unix-style line endings is added to the index.
```
$ git add file-with-crlf.txt
warning: CRLF will be replaced by LF in file-with-crlf.txt.
The file will have its original line endings in your working directory
```

If this is intentional, attributes for the file should be explicitly overriden in '.gitattributes'.
```gitattributes
* text=auto eol=lf
file-with-crlf.txt text eol=crlf
```

If it was unintentional, then your text editor may need to be reconfigured to use Unix-style line endings by default for newly created files. Under Qt Creator it is **Options \> Text Editor \> Behavior \> Default line endings**. (Requires SDK \>= 3.3)

SDK issues the following build time warning when files with CRLF line endings are found under the project repository:
```
Files with CRLF line endings found. Consult the Sailfish SDK FAQ to learn why to avoid that and how.
```

Should you need to continue using CRLF line endings for your project files, it is sufficient that the RPM .spec and .yaml files use Unix-style line endings in order to suppress that warning.

## Docker

### How can I set up Docker for use with Sailfish SDK?

Please find the instructions on the [Sailfish SDK Installation](/Tools/Sailfish_SDK/Installation) page.

### I just upgraded my SDK, how can I switch to the Docker-based build engine?

Build engine selection is only possible during fresh Sailfish SDK installation. You need to reinstall.

### How does the Docker-based build engine compare on the performance side?

Build times with the Docker-based build engine are usually 30-40% shorter than with the VirtualBox-based build engine both on Linux and Windows. On Linux this also means that the build times achieved with the Docker-based build engine are more or less equal to the build times achieved with the (Linux-only) Platform SDK.

### Is VirtualBox still a requirement with Docker-based build engine used?

When the Docker-based build engine is chosen, VirtualBox becomes an optional dependency required by Sailfish OS emulators only. If you do not use emulators, you may install Sailfish SDK where VirtualBox is not available.

### What are the compatibility issues with Sailfish OS emulators on Windows?

Docker on Windows relies on Hyper-V as a virtualization backend while Sailfish OS emulators rely on VirtualBox. Until recently, it was not possible to use Hyper-V simultaneously with other virtualization technologies. Recent Windows and VirtualBox versions are said to remove this limitation but the informations and user reports vary. There seems to be no simple answer to the question whether the emulators will be usable on your particular configuration when Docker is in use.

Hints:

  - Some sources mention Windows 10 1809 and VirtualBox 6.1.6 as the minimum versions
  - Some sources mention troubles to persist (or emerge) with newer versions
  - Our testing indicates that VirtualBox 6.1.30 works reasonably well - if you are having issues, try downgrading your VirtualBox to this version
  - Try increasing the number of processors available to the emulator VM (sfdk emulator set vm.cpuCount=N). Try setting the maximum first

### Is macOS support on the plan?

The main issue with VirtualBox-based build engine is the limited performance of its file system sharing solution. Unfortunately the file system sharing solution of Docker on macOS in not better in this respect and so replacing VirtualBox with Docker would not make the expected difference.

Recent versions of Docker Desktop for macOS come up with options to tune the shared file IO performance at the cost of limited guarantees on host-container file system consistency ([3](https://docs.docker.com/docker-for-mac/osxfs-caching/)). It needs to be investigated yet if the implications are acceptable in our use case.

### Old sailfish-os-build-engine images keep piling up, is this desired?

This is a known issue with the initial Docker support. With every build engine start/stop cycle, one new image layer is created. Should you hit the limit of maximum 127 layers per Docker image meanwhile, there are basically two options how to recover:

1.  Reinstall the Sailfish SDK (recommended)
2.  Flatten the history manually by following one of those guides available on the web, e.g., [4](https://tuhrig.de/flatten-a-docker-container-or-image/) and taking care of restoring all the LABELs and the CMD set on the image.

### How can I debug build engine boot issues?

You can learn the arguments necessary for successul build engine container instantiation from sfdk's debug output. sfdk will only create the container if it is missing, so remove the possibly existing container first:

```
docker container rm sailfish-sdk-build-engine
QT_LOGGING_RULES=sfdk.queue.debug=true sfdk engine start
```

Look for a line like

```
sfdk.queue: [D] Enqueued 0x55bc04834be0 "/usr/bin/docker" ("create", ..., "/sbin/init")
```

Store the arguments in a shell variable for later use:

```
args=("create", ..., "/sbin/init")
args=("${args[@]%,}") # drop trailing commas
unset args[0] # drop the command name
```

Now you can start playing with the container:

```
docker container run --rm --interactive --tty "${args[@]}" --show-status
```
