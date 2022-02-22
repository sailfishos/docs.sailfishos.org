---
title: Sailfish X Xperia Android 9 Build and Flash
permalink: Develop/HW_Adaptation/Sailfish_X_Xperia_Android_9_Build_and_Flash/
parent: HW Adaptation
layout: default
nav_order: 400
---

# Sailfish OS Hardware Adaptation Development Kit for Sony Xperia 10

Here you will find instructions how to build Sailfish OS image and flash it to Sony Xperia 10 device, which can be used as reference to port any other Sony Xperia Open Device that has Android 9 support.

## ChangeLog

  - 2020-06-16: Align with the latest build scripts
  - 2019-07-02: Adapt from Xperia XA2 flash and build instructions

## Building

Please download the latest Sailfish OS HADK (Hardware Adaptation Development Kit) from within [this link](https://sailfishos.org/hadk).

If you are new to HADK, please carefully read the disclaimer on page 1, then **chapters 1 and 2**.

The disk space requirement for this build is not what HADK says, but around 200GB . The download size requirement is around 50GB.

HADK uses LineageOS/CyanogenMod as reference base. Here we'll instead have AOSP (Android Open Source Project) 9.0. Now you can read through **chapter 3** of the HADK.

If you ever run into difficulties, please look through the links in the topic of the [#sailfishos-porters](https://webchat.oftc.net/?channels=#sailfishos-porters) channel on IRC at oftc.net.

In **chapter 4** (*Setting up the SDKs*) setup the environment as requested in ~/.hadk.env, but then set and add the following additional variables (here we'll build for Sony Xperia 10 Dual SIM variant):
```nosh
export VENDOR=sony
export DEVICE=i4113
export HABUILD_DEVICE=kirin
export FAMILY=ganges
export ANDROID_FLAVOUR=pie
export HAVERSION="sony-"$FAMILY"-aosp-"$ANDROID_FLAVOUR
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

sudo apt-get install cpio libssl-dev
sudo mkdir -p $ANDROID_ROOT
sudo chown -R $USER $ANDROID_ROOT
cd $ANDROID_ROOT
git clone --recurse-submodules https://github.com/mer-hybris/droid-hal-sony-$FAMILY-$ANDROID_FLAVOUR .
ln -s ../dhd rpm/
mv rpm dhd-rpm
repo init -u git://github.com/mer-hybris/android.git -b $HAVERSION -m tagged-manifest.xml
# Adjust X to bandwidth capabilities
repo sync -jX --fetch-submodules
mv rpm droid-src
ln -s droid-src/patches .
droid-src/apply-patches.sh --mb
mv dhd-rpm rpm
./setup-sources.sh --mb

source build/envsetup.sh
export USE_CCACHE=1
lunch aosp_$DEVICE-user
git clone https://github.com/sailfishos/droidmedia external/droidmedia
make -j$(nproc --all) hybris-hal droidmedia
```

If you encounter errors, check with HADK's section 5.5 "Common Pitfalls".

Once you have hybris-boot.img and hybris-recovery.img files successfully built, go through **chapter 6** of the HADK document.

Ignore **chapter 7**, but do the following instead:
```nosh
PLATFORM_SDK $

cd $ANDROID_ROOT
sudo zypper ref
(cd kernel/sony/msm-4.9/kernel; git add drivers/staging/wlan-qc) # build fail workaround until mb -X is somehow worked into build_packages.sh
rpm/dhd/helpers/build_packages.sh --droid-hal
git clone --recursive https://github.com/mer-hybris/droid-config-sony-$FAMILY-$ANDROID_FLAVOUR hybris/droid-configs -b master
if [ -z "$(grep community_adaptation $ANDROID_ROOT/hybris/droid-configs/rpm/droid-config-$DEVICE.spec)" ]; then
  sed -i '/%include droid-configs-device/i%define community_adaptation 1\n' $ANDROID_ROOT/hybris/droid-configs/rpm/droid-config-$DEVICE.spec
fi
if [ -z "$(grep patterns-sailfish-consumer-generic $ANDROID_ROOT/hybris/droid-configs/patterns/jolla-configuration-$DEVICE.yaml)" ]; then
  sed -i "/Summary: Jolla Configuration $DEVICE/i- patterns-sailfish-consumer-generic\n- pattern:sailfish-porter-tools\n" $ANDROID_ROOT/hybris/droid-configs/patterns/jolla-configuration-$DEVICE.yaml
fi
if [ -z "$(grep jolla-devicelock-daemon-encsfa $ANDROID_ROOT/hybris/droid-configs/patterns/jolla-hw-adaptation-$HABUILD_DEVICE.yaml)" ]; then
  sed -i "s/sailfish-devicelock-fpd/jolla-devicelock-daemon-encsfa/" $ANDROID_ROOT/hybris/droid-configs/patterns/jolla-hw-adaptation-$HABUILD_DEVICE.yaml
fi
rpm/dhd/helpers/build_packages.sh --configs
cd hybris/mw/libhybris
git checkout master
cd -
rpm/dhd/helpers/build_packages.sh --mw=https://github.com/mer-hybris/sailfish-connman-plugin-suspend.git
rpm/dhd/helpers/build_packages.sh --mw # select "all" option when asked
```

Without waiting for the middleware to finish, open new terminal window shell and enter:
```nosh
HABUILD_SDK $

sudo apt-get install rsync
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
# Ensure the middlware in the previous terminal window has finished building
# Change $(nproc --all) to your building capabilities, it will be very heavy on RAM if you go for more cores, proceed with care:
make -j$(nproc --all) systemimage vendorimage
# ^ this might take some time (2 hours on Intel Xeon's 12 cores)

sudo mkdir -p $ANDROID_ROOT-mnt
# ensure your /tmp has ~4GB available
simg2img out/target/product/$HABUILD_DEVICE/system.img /tmp/system.img.raw
sudo mount /tmp/system.img.raw $ANDROID_ROOT-mnt
cd $ANDROID_ROOT/hybris/mw
D=droid-system-$VENDOR-$ANDROID_FLAVOUR-template
git clone --recursive https://github.com/mer-hybris/$D
cd $D
sudo droid-system-device/helpers/copy_system.sh $ANDROID_ROOT-mnt/system rpm/droid-system-$HABUILD_DEVICE.spec
# You can commit the changes, but before you push them out, make sure:
# - to check binary file/repo size limits
# - to rename the public repo as droid-system-sony-$FAMILY-$HABUILD_DEVICE
# - to not contribute binary files to this *-template repo
sudo chown -R $USER .
sudo umount $ANDROID_ROOT-mnt
rm /tmp/system.img.raw
cd $ANDROID_ROOT-syspart
simg2img out/target/product/$HABUILD_DEVICE/vendor.img /tmp/vendor.img.raw
sudo mount /tmp/vendor.img.raw $ANDROID_ROOT-mnt
cd $ANDROID_ROOT/hybris/mw
D=droid-vendor-$VENDOR-$ANDROID_FLAVOUR-template
git clone --recursive https://github.com/mer-hybris/$D
cd $D
sudo droid-system-device/helpers/copy_vendor.sh $ANDROID_ROOT-mnt rpm/droid-system-vendor-$HABUILD_DEVICE.spec
sudo chown -R $USER .
sudo umount $ANDROID_ROOT-mnt
rm /tmp/vendor.img.raw
```

You can now close the HABUILD_SDK (syspart) terminal window. Next, please proceed with:
```nosh
PLATFORM_SDK $

cd $ANDROID_ROOT
rpm/dhd/helpers/build_packages.sh --gg
rpm/dhd/helpers/build_bootimg_packages.sh
sb2 -t $VENDOR-$DEVICE-$PORT_ARCH -m sdk-install -R zypper in --force-resolution droid-hal-$HABUILD_DEVICE-kernel-modules
git clone --recursive https://github.com/mer-hybris/droid-hal-img-boot-sony-$FAMILY-$ANDROID_FLAVOUR hybris/mw/droid-hal-img-boot-sony-$FAMILY-$ANDROID_FLAVOUR
rpm/dhd/helpers/build_packages.sh --mw=https://github.com/mer-hybris/droid-hal-img-boot-sony-$FAMILY-$ANDROID_FLAVOUR --spec=rpm/droid-hal-$HABUILD_DEVICE-img-boot.spec

rpm/dhd/helpers/build_packages.sh --mw=https://github.com/mer-hybris/droid-system-sony-$ANDROID_FLAVOUR-template --spec=rpm/droid-system-$HABUILD_DEVICE.spec --spec=rpm/droid-system-$HABUILD_DEVICE-$DEVICE.spec
rpm/dhd/helpers/build_packages.sh --mw=https://github.com/mer-hybris/droid-vendor-sony-$ANDROID_FLAVOUR-template --spec=rpm/droid-system-vendor-$HABUILD_DEVICE.spec --spec=rpm/droid-system-vendor-$HABUILD_DEVICE-$DEVICE.spec

git clone --recursive https://github.com/mer-hybris/droid-hal-version-sony-$FAMILY hybris/droid-hal-version-$DEVICE
rpm/dhd/helpers/build_packages.sh --version

# The next two variables are explained in chapter 8
RELEASE=3.3.0.16
EXTRA_NAME=-my1
sudo zypper in lvm2 atruncate pigz
sudo zypper in android-tools
cd $ANDROID_ROOT
rpm/dhd/helpers/build_packages.sh --mic
```

If you want to rebuild your image again later, umount any `/var/tmp/mic/imgcreate-*/` mounts manually.

The command above will yield a flashable archive, such as `$ANDROID_ROOT/sfe-i4113-3.3.0.16-my1/Sailfish_OS--my1-3.3.0.16-i4113-0.0.1.1.zip` that you will use to flash your device as explained in the next section.

## Flashing

All the instructions you will find on our website (yet use your own built .zip bundle!): <https://jolla.com/install-sailfish-x-xperia-10-linux/>

Note: in `flash.sh` you will need to replace `@DEVICES@` with your `$DEVICE` value in uppercase, e.g. `I4113`. Naturally, after that you'll need to adjust or remove the line containing `flash.sh` in the `md5.lst` file.

## Adaptation Status

Currently alpha. Feel free to help out in areas that you like:

  - What works: telephony, mobile data, UI, WLAN, GPS, Bluetooth, Camera, internet sharing, operator names in manual network select, (internal) OTA updates,
  - GPS fix holds better than of XA2 (feel free to compare the adaptation implementations)
  - only `version --dup` can be used to update (Update UI doesn't work yet)
  - Community OTA updates will work only when OBS repos and packages are setup (feel free to become a maintainer of those)
  - Sensors work except compass
  - Charging mode doesn't work, phone boots to SFOS UI, so if your battery is really low, it might take one or more reboot cycles to keep charging without shutdown (plug into a strong wall charger)
  - Home partition encryption should now be enabled for community build against 3.1.0, but has not been tested (^ device would then happily continue charging during security code input in the minimal UI boot environment)
  - An issue with side swipes from the middle of the screen (fix coming in 3.2.0)
  - Graphics works but not 100% stable (that has been fixed)
  - Fingerprint works but it's hard to get it to run (might be fixable with a startup/wait script similar to nile which executes `/system/bin/wait_for_keymaster`) - currently no packages added to patterns (see XA2)
  - NFC should work, the packages haven't been added - feel free to take this simple task (look how it's done in XA2)
  - Non-productised things such as battery drain are still possible in such stages of this port (WLAN drain improvements are tangible and currently WIP)

## Feedback

If you find bugs while building an image from this page, please report them in our IRC channel.


Have fun and enjoy the fully-flashable Sailfish OS image built by you!
Your Jolla HW Team
