---
title: Resetting oFono Settings
permalink: Support/Help_Articles/Resetting_oFono_Settings/
parent: Help Articles
layout: default
nav_order: 670
---

It may be that it is not possible to turn mobile data on by tapping the top most item in Settings > Mobile networks. The following tricks may be of help. 

Before that, try using the **[oFono Logger](https://jolla.zendesk.com/hc/en-us/articles/115011240387)** approach.

### Trick 1

1. Swipe to the Events view
2. Tap on "Connect to Internet"
3. Tap on the SIM icon (having the name of your mobile operator under it).
If we are lucky, this would turn the light above mobile data icon on.

### Trick 2

1. Turn Flight Mode ON in Settings. Wait for a couple of minutes.
2. Turn Flight Mode OFF.
3. Try to turn mobile internet ON in Settings > Mobile networks.

### Trick 3

Let's use the developer mode - this **[help article](https://docs.sailfishos.org/Support/Help_Articles/Enabling_Developer_Mode/)** explains how to enable and disable the Developer mode.
Developer mode makes access deeper to Sailfish OS possible by allowing you to get the super-user rights ("root" rights). Also it installs the Terminal app to the device.

1. Enable developer mode (if not enabled)
2. Open Terminal app
3. Give the following commands to reset your SIM-related settings (be sure to type the lines above *exactly* as they are):
```
devel-su
systemctl stop ofono
rm -rf /var/lib/ofono/*
reboot
```
The last command makes your phone restart.
Try enabling the mobile internet now.


