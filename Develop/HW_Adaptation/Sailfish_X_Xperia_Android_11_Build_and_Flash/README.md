---
title: Sailfish X Xperia Android 11 Build and Flash
permalink: Develop/HW_Adaptation/Sailfish_X_Xperia_Android_11_Build_and_Flash/
parent: HW Adaptation
layout: default
nav_order: 600
---

# Sailfish OS Hardware Adaptation Development Kit for Sony Xperia 10 III

Here you will find instructions how to build Sailfish OS image and flash it to Sony Xperia 10 III device, which can be used as reference to port any other Sony Xperia Open Device that has Android 11 support.


## Building

Please download the latest Sailfish OS HADK (Hardware Adaptation Development Kit) from within [this link](/Develop/HADK).

Please check the requirements for your build host: <https://source.android.com/setup/build/requirements>

Minimum Sailfish OS version for this port is 4.4.0.58. You can also use Sailfish OS version 4.5.0.18. Using Platform SDK version 4.5.0.18 is strongly recommended. While it is possible to build with Platform SDK 4.4.0.58, these instructions assume using version 4.5.0.18.

If you are new to HADK, please carefully read the disclaimer on page 1, then **chapters 1 and 2**.

The disk space requirement for this build is not what HADK says, but around 300GB . The download size requirement is around 50GB.

HADK uses LineageOS/CyanogenMod as reference base. Here we'll instead have AOSP (Android Open Source Project) 11.0. Now you can read through **chapter 3** of the HADK.

