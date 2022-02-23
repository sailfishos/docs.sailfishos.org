---
title: Sailfish X Xperia Android 6 Build and Flash
permalink: Develop/HW_Adaptation/Sailfish_X_Xperia_Android_6_Build_and_Flash/
parent: HW Adaptation
layout: default
nav_order: 200
---

# Sailfish OS Hardware Adaptation Development Kit for Sony Xperia X

Here you will find instructions how to build Sailfish OS image and flash it to Sony Xperia X (F5121) device.

## ChangeLog

  - 2020-06-16: Align with the latest build scripts
  - 2019-03-15: Revised in the wake of HADK 3.0.1
  - 2018-12-13: Revised in the wake of HADK and Platform SDK 3.0.0
  - 2018-06-25: Aligned with Platform SDK 2.2.0 and target
  - 2017-11-02: droid-flashing-tools has now been provided in nemo:devel:hw:common repo (which is automaticaly available for local builds), which should unbreak mic image creation
  - 2017-10-11: EDGE variable added for cutting and bleeding flavours of the HW adaptation (removed in Jun '18 due to adaptation now being stable)
  - 2017-10-10: Switching to blobless builds, you no longer have to download SW binaries to build things, will only need them to flash the image **(we recommend to start your dev environment from scratch at this point)**
  - 2017-10-07: Each `repo init` below now points to the `tagged-manifest.xml`, which means a complete re-init, re-sync, and rebuild is required to fix the recent mobile data issue.
  - 2017-09-29: Bluetooth is now enabled, you are welcome to test its profiles and fix up as many as you can (ping `jusa` in IRC for guidance).
    Browser video playback fixed.
    Camera video recording fixed.
    General performance boosted by enabling all 6 CPU cores.
  - 2017-09-26: droid-configs has been updated to fix the `nothing provides requested droid-hal-version-f5121` error

## Building

Please download the latest Sailfish OS HADK (Hardware Adaptation Development Kit) from within [this link](https://sailfishos.org/hadk).

Minimum Sailfish OS version for this port is 4.3.0.15.

If you are new to HADK, please carefully read the disclaimer on page 1, then **chapters 1 and 2**.

The disk space requirement for this build is not 30GB as HADK says, but around 80GB. The download bandwidth requirement is around 20GB.

HADK uses CyanogenMod as reference base. Here we'll instead have Sony's stock Android 6.0.1 or 7.x – these are the versions that are supported by Sailfish X and need to be flashed to your Sony before flashing Sailfish OS image. Now you can read through **chapter 3**.

If you ever run into difficulties, we're there to help in the [#sailfishos-porters](https://webchat.oftc.net/?channels=#sailfishos-porters) channel on IRC at oftc.net.

In **chapter 4** (*Setting up the SDKs*) setup the environment in ~/.hadk.env with additional variables (here we'll build for Sony Xperia X single SIM variant):
```nosh
export VENDOR=sony
export DEVICE=f5121
export HABUILD_DEVICE=suzu
export DEVICE_GROUP=f512x
export BRANCH=6.0.1_r80
export HAVERSION="sony-aosp-"$BRANCH"-20170902"
```

Follow through the **chapter 4** until the end, and **ignore chapter 5**, instead perform the following:
```nosh
HABUILD_SDK $

git config --global user.name "Your Name"
git config --global user.email "you@example.com"
```

You'll need to ensure you have the `repo` command from the AOSP source code repositories installed. See the [Android Source instructions](https://source.android.com/setup/develop#installing-repo) for how to install it. Once available you can continue:
```nosh
HABUILD_SDK $

sudo mkdir -p $ANDROID_ROOT
sudo chown -R $USER $ANDROID_ROOT
cd $ANDROID_ROOT
repo init -u git://github.com/mer-hybris/android.git -b hybris-$HAVERSION -m tagged-manifest.xml
# Adjust X to your bandwidth capabilities
repo sync -jX --fetch-submodules
source build/envsetup.sh
export USE_CCACHE=1
lunch aosp_$DEVICE-userdebug
git clone https://github.com/sailfishos/droidmedia external/droidmedia
make -j$(nproc --all) hybris-hal droidmedia
```

If you encounter errors, check with HADK's section 5.5 "Common Pitfalls", and if it's not there, ask us on IRC.

Once you have hybris-boot.img and hybris-recovery.img files successfully built, go through **chapter 6** of the HADK document.

Ignore **chapter 7**, but do the following instead:
```nosh
PLATFORM_SDK $

cd $ANDROID_ROOT
rpm/dhd/helpers/build_packages.sh --droid-hal
git clone --recursive https://github.com/mer-hybris/droid-config-$DEVICE hybris/droid-configs -b master
if [ -z "$(grep community_adaptation $ANDROID_ROOT/hybris/droid-configs/rpm/droid-config-$DEVICE.spec)" ]; then
  sed -i '/%include droid-configs-device/i%define community_adaptation 1\n' $ANDROID_ROOT/hybris/droid-configs/rpm/droid-config-$DEVICE.spec
fi
if [ -z "$(grep patterns-sailfish-consumer-generic $ANDROID_ROOT/hybris/droid-configs/patterns/jolla-configuration-$DEVICE.yaml)" ]; then
  sed -i "/Summary: Jolla Configuration $DEVICE/i- patterns-sailfish-consumer-generic\n- pattern:sailfish-porter-tools\n" $ANDROID_ROOT/hybris/droid-configs/patterns/jolla-configuration-$DEVICE.yaml
fi
if [ -z "$(grep jolla-devicelock-daemon-encsfa $ANDROID_ROOT/hybris/droid-configs/patterns/jolla-hw-adaptation-$DEVICE_GROUP.yaml)" ]; then
  sed -i "s/sailfish-devicelock-fpd/jolla-devicelock-daemon-encsfa/" $ANDROID_ROOT/hybris/droid-configs/patterns/jolla-hw-adaptation-$DEVICE_GROUP.yaml
fi
rpm/dhd/helpers/build_packages.sh --configs
rpm/dhd/helpers/build_packages.sh --mw # select "all" option when asked
```

Wait for middleware to finish, open new terminal window shell and enter:
```nosh
HABUILD_SDK $

sudo apt-get install rsync
cd $ANDROID_ROOT/..
mkdir syspart
cd syspart
repo init -u git://github.com/mer-hybris/android.git -b syspart-$HAVERSION -m tagged-manifest.xml
# Adjust X to your bandwidth capabilities
repo sync -jX --fetch-submodules
source build/envsetup.sh
export USE_CCACHE=1
lunch aosp_$DEVICE-userdebug
# Change $(nproc --all) to your building capabilities, it will be very heavy on RAM if you go for more cores, proceed with care:
make -j$(nproc --all)  libnfc-nci bluetooth.default_32 systemtarball
# The build might take quite a bit of time

PLATFORM_SDK $

cd $ANDROID_ROOT/../syspart
git clone https://github.com/mer-hybris/droid-system-$DEVICE
mb2 -t $VENDOR-$DEVICE-$PORT_ARCH -s droid-system-$DEVICE/rpm/droid-system-$DEVICE.spec build
rm -f $ANDROID_ROOT/droid-local-repo/$DEVICE/droid-system-*.rpm
mv RPMS/droid-system-*-0.1.1-1.armv7hl.rpm $ANDROID_ROOT/droid-local-repo/$DEVICE/
createrepo_c "$ANDROID_ROOT/droid-local-repo/$DEVICE"
sb2 -t $VENDOR-$DEVICE-$PORT_ARCH -m sdk-install -R zypper ref
```

Close the current terminal window, go back to previous window, then:
```nosh
PLATFORM_SDK $

cd $ANDROID_ROOT
rpm/dhd/helpers/build_packages.sh --gg

sb2 -t $VENDOR-$DEVICE-$PORT_ARCH -m sdk-install -R zypper in --force-resolution droid-hal-$DEVICE-kernel-modules
rpm/dhd/helpers/build_packages.sh --mw=https://github.com/mer-hybris/droid-hal-img-boot-$DEVICE

rpm/dhd/helpers/build_packages.sh --mw=https://github.com/mer-hybris/bluetooth-rfkill-event --spec=rpm/bluetooth-rfkill-event-hciattach.spec

git clone --recursive https://github.com/mer-hybris/droid-hal-version-$DEVICE hybris/droid-hal-version-$DEVICE
rpm/dhd/helpers/build_packages.sh --version
```

Next, please proceed with:
```nosh
PLATFORM_SDK $

export RELEASE=4.3.0.15
export EXTRA_NAME=-my1
sudo zypper in lvm2 atruncate pigz
sudo zypper in android-tools
cd $ANDROID_ROOT
rpm/dhd/helpers/build_packages.sh --mic
```

If you want to rebuild your image again later, umount any `/var/tmp/mic/imgcreate-*/` mounts manually.

## Flashing

Ensure you OTA your stock Sony Android to at least 34.3.A.0.228 (check Settings | About phone | Build number) before unlocking your device, so you do not need Windows in the flashing process. Note, you might need to OTA-update several times to reach that version.
```nosh
PLATFORM_SDK $   # continue from above mic session

mkdir flashing
cd flashing
unzip $ANDROID_ROOT/sfe-$DEVICE-$RELEASE$EXTRA_NAME/SailfishOS-*.zip
cd SailfishOS-*/
```

Download Sony vendor zip archive from <https://developer.sonymobile.com/downloads/software-binaries/software-binaries-for-aosp-marshmallow-android-6-0-1-kernel-3-10-loire/> and place it in current directory, then:
```nosh
BLOBS=$(ls -1 *_loire.zip | tail -n1)
unzip $BLOBS
# act upon instructions in the flashing-README.txt, then:
bash ./flash.sh
```

### If flash.sh fails with "You have too old Sony Android version (X.Y) on your device"

This means you have not updated your stock Sony Android via OTA to the build 34.3.A.0.228. Since you have already unlocked your device, OTAs are no longer available, and now you have two alternatives: the Linux way or Windows.

#### The Linux Way
```nosh
cd $ANDROID_ROOT/flashing/SailfishOS-*/
MATCH='Your Sony Android version ($VMAJOR.$VMINOR) on your device is too old,'
LINE=$(grep -n "$MATCH" flash.sh | sed 's/:.*//')
if [ -n $LINE ]; then
  sed -i "$(($LINE+1)),$(($LINE+3)) d" flash.sh
  sed -i "s/$MATCH/Your Sony Android version is too old, but we'll workaround that via Linux cmdline/" flash.sh
else
  echo 'Ensure you are using droid-configs from the build instructions above (same branch/up-to-date), then:'
  echo 'cp $ANDROID_ROOT/hybris/droid-configs/sparse/boot/flash.sh .'
  echo 'And restart this section from its beginning above ^ (cd $ANDROID_ROOT/flashing etc)'
fi
sed -i 's/echo "Flashing oem partition.."/echo "oem partition is populated manually through recovery"/' flash.sh
sed -i 's/$FLASHCMD oem $BLOBS/#$FLASHCMD oem $BLOBS/' flash.sh
fastboot flash system *_loire.img
```

Open a new terminal window and enter [Sailfish_X_Build_and_Flash#Recovery_Mode](/Develop/HW_Adaptation/Sailfish_X_Xperia_Android_6_Build_and_Flash#recovery-mode) and shell into the device, then:
```nosh
mkdir oem
mount /dev/mmcblk0p28 oem
mkdir blobs
mount /dev/mmcblk0p52 system
rm -rf oem/*
cp -ar blobs/* oem
umount oem
umount blobs
rmdir oem blobs
exit
```

Go back to your previous terminal window session, and complete the flashing:
```nosh
bash ./flash.sh
```

Now reboot the device and you should have Sailfish OS booting normally.

#### Windows

  - Download the Emma tool - <https://developer.sonymobile.com/open-devices/flash-tool/how-to-download-and-install-the-flash-tool/>
  - Install the Emma tool
  - Connect phone to your computer with USB cable, while holding volume down and then green LED light should be lit on the top speaker
  - Update your device to at least to Android version x-x_34.3.x.x.x with the Emma tool.
    NOTE: The download size can be 2.5G and take tens of minutes to download so go and get some coffee in the mean while

Go back to your Linux installation where you left off previously, and redo:
```nosh
# act upon instructions in the flashing-README.txt, then:
bash ./flash.sh
```

## Recovery Mode

If anything goes not according to plan, you can boot the device into fastboot (VolumeUp+Power) and execute this command:
```nosh
PLATFORM_SDK $

# cd into your flashing/ directory
sudo fastboot boot SailfishOS-*/hybris-recovery.img
```

Then follow instructions on screen to SSH into your device recovery mode. Further steps will depend on what you want to achieve, mainly guided by our IRC channel.

## Adaptation Status

The port is pretty functional, but help from you is always appreciated in these areas:

  - Sensors not working: fingerprint, barometer, step counter
  - Double-tap to wake is deactivated. Activate it and help testing in various scenarios by:
```nosh
mcetool --set-doubletap-wakeup=proximity
```

  - FM radio missing (solution is known by community)
  - No big.LITTLE technology is currently enabled, Sailfish OS simply fills up the cores in sequence (from 0 to 3 little, then the big ones 4 and 5), which already gives a very smooth performance.
    However, this means there's no special allocation of the two performance cores for the foreground apps (so the UX experience could be improved even further, even under heavy loads). More details:
    We can't dedicate two big cores to foreground UI apps because we can't allocate PIDs to the foreground sets. And even if we could, we'd have to add the root process for foreground apps (SFOS booster/invoker?) into there so its children would live on the fast cores. Ping abranson on IRC if you want to chip in, or wait for Android 7 (and kernel v4.4 automatically handling all that much better) where only SFOS booster part will need sorting.
  - Startup Wizard skips one blank page (where usually the Android Support is)

If you find more things to fix, please report them in our IRC channel or file a [bug](https://bugs.merproject.org/enter_bug.cgi?product=Mer%20Hybris&Bugzilla_restrictlogin=on&GoAheadAndLogIn=Log%20in&component=Sony%20Xperia%20X).


Have fun and enjoy our first fully-flashable Sailfish OS image built entirely by you!
Your Jolla HW Team
