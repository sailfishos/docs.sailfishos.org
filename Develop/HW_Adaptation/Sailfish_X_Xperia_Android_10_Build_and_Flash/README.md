---
title: Sailfish X Xperia Android 10 Build and Flash
permalink: Develop/HW_Adaptation/Sailfish_X_Xperia_Android_10_Build_and_Flash/
parent: HW Adaptation
layout: default
nav_order: 500
---

# Sailfish OS Hardware Adaptation Development Kit for Sony Xperia 10 II

Here you will find instructions how to build Sailfish OS image and flash it to Sony Xperia 10 II device, which can be used as reference to port any other Sony Xperia Open Device that has Android 10 support.

## ChangeLog

  - 2021-02-12: Published as technical guidance for Android 10 64bit ARM adaptations

## Building

Please download the latest Sailfish OS HADK (Hardware Adaptation Development Kit) from within [this link](https://sailfishos.org/hadk).

Please check the requirements for your build host: <https://source.android.com/setup/build/requirements>

Minimum Sailfish OS version for this port is 4.1.0.

If you are new to HADK, please carefully read the disclaimer on page 1, then **chapters 1 and 2**.

The disk space requirement for this build is not what HADK says, but around 200GB . The download size requirement is around 50GB.

HADK uses LineageOS/CyanogenMod as reference base. Here we'll instead have AOSP (Android Open Source Project) 10.0. Now you can read through **chapter 3** of the HADK.

If you ever run into difficulties, please look through the links in the topic of the [#sailfishos-porters](https://webchat.oftc.net/?channels=#sailfishos-porters) channel on IRC at oftc.net.

In **chapter 4** (*Setting up the SDKs*) setup the environment as requested in ~/.hadk.env, but then set and add the following additional variables (here we'll build for Sony Xperia 10 II Dual SIM variant):
```nosh
export VENDOR=sony
export DEVICE=xqau52
export HABUILD_DEVICE=pdx201
export FAMILY=seine
export ANDROID_VERSION_MAJOR=10
export HAVERSION="sony-aosp-"$ANDROID_VERSION_MAJOR
```

Follow through the **chapter 4** until the end, and **ignore chapter 5**, instead perform the following:
```nosh
HABUILD_SDK $

sudo apt-get install libssl-dev
sudo mkdir -p $ANDROID_ROOT
sudo chown -R $USER $ANDROID_ROOT
cd $ANDROID_ROOT
git clone --recurse-submodules https://github.com/mer-hybris/droid-hal-sony-$FAMILY .

git config --global user.name "Your Name"
git config --global user.email "you@example.com"

repo init -u git://github.com/mer-hybris/android.git -b $HAVERSION -m tagged-localbuild.xml
# Adjust X to bandwidth capabilities
repo sync -jX --fetch-submodules
git clone --recurse-submodules https://github.com/mer-hybris/droid-src-sony droid-src -b "hybris-"$HAVERSION
ln -s droid-src/patches
droid-src/apply-patches.sh --mb
./setup-sources.sh --mb

source build/envsetup.sh
export USE_CCACHE=1
lunch aosp_$DEVICE-user
cd kernel/sony/msm-4.14/common-kernel
./build-kernels-clang.sh -d $HABUILD_DEVICE -O $ANDROID_ROOT/out/target/product/$HABUILD_DEVICE/obj/kernel
# FIXME after this is merged: https://github.com/sonyxperiadev/kernel-sony-msm-4.14-common/pull/14
cp dtbo-$HABUILD_DEVICE.img $ANDROID_ROOT/out/target/product/$HABUILD_DEVICE/dtbo.img
cd -
git clone https://github.com/sailfishos/droidmedia external/droidmedia
make -j$(nproc --all) hybris-hal droidmedia
# This might take some time (1 hour on Intel Xeon's 12 cores)
```

If you encounter errors, check with HADK's section 5.5 "Common Pitfalls".

Once you have hybris-boot.img, hybris-recovery.img, and droidmedia files (including mini\*service et al.) successfully built, go through **chapter 6** of the HADK document.

Ignore **chapter 7**, but do the following instead:
```nosh
PLATFORM_SDK $

cd $ANDROID_ROOT
sudo zypper ref
rpm/dhd/helpers/build_packages.sh --droid-hal
git clone --recursive https://github.com/mer-hybris/droid-config-sony-$FAMILY hybris/droid-configs -b master
if [ -z "$(grep patterns-sailfish-consumer-generic $ANDROID_ROOT/hybris/droid-configs/patterns/patterns-sailfish-device-configuration-$DEVICE.inc)" ]; then
  sed -i "/Summary: Jolla Configuration $DEVICE/aRequires: patterns-sailfish-consumer-generic\n\n# Early stages of porting benefit from these:\nRequires: patterns-sailfish-device-tools" $ANDROID_ROOT/hybris/droid-configs/patterns/patterns-sailfish-device-configuration-$DEVICE.inc
fi
if [ -z "$(grep jolla-devicelock-daemon-encsfa $ANDROID_ROOT/hybris/droid-configs/patterns/patterns-sailfish-device-adaptation-$HABUILD_DEVICE.inc)" ]; then
  sed -i "s/sailfish-devicelock-fpd/jolla-devicelock-daemon-encsfa/" $ANDROID_ROOT/hybris/droid-configs/patterns/patterns-sailfish-device-adaptation-$HABUILD_DEVICE.inc
fi
if [ "$(grep 'Requires: ofono-binder-plugin' $ANDROID_ROOT/hybris/droid-configs/patterns/patterns-sailfish-device-adaptation-$HABUILD_DEVICE.inc)" ]; then
  sed -i "s/ofono-binder-plugin/ofono-ril-binder-plugin/" $ANDROID_ROOT/hybris/droid-configs/patterns/patterns-sailfish-device-adaptation-$HABUILD_DEVICE.inc
fi
rpm/dhd/helpers/build_packages.sh --configs
cd hybris/mw/libhybris
git checkout master
cd -
rpm/dhd/helpers/build_packages.sh --mw=https://github.com/mer-hybris/sailfish-connman-plugin-suspend.git
rpm/dhd/helpers/build_packages.sh --mw # select "all" option when asked
```

Without waiting for the middleware to finish, open new shell terminal.
```nosh
HABUILD_SDK $

sudo mkdir -p $ANDROID_ROOT-syspart
sudo chown -R $USER $ANDROID_ROOT-syspart
cd $ANDROID_ROOT-syspart
# if you plan to contribute to syspart (/system partition), remove "--depth=1" and "-c" flags below
repo init -u git://github.com/mer-hybris/android.git -b $HAVERSION -m tagged-manifest.xml --depth=1
# Adjust X to bandwidth capabilities
repo sync -jX --fetch-submodules -c
ln -s rpm/patches .
rpm/apply-patches.sh --mb

source build/envsetup.sh
export USE_CCACHE=1
lunch aosp_$DEVICE-user
# Ensure the middleware in the previous shell terminal has finished building
# Change $(nproc --all) to your building capabilities, it will be very heavy on RAM if you go for more cores, proceed with care:
make -j$(nproc --all) systemimage vendorimage
# This might take some time (~2.5 hours on Intel Xeon's 12 cores)

mkdir -p $ANDROID_ROOT-tmp
sudo mkdir -p $ANDROID_ROOT-mnt-system
simg2img $ANDROID_ROOT-syspart/out/target/product/$HABUILD_DEVICE/system.img $ANDROID_ROOT-tmp/system.img.raw
sudo mount $ANDROID_ROOT-tmp/system.img.raw $ANDROID_ROOT-mnt-system

sudo mkdir -p $ANDROID_ROOT-mnt-vendor/vendor
simg2img $ANDROID_ROOT-syspart/out/target/product/$HABUILD_DEVICE/vendor.img $ANDROID_ROOT-tmp/vendor.img.raw
sudo mount $ANDROID_ROOT-tmp/vendor.img.raw $ANDROID_ROOT-mnt-vendor/vendor

cd $ANDROID_ROOT/hybris/mw
D=droid-system-$VENDOR-template
git clone --recursive https://github.com/mer-hybris/$D
cd $D
sudo droid-system-device/helpers/copy_tree.sh $ANDROID_ROOT-mnt-system/system $ANDROID_ROOT-mnt-vendor/vendor rpm/droid-system-$HABUILD_DEVICE.spec
# You can commit the changes, but before you push them out, make sure:
# - to check binary file/repo size limits
# - to rename the public repo as droid-system-sony-$FAMILY-$HABUILD_DEVICE
# - to not contribute binary files to this *-template repo
sudo chown -R $USER .
sudo umount $ANDROID_ROOT-mnt-vendor/vendor
sudo umount $ANDROID_ROOT-mnt-system
rm $ANDROID_ROOT-tmp/{system,vendor}.img.raw
sudo rm -rf $ANDROID_ROOT-mnt-{system,vendor}
rmdir $ANDROID_ROOT-tmp || true
```

You can now close the above shell terminal. Next, please proceed with:
```nosh
PLATFORM_SDK $

cd $ANDROID_ROOT
rpm/dhd/helpers/build_packages.sh --gg
rpm/dhd/helpers/build_bootimg_packages.sh
git clone --recursive https://github.com/mer-hybris/droid-hal-img-boot-sony-$FAMILY hybris/mw/droid-hal-img-boot-sony-$FAMILY
rpm/dhd/helpers/build_packages.sh --mw=https://github.com/mer-hybris/droid-hal-img-boot-sony-$FAMILY --spec=rpm/droid-hal-$HABUILD_DEVICE-img-boot.spec

rpm/dhd/helpers/build_packages.sh --mw=https://github.com/mer-hybris/droid-system-sony-template --spec=rpm/droid-system-$HABUILD_DEVICE.spec --spec=rpm/droid-system-$HABUILD_DEVICE-$DEVICE.spec

git clone --recursive https://github.com/mer-hybris/droid-hal-version-sony-$FAMILY hybris/droid-hal-version-$DEVICE
rpm/dhd/helpers/build_packages.sh --version

# The next two variables are explained in chapter 8
export RELEASE=4.1.0.24
export EXTRA_NAME=-my1
sudo zypper in lvm2 atruncate pigz android-tools
cd $ANDROID_ROOT
srcks=$ANDROID_ROOT/hybris/droid-configs/installroot/usr/share/kickstarts/Jolla-@RELEASE@-$DEVICE-@ARCH@.ks
sed -i "s @DEVICEMODEL@ $DEVICE " $srcks
rpm/dhd/helpers/build_packages.sh --mic
```

The command above will yield a flashable archive, such as `$ANDROID_ROOT/SailfishOS-release-<version>-<device>-my1/SailfishOS--my1-<version>-<device>-<hw-version>.zip` that you'll use to flash your device as explained in the next section.

## Flashing

You will find the instructions on our website (yet use your own built .zip bundle!): <https://jolla.com/how-to-install-sailfish-x-on-xperia-10-ii-on-linux/>

## Adaptation Status

Feel free to help out in areas that you like. The list of known issues can be found here: https://forum.sailfishos.org/t/release-notes-suomenlinna-4-3-0/8495

## Feedback

If you find bugs while building an image from this page, please report them in our IRC channel.


Have fun and enjoy the fully-flashable Sailfish OS image built by you!
Your Jolla HW Team
