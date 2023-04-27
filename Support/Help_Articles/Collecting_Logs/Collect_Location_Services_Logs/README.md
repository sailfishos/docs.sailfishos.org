---
title: Collect Location Services Logs
permalink: Support/Help_Articles/Collecting_Logs/Collect_Location_Services_Logs/
grand_parent: Help Articles
parent: Collecting Logs
layout: default
nav_order: 950
---

# Collect Location (geoclue) Services (GNSS) Logs

GNSS = Global Navigation Satellite System

Commonly used satellites: GPS, Glonass, Galileo, Beidou.

In order to enable the location services logs follow these steps:
1. Enable the Developer tools as instructed in this [help article](/Support/Help_Articles/Enabling_Developer_Mode/).
2. Open the Terminal app on the phone (or use an SSH connection to the phone). 
3. In order to get the super-user rights give this command:
```
devel-su
```
4. To enable the GNSS logging, Add /var/lib/environment/nemo/qtlogging.conf with the following command:
```
vi /var/lib/environment/nemo/qtlogging.conf
```
After that add this line to the file:
```
QT_LOGGING_RULES="geoclue.provider.*=true"
```
5. Reboot your device (or restart the user session).
6. Open some application which is using location, for example GPSinfo or some Android application.
7. Attach the journal log with these commands:
```
devel-su
journalctl -a -b > journal-geoclue.txt
```
After these steps you have an journal log which includes location related logs. This can be verified by opening the journal log and checking that there are lines with the phrase "geoclue-hybris". This can be easily done with the command:
```
grep geoclue-hybris journal-geoclue.txt
```

8. After logging has been done you can disable the GNSS logging in order to avoid spamming the journal:
```
devel-su
rm /var/lib/environment/nemo/qtlogging.conf
reboot
```
