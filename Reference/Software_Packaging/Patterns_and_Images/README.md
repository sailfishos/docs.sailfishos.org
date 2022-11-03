---
title: Patterns and Images
permalink: Reference/Software_Packaging/Patterns_and_Images
parent: Software Packaging
layout: default
nav_order: 100
---

Sailfish OS uses [mic tool](https://github.com/sailfishos/mic/#readme) for creating OS images. The mic tool utilizes a kickstart file (.ks) for configuring the image creation. There exists a kickstart file for each device.

The packages to be installed on the image are listed in `%packages` section. In order to not have to list all packages in the kickstart files we utilise **patterns**, which are really meta RPM packages i.e. empty packages with dependencies to other packages.

## Device configuration

A device configuration pattern is the main pattern defining the contents of an image. The pattern is called `patterns-sailfish-device-configuration-@DEVICE@`, where @DEVICE@ specifies the device the pattern is for. The patterns is created during the [HW Adaptation](/Develop/HW_Adaptation) process, using a [template](https://github.com/mer-hybris/droid-hal-configs/blob/master/patterns/templates/patterns-sailfish-device-configuration-%40DEVICE%40.inc) as a starting point.

### Common device configuration

For each device there exists common device configuration pattern (patterns-sailfish-device-configuration-common-@DEVICE@). The purpose of this pattern is that it contains packages which are common to most HW configurations. In practise it depends on [Sailfish applications pattern](#sailfish-applications) and [Saifish UI pattern](#sailfish-ui). It also pulls in Sailfish hardware testing tool (CSD). In Sailfish OS 4.0.1 and later it's also possible to use patterns-device-configuration pattern, i.e. without the -@DEVICE@ suffix.

### Device adaptation pattern

The device adaptation pattern (patterns-sailfish-device-adaptation-@DEVICE@) pulls in all the device specific packages, Hybris packages, etc. Generally speaking all packages that are needed in order to use the hardware are pulled in from here.

## Sailfish OS package groups

Various Sailfish OS package groups are pulled in via patterns. The most important patterns are listed below.

### Sailfish Applications

The basic Sailfish Applications are pulled in from Sailfish Applications pattern (patterns-sailfish-applications). 

### Sailfish UI

Sailfish UI (patterns-sailfish-ui) pattern pulls in [Sailfish Core](#sailfish-core), Jolla systemd user session with qt5 and wayland, Jolla homescreen for lipstick, and Jolla actdead charging animation.

### Sailfish Core

Sailfish Core consists of two patterns, patterns-sailfish-core and patterns-sailfish-core-devices. These patterns pull in packages which are required on Sailfish devices, including [middleware](#sailfish-middleware). 

### Sailfish Middleware

Generic Sailfish Middleware is pulled in by patterns-sailfish-mw.

### Device Tools

Sailfish OS Device Tools (patterns-sailfish-device-tools) pattern brings in common debugging tools which are used during early stages of device bring-up.

### RND

Sailfish RND (patterns-sailfish-rnd) pulls in packages which are used for on-device development, testing and debugging.

### Cellular Applications

Sailfish Cellular Applications (patterns-sailfish-cellular-apps) pattern pulls in cellular applications: MMS engine, SimKit, Voicecall UI, etc.

### Store Applications

Sailfish Store Applications (patterns-sailfish-store-applications) pulls in Sailfish Apps which are available through Jolla Store: Calculator, Calendar, Email, Notes, Mediaplayer, Office and Weather.

### Consumer Requirements

Consumer requirements pattern (patterns-sailfish-consumer-generic) pulls in features which are standard in Jolla provided Sailfish OS images for consumer devices. If all features are not wanted, a different pattern can be used instead.

### Customer Content

Sailfish customer content (patterns-sailfish-customer-content-default) pulls in customer content: ambiences, app configs, browser, gallery, profile settings and VPN plugins.

### SDK Target configuration

Sailfish SDK Target configuration (patterns-sailfish-configuration-sdk-target) pulls in all packages needed in a [SDK Target](/Tools/Platform_SDK/Target_Installation/#sailfish-platform-sdk-targets-and-toolings).

### SDK Tooling configuration

Sailfish SDK Tooling configuration (patterns-sailfish-configuration-sdk-tooling) pulls in all packages needed in a [SDK Tooling](/Tools/Platform_SDK/Target_Installation/#sailfish-platform-sdk-targets-and-toolings).

