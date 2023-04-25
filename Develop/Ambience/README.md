---
title: Ambience
permalink: Develop/Ambience/
layout: default
nav_order: 700
---

## This article requires verification and updating.

## What is an Ambience?

An Ambience defines the colors and other configuration used on your phone. Silica and all native apps will use the configuration from the Ambience.

The system service `ambienced` will set the Ambience upon boot, or switch to a different Ambience upon request. The license of Ambienced is proprietary.

## Content of an .ambience file

The .ambience file is located under `/usr/share/ambience/ambience-%name/` where %name is the name of the ambience, for example "ambience-my-special-ambience/".
The Ambience file under that directory would be called "ambience-my-special-ambience.ambience".

Parameters in that file can be:

1. displayName: the name of the Ambience. Should correspondent with the file of the directory and with filename "ambience-%name.ambience" (string).
2. wallpaper: full filename of the background image, located in "/images", for example "wallpaper-my-special-ambience.jpg" (string).
3. primaryColor: the primary color of the Ambience, either in 6 or 8 character color strings for rgba, for example "#FFFFFF" (string).
4. secondaryColor: the secondary color of the Ambience, either in 6 or 8 character color strings for rgba, for example "#FFFFFF" (string).
5. highlightColor: the primary color for highlighting of the Ambience, either in 6 or 8 character color strings for rgba, for example "#FFFFFF" (string).
6. secondaryHighlightColor: the secondary color for highlighting of the Ambience, either in 6 or 8 character color strings for rgba, for example "#FFFFFF" (string).
7. ringerVolume: the volume for phone ringing, for example 60 (bool.
8. colorScheme: set it to "lightondark" or "darkonlight" (string).
9. favorite: list it as favorite under Settings > Ambience in the Sailfish Settings app. For example set it to true (bool).
10. highlightBackgroundColor
11. highlightDimmerColor
12. overlayBackgroundColor
13. backgroundGlowColor
16. version: version number of the ambience, for example 3 (integer).
17. translationCatalog

### Ringer tones

There are parameters available for ringer tones, though not all users will aprreciate overwriting their custom set ringer tones.
The audiofiles need to be under the directory `sounds/`.

Parameters in the Ambience file can be:

1. ringerToneFile: { "file": "Ringtone.wav", "enabled": 1 },
2. messageToneFile: { "file": "Message.wav", "enabled": 1 },
3. mailToneFile: { "file": "Email.wav", "enabled": 1 },
4. internetCallToneFile: { "file": "IM.wav", "enabled": 1 },
5. chatToneFile: { "file": "IM.wav", "enabled": 1 },
6. calendarToneFile: { "file": "Calendar.wav", "enabled": 1 },
7. clockAlarmToneFile: { "file": "Clock.wav", "enabled": 1 },


## Creating an Ambience

### Gallery app

In the Gallery app when viewing a single image, there is an option to create an Ambience that will use that image as wallpaper and to create the colors automatically derived from that image.

### Theme Color app

There is an app developed by developer Nephros that can automatically create an Ambience on your phone, based on user configuration.

The app is available at [OpenRepos.net](https://openrepos.net/content/nephros/theme-color)

### Manually made RPM package

On OpenRepos.net and in Chum there are several manually created RPM packages that provide an Ambience.

It is also possible to create your own Ambience RPM package.

### Command-line

Set image as the ambience:

```nosh
dbus-send --session --print-reply --dest=com.jolla.ambienced /com/jolla/ambienced com.jolla.ambienced.setAmbience string:"file://home/<user>/Pictures/imag    e.jpg"
```

## Sailfish Browser

### Using a dark Ambience

In the settings for the Sailfish Browser, you can select if the browser should use a light theme, dark theme or follow the Ambience.
The dark mode will only work if the website supports a dark theme.
It might be possible to create an Ambience that will make the browser follow the theme for dark mode.
