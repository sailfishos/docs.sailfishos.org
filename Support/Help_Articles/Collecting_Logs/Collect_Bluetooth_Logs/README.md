---
title: Collect Bluetooth Logs
permalink: Support/Help_Articles/Collecting_Logs/Collect_Bluetooth_Logs/
grand_parent: Help Articles
parent: Collecting Logs
layout: default
nav_order: 600
---

_This article explains how to collect logs about the air traffic between a Sailfish and another Bluetooth device. The test scripts needed are attached to this article._



# Preparations

## Developer mode

Enable the [**Developer mode**](/Support/Help_Articles/Enabling_Developer_Mode/).

## Scripts to enable effective debugging

Please find two script files attached to this message. Save them to your computer:
* **[upf-start-test.sh](upf-start-test.sh)**
* **[upf-stop-test.sh](upf-stop-test.sh)**

The first script is to restart Bluetooth, Obex and some other processes and start collecting Bluetooth air traffic. The second script stops the logging.

Copy the two script files to your Sailfish device (folder /home/defaultuser).

Make sure that the scripts have the execution rights by issuing the commands below:

```
cd /home/defaultuser
chmod a+x upf*.sh
```

Get the super-user permissions by giving the command "devel-su" at the Terminal. Next, install two code packages to enable the Bluetooth HCI dumps and tracing:

```
devel-su
pkcon refresh
pkcon install bluez5-hcidump
pkcon install bluez5-tracing
systemctl restart bluetooth.service
```

You have completed the preparations.

# Bluetooth logging

## Start logging

Start collecting the logs with the command below. In this example, we use the word **CAR** as the name of this logging session (as if we were monitoring the Bluetooth traffic between a phone and a car).

Choose the name that is appropriate for your case.

The command below must be run with super-user permissions, as 'root'. If needed, use "devel-su" to get the permissions.

The logs will be collected in the folder `/var/log/upf/session-CAR/`:

```
devel-su        # if not 'root' already
./upf-start-test.sh CAR
```

The display will turn black momentarily but the normal UI should return in 10-20 seconds. You will have to open the Terminal app again. Bluetooth logs are now being collected in the background.

## Force the device to the problem situation

You should **run your Bluetooth test scenarios** next. That is, use the Sailfish device with the peripheral Bluetooth device. Do the steps that cause the error situation. If possible, make a note of the time when the problem occurs (the time of the phone) - this will help find the correct point in the log file.

## Stop logging

```
devel-su          # if not 'root' already
./upf-stop-test.sh CAR
```

This script collects the logs from your device and compresses them to file **CAR.tar** on your Sailfish device.

# Send the results

File a ticket at **[Jolla customer care](https://jolla.zendesk.com/hc/en-us/requests/new)**. Attach the log file to it, please: CAR.tar.

# Cleaning up

1) Remove the packages you installed:

```
devel-su             # if not 'root' already
pkcon remove bluez5-hcidump
pkcon remove bluez5-tracing
```

2) Switch off "Developer mode" in "Settings > System > Developer tools".
3) Restart your device to ensure that it really exits the debugging mode.

