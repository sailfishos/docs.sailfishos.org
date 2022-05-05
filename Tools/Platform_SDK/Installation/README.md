---
title: Installation
permalink: Tools/Platform_SDK/Installation/
parent: Sailfish Platform SDK
layout: default
nav_order: 100
---

**Attention: Platform development is now more convenient with the regular [Sailfish SDK](/Develop/Platform) through its command line frontend 'sfdk', available on all Linux, macOS and Windows. The Linux-only chroot based Sailfish Platform SDK remains available for special applications. It also remains the default (documented) option for [Hardware Adaptation Development](/Tools/Hardware_Adaptation_Development_Kit), although the regular Sailfish SDK can be used for that purpose as well.**

The Sailfish Platform SDK contains [Development Tools](/Tools/Development) like Scratchbox2, [MIC (Image Creation)](mic "brokenlink"), [Spectacle](/Spectacle "brokenlink"), osc, qemu, etc, to make it easier for a developer to work with Sailfish OS.

# Quick start

If you're in a hurry then this should get you going (if it doesn't work then read the full instructions carefully!) :
```nosh
export PLATFORM_SDK_ROOT=/srv/sailfishos
curl -k -O https://releases.sailfishos.org/sdk/installers/latest/Jolla-latest-SailfishOS_Platform_SDK_Chroot-i486.tar.bz2
sudo mkdir -p $PLATFORM_SDK_ROOT/sdks/sfossdk
sudo tar --numeric-owner -p -xjf Jolla-latest-SailfishOS_Platform_SDK_Chroot-i486.tar.bz2 -C $PLATFORM_SDK_ROOT/sdks/sfossdk
echo "export PLATFORM_SDK_ROOT=$PLATFORM_SDK_ROOT" >> ~/.bashrc
echo 'alias sfossdk=$PLATFORM_SDK_ROOT/sdks/sfossdk/sdk-chroot' >> ~/.bashrc; exec bash
echo 'PS1="PlatformSDK $PS1"' > ~/.mersdk.profile
echo '[ -d /etc/bash_completion.d ] && for i in /etc/bash_completion.d/*;do . $i;done' >> ~/.mersdk.profile
sfossdk
```

**Attention:** If you chose `PLATFORM_SDK_ROOT` other than `/srv/mer` and your SDK version is 4.3.0.15 (check `/etc/os-release` inside), the following workaround is needed:

```nosh
echo 'mount_sdk() { sudo mount -o rbind "$sdkroot/srv" "$sdkroot/parentroot/srv"; }' >> ~/.mersdkrc
```

Once you've installed the Sailfish Platform SDK you'll need to [install a Sailfish Platform SDK Target](/Tools/Platform_SDK/Target_Installation).

It's recommended that you read sections below for pre-requisites, options and details on installing extra architecture toolchains, tools etc.

# Sailfish Platform SDK

The default download contains:

  - Development tools
  - Image creation tools
  - OBS development tools

You can also install :

  - Debugging tools
  - Testing tools
  - Python development
  - Ruby development

# Installing the Sailfish Platform SDK

## SDK Requirements

