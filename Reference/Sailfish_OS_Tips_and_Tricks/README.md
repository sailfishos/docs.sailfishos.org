---
title: Sailfish OS Tips & Tricks
permalink: Reference/Sailfish_OS_Tips_and_Tricks/
layout: default
nav_order: 1000
---

## Experimental configuration keys

This section contains experimental configuration keys which may disappear as Sailfish OS evolves.

### Quick app switching

Similar to pressing Alt + Tab ↹ once on desktop to switch back to the previous app window. One major difference between quick app switching gesture and Alt + Tab ↹ is that you can only jump to the previous app.

#### Enable quick app switching

Ssh to your device and as a user write the following configuration value:

```nosh
dconf write /desktop/sailfish/experimental/quickAppToggleGesture true
```

Once enabled you can switch from the foregound app to the previous app by doing a three centimetres long peek gesture from the foreground app slowly enough (more than 500ms). After threshold values, distance and duration, are exceeded the previous app cover highlights on the switcher and releasing your finger activates the previous app. The gesture can be cancelled by peeking back towards the edge of the device.

#### Disable quick app switching

Ssh to your device and as a user write the following configuration value:

```nosh
dconf write /desktop/sailfish/experimental/quickAppToggleGesture false
```

### Partnerspace

Partnerspace items are placed to the right of the Switcher.

- Value of the key is a string array
- Each partnerspace item is defined as a desktop file path and separated by a comma
- Maximum number of desktop files is three (3)

#### Enable Partnerspace

Ssh to your device and as a user write the following configuration value to add for example Sailfish Weather as a partner item:

```nosh
dconf write /desktop/lipstick-jolla-home/partnerspace/applications "['/usr/share/applications/sailfish-weather.desktop']"
```

#### Disable Partnerspace

Ssh to your device and as a user write the following configuration value:

```
dconf write /desktop/lipstick-jolla-home/partnerspace/applications "@as []"
```

### Easing edge swipe

The ease of performing edge swipes may differ from user to user due to various reasons. For example shape & size of your finger matters, protective cover might affect it, and use of a screen protector may hinder performing the edge swipe.

The edge swipe boundary width is adjusted on a device adaptation basis but due to the above reasons it might not be the best fit for you. Hence, it can be adjusted.

Read the current peek filter boundary width (in pixels) as follows

```nosh
dconf read /desktop/lipstick-jolla-home/peekfilter/boundaryWidth
```

For example for your Sony Xperia 10 II the following value may work better if you have bigger hands (fingers) or if you have a screen protector.

```nosh
dconf write /desktop/lipstick-jolla-home/peekfilter/boundaryWidth 96
```

Reset peek filter values back to defaults as follows

```nosh
dconf reset -f  /desktop/lipstick-jolla-home/peekfilter/
```