If you ever run into difficulties, please look through the links in the topic of the [#sailfishos-porters](https://webchat.oftc.net/?channels=#sailfishos-porters) channel on IRC at oftc.net.

In **chapter 4** (*Setting up the SDKs*) setup the environment as requested in ~/.hadk.env, but then set and add the following additional variables (here we'll build for Sony Xperia 10 III, Dual SIM variant being its only one):
```nosh
export VENDOR=sony
export DEVICE=xqbt52
export HABUILD_DEVICE=pdx213
export FAMILY=lena
export ANDROID_VERSION_MAJOR=11
export HAVERSION="sony-aosp-"$ANDROID_VERSION_MAJOR
```

Follow through the **chapter 4** until the end, and **ignore chapter 5**, instead perform the following:
```nosh
HABUILD_SDK $

sudo apt-get install cpio libssl-dev ccache
sudo mkdir -p $ANDROID_ROOT
sudo chown -R $USER $ANDROID_ROOT
cd $ANDROID_ROOT
git clone --recurse-submodules https://github.com/mer-hybris/droid-hal-sony-$FAMILY .

git config --global user.name "Your Name"
git config --global user.email "you@example.com"
```

You'll need to ensure you have the `repo` command from the AOSP source code repositories installed. See the [Android Source instructions](https://source.android.com/setup/develop#installing-repo) for how to install it. Once available you can continue:

```nosh
# To save space, you can add "--depth=1 -c" flags to repo init:
repo init -u https://github.com/mer-hybris/android.git -b $HAVERSION -m tagged-localbuild.xml
# Adjust X to bandwidth capabilities
repo sync -jX
git clone --recurse-submodules https://github.com/mer-hybris/droid-src-sony droid-src -b "hybris-"$HAVERSION
ln -s droid-src/patches
droid-src/apply-patches.sh --mb
./setup-sources.sh --mb

source build/envsetup.sh
export USE_CCACHE=1
export CCACHE_EXEC=/usr/bin/ccache
lunch aosp_$DEVICE-user
cd kernel/sony/msm-4.19/common-kernel
./build-kernels-clang.sh -d $HABUILD_DEVICE -O $ANDROID_ROOT/out/target/product/$HABUILD_DEVICE/obj/kernel || echo ERROR: kernel build failed, please inspect the log file
# FIXME after this is merged and reapplied: https://github.com/sonyxperiadev/kernel-sony-msm-4.14-common/pull/14
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
```
If the above command prints:
`Fatal: None of the selected test suites operate on the selected test levels. Nothing to do.`
Ignore the error message, instead check the output of:
```
ls droid-local-repo/xqbt52
```
The output should be like:
```
droid-hal-pdx213-1.9.7-202306070618.aarch64.rpm
droid-hal-pdx213-detritus-1.9.7-202306070618.aarch64.rpm
droid-hal-pdx213-devel-1.9.7-202306070618.aarch64.rpm
droid-hal-pdx213-kernel-1.9.7-202306070618.aarch64.rpm
droid-hal-pdx213-kernel-dtbo-1.9.7-202306070618.aarch64.rpm
droid-hal-pdx213-kernel-modules-1.9.7-202306070618.aarch64.rpm
droid-hal-pdx213-tools-1.9.7-202306070618.aarch64.rpm
droid-hal-pdx213-users-1.9.7-202306070618.aarch64.rpm
droid-hal-rk3399_all-users-0.0.6-202208241247.aarch64.rpm
```

Now continue with:
```
git clone --recursive https://github.com/mer-hybris/droid-config-sony-$FAMILY hybris/droid-configs -b upgrade-4.5.0
if [ -z "$(grep patterns-sailfish-consumer-generic $ANDROID_ROOT/hybris/droid-configs/patterns/patterns-sailfish-device-configuration-$DEVICE.inc)" ]; then
  sed -i "/Summary: Jolla Configuration $DEVICE/aRequires: patterns-sailfish-consumer-generic\n\n# Early stages of porting benefit from these:\nRequires: patterns-sailfish-device-tools" $ANDROID_ROOT/hybris/droid-configs/patterns/patterns-sailfish-device-configuration-$DEVICE.inc
fi
# Clean out unavailable packages
if [ -n "$(grep modem_auto_config $ANDROID_ROOT/hybris/droid-configs/patterns/patterns-sailfish-device-adaptation-$HABUILD_DEVICE.inc)" ]; then
  sed -i "/modem_auto_config/d" $ANDROID_ROOT/hybris/droid-configs/patterns/patterns-sailfish-device-adaptation-$HABUILD_DEVICE.inc
fi
if [ -n "$(grep ofono-vendor-qti-radio-plugin $ANDROID_ROOT/hybris/droid-configs/patterns/patterns-sailfish-device-adaptation-$HABUILD_DEVICE.inc)" ]; then
  sed -i "/ofono-vendor-qti-radio-plugin/d" $ANDROID_ROOT/hybris/droid-configs/patterns/patterns-sailfish-device-adaptation-$HABUILD_DEVICE.inc
fi
rpm/dhd/helpers/build_packages.sh --configs
```
If the above command prints:
`Fatal: None of the selected test suites operate on the selected test levels. Nothing to do.`
try running it again.

```
cd hybris/mw/libhybris
git checkout upgrade-4.5.0
cd -

rpm/dhd/helpers/build_packages.sh --mw # select "all" option when asked
```

Without waiting for the middleware to finish, open new shell terminal.
```nosh
HABUILD_SDK $

export ANDROID_SYSPART=$ANDROID_ROOT-syspart
sudo mkdir -p $ANDROID_SYSPART
sudo chown -R $USER $ANDROID_SYSPART
cd $ANDROID_SYSPART
# If you plan to contribute to syspart (/system partition), remove the "--depth=1 -c" flags below
repo init -u https://github.com/mer-hybris/android.git -b $HAVERSION -m tagged-manifest.xml --depth=1 -c
# Adjust X to bandwidth capabilities
repo sync -jX --fetch-submodules
ln -s rpm/patches .
rpm/apply-patches.sh --mb

source build/envsetup.sh
export USE_CCACHE=1
export CCACHE_EXEC=/usr/bin/ccache
lunch aosp_$DEVICE-user
# Ensure the middleware in the previous shell terminal has finished building
# Change $(nproc --all) to your building capabilities, it will be very heavy on RAM if you go for more cores, proceed with care:
make -j$(nproc --all) systemimage vendorimage
# This might take some time (~2.5 hours on Intel Xeon's 12 cores)

mkdir -p $ANDROID_SYSPART-tmp
sudo mkdir -p $ANDROID_SYSPART-mnt-system
simg2img $ANDROID_SYSPART/out/target/product/$HABUILD_DEVICE/system.img $ANDROID_SYSPART-tmp/system.img.raw
sudo mount $ANDROID_SYSPART-tmp/system.img.raw $ANDROID_SYSPART-mnt-system

sudo mkdir -p $ANDROID_SYSPART-mnt-vendor/vendor
simg2img $ANDROID_SYSPART/out/target/product/$HABUILD_DEVICE/vendor.img $ANDROID_SYSPART-tmp/vendor.img.raw
sudo mount $ANDROID_SYSPART-tmp/vendor.img.raw $ANDROID_SYSPART-mnt-vendor/vendor

cd $ANDROID_ROOT/hybris/mw
D=droid-system-$VENDOR-template
git clone --recursive https://github.com/mer-hybris/$D
cd $D
# The following command will throw up patch errors for `init.wod.rc`, `ld.config.28.txt` and `ld.config.29.txt`. These are to be expected and can be ignored.
sudo droid-system-device/helpers/copy_tree.sh $ANDROID_SYSPART-mnt-system/system $ANDROID_SYSPART-mnt-vendor/vendor rpm/droid-system-$HABUILD_DEVICE.spec
sudo chown -R $USER .
# You can commit the changes, but before you push them out, make sure:
# - to check binary file/repo size limits
# - to rename the public repo as droid-system-sony-$FAMILY-$HABUILD_DEVICE
# - to not contribute binary files to this *-template repo
sudo umount $ANDROID_SYSPART-mnt-vendor/vendor
sudo umount $ANDROID_SYSPART-mnt-system
rm $ANDROID_SYSPART-tmp/{system,vendor}.img.raw
sudo rm -rf $ANDROID_SYSPART-mnt-{system,vendor}
rmdir $ANDROID_SYSPART-tmp || true
```

You can now close the above shell terminal. Next, please proceed with:
```nosh
PLATFORM_SDK $

cd $ANDROID_ROOT
rpm/dhd/helpers/build_packages.sh --gg

rpm/dhd/helpers/build_packages.sh --mw=https://github.com/mer-hybris/droid-hal-img-boot-sony-$FAMILY --spec=rpm/droid-hal-$HABUILD_DEVICE-img-boot.spec

rpm/dhd/helpers/build_packages.sh --mw=https://github.com/mer-hybris/droid-system-sony-template --spec=rpm/droid-system-$HABUILD_DEVICE.spec --spec=rpm/droid-system-$HABUILD_DEVICE-$DEVICE.spec

git clone --recursive https://github.com/mer-hybris/droid-hal-version-sony-$FAMILY hybris/droid-hal-version-$DEVICE
rpm/dhd/helpers/build_packages.sh --version

# The next two variables are explained in chapter 8
export RELEASE=4.5.0.19
export EXTRA_NAME=-my1
sudo zypper in lvm2 atruncate pigz android-tools
cd $ANDROID_ROOT
srcks=$ANDROID_ROOT/hybris/droid-configs/installroot/usr/share/kickstarts/Jolla-@RELEASE@-$DEVICE-@ARCH@.ks
sed -i "s @DEVICEMODEL@ $DEVICE " $srcks
rpm/dhd/helpers/build_packages.sh --mic
```

The command above will yield a flashable archive, such as `$ANDROID_ROOT/SailfishOS-release-<version>-<device>-my1/SailfishOS--my1-<version>-<device>-<hw-version>.zip` that you'll use to flash your device as explained in the next section.

## Flashing

You will find the instructions for Xperia 10 II on our website that you can easily refer from (yet use your own built .zip bundle!): <https://jolla.com/how-to-install-sailfish-x-on-xperia-10-ii-on-linux/>

## Adaptation Status

Feel free to help out in areas that you like.

What works:

  - gps, bluetooth, wifi & internet sharing, mobile data, modem, camera, sensors, music/video playback
  - fingerprint works
  - USB networking

Known issues:

  - Camera:
    - Sensors of tele and uwide lenses are disabled for now, because they depend on MultiCamera which creates issues when switching between front and rear in Camera1 API mode.
      Similar bug on AOSP too: <https://github.com/sonyxperiadev/bug_tracker/issues/732>
  - 3rd party caller may hear their own voice echo; use low volume, wired headphones, or loudspeaker as workaround. AOSP report: <https://github.com/sonyxperiadev/bug_tracker/issues/771>
  - LED indicator colours have a visibly stronger green component: <https://github.com/sonyxperiadev/bug_tracker/issues/772>
  - The FM Radio is not currently available for use.

### Contributing to Sony AOSP

If you want to help out with underlying issues in AOSP (fixing those will also fix them in SFOS, magic!:), follow this guide to build an AOSP 11 image: <https://developer.sony.com/open-source/aosp-on-xperia-open-devices/guides/aosp-build-instructions/build-aosp-android-11-0/>

Use this script to flash the AOSP images (the above website is pending an update for that step):

```nosh
fastboot reboot fastboot
fastboot flash boot_a boot.img
fastboot flash dtbo_a dtbo.img
fastboot flash product_a product.img
fastboot flash recovery_a recovery.img
fastboot flash oem SW_binaries_for_Xperia_Android_11_4.19_v9a_$FAMILY.img
fastboot flash --disable-verity --disable-verification vbmeta_a vbmeta.img
fastboot flash --disable-verity --disable-verification vbmeta_system_a vbmeta_system.img
fastboot flash vendor_a vendor.img
fastboot flash system_a system.img
fastboot flash system_ext_a system_ext.img
fastboot flash userdata userdata.img
fastboot erase metadata
fastboot --set-active=a
fastboot reboot
```

## Feedback

If you find bugs while building an image from this page, please report them in our IRC channel.


Have fun and enjoy the fully-flashable Sailfish OS image built by you!
Your Jolla HW Team
