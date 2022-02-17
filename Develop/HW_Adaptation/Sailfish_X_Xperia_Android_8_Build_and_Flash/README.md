---
title: Sailfish X Xperia Android 8 Build and Flash
permalink: Develop/HW_Adaptation/Sailfish_X_Xperia_Android_8_Build_and_Flash/
parent: HW Adaptation
layout: default
nav_order: 300
---

# Sailfish OS Hardware Adaptation Development Kit for Sony Xperia XA2

Here you will find instructions how to build Sailfish OS image and flash it to Sony Xperia XA2 device.

## ChangeLog

  - 2020-06-16: Align with the latest build scripts
  - 2019-03-15: More community contributions taken in to de-clutter the build process, and align with HADK 3.0.1
  - 2019-03-05: Cleaned up packages that do not gracefully install under the Platform SDK target, thanks to community's contributions to the helper build scripts!
  - 2019-03-01: Adapt from Xperia X flash and build instructions

## Building

Please download the latest Sailfish OS HADK (Hardware Adaptation Development Kit) from within [this link](https://sailfishos.org/hadk).

If used previously, you'll need to re-install/update your build environment to Sailfish OS Platform SDK 3.0.0 (or newer), delete old target and tooling, and create new target and tooling, just like HADK \>=v3 instructs.

If you are new to HADK, please carefully read the disclaimer on page 1, then **chapters 1 and 2**.

The disk space requirement for this build is not 16GB as HADK says, but around 90GB . The download bandwidth requirement is around 30GB.

HADK uses CyanogenMod as reference base. Here we'll instead have Sony's stock Android (8.1.x). Now you can read through **chapter 3** of the HADK.

If you ever run into difficulties, we're there to help in the [#sailfishos-porters](https://webchat.oftc.net/?channels=#sailfishos-porters) channel on IRC at oftc.net.

In **chapter 4** (*Setting up the SDKs*) setup the environment in ~/.hadk.env with additional variables (here we'll build for Sony Xperia XA2 Dual SIM variant):
```nosh
export VENDOR=sony
export DEVICE=h4113
export HABUILD_DEVICE=pioneer
export FAMILY=nile
export BRANCH=8.1.0_r52
export HAVERSION="sony-aosp-"$BRANCH"_20190206"
```

Follow through the **chapter 4** until the end, and **ignore chapter 5**, instead perform the following:
```nosh
HABUILD_SDK $

git config --global user.name "Your Name"
git config --global user.email "you@example.com"
```

At this point, install Android's repo tool: <https://source.android.com/source/downloading#installing-repo>. Then
```nosh
HABUILD_SDK $

sudo apt-get install libssl-dev
sudo mkdir -p $ANDROID_ROOT
sudo chown -R $USER $ANDROID_ROOT
cd $ANDROID_ROOT
repo init -u git://github.com/mer-hybris/android.git -b hybris-$HAVERSION -m tagged-manifest.xml
# Adjust X to your bandwidth capabilities
repo sync -jX --fetch-submodules
source build/envsetup.sh
export USE_CCACHE=1
lunch aosp_$DEVICE-user
git clone https://github.com/sailfishos/droidmedia external/droidmedia
make -j$(nproc --all) hybris-hal droidmedia
```

If you encounter errors, check with HADK's section 5.5 "Common Pitfalls", and if it's not there, ask us on IRC.

Once you have hybris-boot.img and hybris-recovery.img files successfully built, go through **chapter 6** of the HADK document.

Ignore **chapter 7**, but do the following instead:
```nosh
PLATFORM_SDK $

cd $ANDROID_ROOT
sudo zypper ref
rpm/dhd/helpers/build_packages.sh --droid-hal
git clone --recursive https://github.com/mer-hybris/droid-config-sony-$FAMILY hybris/droid-configs -b master
if [ -z "$(grep community_adaptation $ANDROID_ROOT/hybris/droid-configs/rpm/droid-config-$DEVICE.spec)" ]; then
  sed -i '/%include droid-configs-device/i%define community_adaptation 1\n' $ANDROID_ROOT/hybris/droid-configs/rpm/droid-config-$DEVICE.spec
fi
if [ -z "$(grep patterns-sailfish-consumer-generic $ANDROID_ROOT/hybris/droid-configs/patterns/jolla-configuration-$DEVICE.yaml)" ]; then
  sed -i "/Summary: Jolla Configuration $DEVICE/i- patterns-sailfish-consumer-generic\n- pattern:sailfish-porter-tools\n" $ANDROID_ROOT/hybris/droid-configs/patterns/jolla-configuration-$DEVICE.yaml
fi
if [ -z "$(grep jolla-devicelock-daemon-encsfa $ANDROID_ROOT/hybris/droid-configs/patterns/jolla-hw-adaptation-$HABUILD_DEVICE.yaml)" ]; then
  sed -i "s/sailfish-devicelock-fpd/jolla-devicelock-daemon-encsfa/" $ANDROID_ROOT/hybris/droid-configs/patterns/jolla-hw-adaptation-$HABUILD_DEVICE.yaml
  sed -i "/Obsoletes: jolla-devicelock-[a-z]*-encsfa/d" $ANDROID_ROOT/hybris/droid-configs/droid-config-common.inc
fi
rpm/dhd/helpers/build_packages.sh --configs
rpm/dhd/helpers/build_packages.sh --mw # select "all" option when asked
```

After all's built, proceed with:
```nosh
PLATFORM_SDK $

rpm/dhd/helpers/build_packages.sh --gg
rpm/dhd/helpers/build_bootimg_packages.sh
sb2 -t $VENDOR-$DEVICE-$PORT_ARCH -m sdk-install -R zypper in --force-resolution droid-hal-$HABUILD_DEVICE-kernel-modules
git clone --recursive https://github.com/mer-hybris/droid-hal-img-boot-sony-$FAMILY hybris/mw/droid-hal-img-boot-sony-$FAMILY
rpm/dhd/helpers/build_packages.sh --mw=https://github.com/mer-hybris/droid-hal-img-boot-sony-$FAMILY --spec=rpm/droid-hal-$HABUILD_DEVICE-img-boot.spec

rpm/dhd/helpers/build_packages.sh --mw=https://github.com/mer-hybris/droid-system-sony-$FAMILY-$HABUILD_DEVICE --spec=rpm/droid-system-$HABUILD_DEVICE.spec --spec=rpm/droid-system-$HABUILD_DEVICE-$DEVICE.spec
rpm/dhd/helpers/build_packages.sh --mw=https://github.com/mer-hybris/droid-vendor-sony-$FAMILY-$HABUILD_DEVICE --spec=rpm/droid-system-vendor-$HABUILD_DEVICE.spec --spec=rpm/droid-system-vendor-$HABUILD_DEVICE-$DEVICE.spec

git clone --recursive https://github.com/mer-hybris/droid-hal-version-sony-$FAMILY hybris/droid-hal-version-$DEVICE
rpm/dhd/helpers/build_packages.sh --version
```

Next, please proceed with:
```nosh
PLATFORM_SDK $

export RELEASE=3.3.0.16
export EXTRA_NAME=-my1
sudo zypper in lvm2 atruncate pigz
sudo zypper in android-tools
cd $ANDROID_ROOT
rpm/dhd/helpers/build_packages.sh --mic
```

If you want to rebuild your image again later, umount any `/var/tmp/mic/imgcreate-*/` mounts manually.

The command above will yield a flashable archive, such as `$ANDROID_ROOT/sfe-h4113-3.3.0.16-my1/Sailfish_OS--my1-3.3.0.16-h4113-0.0.1.1.zip` that you will use to flash your device as explained in the next section.

## Flashing

All the instructions you will find on our website (yet use your own built .zip bundle!): <https://jolla.com/sailfishx-linux-instructions-xa2/>

Note: in `flash.sh` you will need to replace `@DEVICES@` with your `$DEVICE` value in uppercase, e.g. `H4113`. Naturally, after that you'll need to adjust or remove the line containing `flash.sh` in the `md5.lst` file.

## Feedback

If you find bugs while building an image from this page, please report them in our IRC channel.


Have fun and enjoy our first fully-flashable Sailfish OS image built by you!
Your Jolla HW Team