The Sailfish Platform SDK will run on most modern Linux machines. It needs:

  - Linux distribution (one in a virtual machine works well), running 2.6.37 or newer kernel
  - about 400Mb free space to install
  - The SDK must be installed on a standard filesystem and "nosuid" must not be set. (Note: [recent ecryptfs](http://askubuntu.com/questions/210048/error-when-running-binary-with-root-setuid-under-encrypted-home-directory) will automatically use and enforce nosuid. Automounted usb drives typically have "nosuid" set too.)
  - hundreds of Mb for rpm caches for osc and mic as well as for SB2 targets
  - Generic x86 CPU
  - user must have sudo rights

## Installation / setup

The Sailfish Platform SDK is provided as a rootfs tarball that contains essential tools for Sailfish OS platform development along with a helper script to enter the rootfs.

Filesystem requirements:

  - The Sailfish Platform SDK can be installed to any location with enough space - we'll use /srv/ as per the [Linux FHS](http://www.pathname.com/fhs/pub/fhs-2.3.html#SRVDATAFORSERVICESPROVIDEDBYSYSTEM) (feel free to adapt the commands to use any other location).
  - The installation path must contain an intermediate directory called 'sdks' which only has Sailfish Platform SDKs inside. eg /srv/sailfishos/sdks/sfossdk/...

To setup the Sailfish Platform SDK:

  - Download the latest stable Sailfish Platform SDK rootfs tarball with the common armv7hl toolchain preinstalled:
```nosh
curl -k -O https://releases.sailfishos.org/sdk/installers/latest/Jolla-latest-SailfishOS_Platform_SDK_Chroot-i486.tar.bz2
```

  - Optionally, you can check the release notes from the [Sailfish SDK Release Notes](/Tools/Sailfish_SDK#release-notes). The SDK Build Engine section also contains the latest changes to the Sailfish Platform SDK.

<!-- end list -->

  - Create a directory for the Sailfish Platform SDK rootfs and extract the tarball as root or with sudo:
```nosh
sudo mkdir -p /srv/sailfishos/sdks/sfossdk
sudo tar --numeric-owner -p -C /srv/sailfishos/sdks/sfossdk -xjf Jolla-latest-SailfishOS_Platform_SDK_Chroot-i486.tar.bz2
```

**Attention:** If you chose installation prefix other than `/srv/mer` and your SDK version is 4.3.0.15 (check `/etc/os-release` inside), the following workaround is needed:

```nosh
echo 'mount_sdk() { sudo mount -o rbind "$sdkroot/srv" "$sdkroot/parentroot/srv"; }' >> ~/.mersdkrc
```

## Sailfish Platform SDK control script

The Sailfish Platform SDK rootfs contains a helper script to enter the chroot named 'sdk-chroot'. The helper script is located in the root directory (/) of the rootfs. It requires you to have sudo ability.

As mentioned, the Sailfish Platform SDK is location independent so it uses the location of the helper script to determine which Sailfish Platform SDK to enter.

## Entering Sailfish Platform SDK

Before entering the Sailfish Platform SDK you may want to make an Sailfish Platform SDK equivalent of ".profile" to give you a nice prompt to remind you that you are in the Sailfish Platform SDK. This also reads the bash autocompletion scripts from inside the chroot.
```nosh
cat << EOF >> ~/.mersdk.profile
PS1="PlatformSDK \$PS1"
if [ -d /etc/bash_completion.d ]; then
   for i in /etc/bash_completion.d/*;
   do
      . \$i
   done
fi
EOF
```

If you use multiple Sailfish Platform SDK instances, you can utilise the `SAILFISH_SDK` shell variable to determine the absolute path to the Sailfish Platform SDK chroot in use (since Sailfish OS release 4.3.0.15).

To enter the Sailfish Platform SDK rootfs with the helper script run
```nosh
/srv/sailfishos/sdks/sfossdk/sdk-chroot
```

You should find that you are operating under your normal username and that your home directory is available as `/home/<username>` and any other mountpoints are mounted under `/parentroot/*`

You have sudo rights automatically. If sudo fails within the sdk, make sure that the filesystem the sdk is on is not mounted with the "nosuid" parameter. "mount" on the host system gives you this information, add "suid" as parameter in fstab, if necessary.

## Useful Alias

If you tend to use a single instance of the Sailfish Platform SDK then this alias is useful
```nosh
echo alias sfossdk=/srv/sailfishos/sdks/sfossdk/sdk-chroot >> ~/.bashrc ; exec bash
```

# Next Steps

The next step is to look at [setting up the Sailfish Platform SDK Targets](/Tools/Platform_SDK/Target_Installation) and installing and using more [Development Tools](/Tools/Development)

# Updating the Sailfish Platform SDK

You can check your current release version by executing `ssu re` in the SDK. For a newer SDK release version check out the [Sailfish SDK Release Notes](/Tools/Sailfish_SDK#release-notes). In this example we will use Jolla release `2.0.2.48`.
```nosh
sudo ssu re 2.0.2.48
sudo zypper ref
sudo zypper dup
```

# Removing the Sailfish Platform SDK

[Remove all SDK Targets and Toolings](/Tools/Platform_SDK/Target_Installation#installing-sdk-target-and-tooling-tarballs), then simply exit all chroot instances and, using sudo, remove `/srv/sailfishos/sdks/sfossdk`.

# Extras

## Multiple Sailfish Platform SDKs

You should be able to install and connect to multiple Sailfish Platform SDKs at the same time.

## Known Issues

### "not enough disk space left" or similar

If you do actually have enough disk then the problem is possible that the kernel on your host is too old. To run Sailfish Platform SDK you should be running kernel 2.6.37 or newer on your host.
