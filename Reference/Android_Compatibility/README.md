---
title: Android Compatibility
permalink: Reference/Android_Compatibility/
layout: default
nav_order: 800
---

## Android Compatibility

When talking about Android compatibility in relation to Sailfish OS, there are two distinct possible meanings. This page gives an overview of the ways in which Sailfish OS provides Android compatibility in relation to those distinct meanings.

### Hardware Support

Sailfish OS is a modern GNU/Linux operating system which uses glibc and utilises libhybris to leverage board support packages provided by OEMs for Android. This allows Sailfish OS to be ported to (almost) any device which currently runs Android. This simplifies device creation and product planning, as device manufacturers can reuse existing device platforms to create Sailfish OS variant devices.

### AppSupport

Separate from this, Sailfish OS can provide support for running Android applications. This support requires the inclusion of an implementation of the Android run-time virtual machine (Dalvik or ART). Sailfish OS defines some specific integration points between the Android run-time and the native Sailfish OS services, to enforce access control and security for system and user data.

#### Data Bridge

Specific subsets of data can be exposed to the Dalvik implementation via the data bridge. The bridge consists of a variety of services which synchronise data between the native databases and the bridge databases. In the future, this will be improved so that the bridge services read from and write to the native databases directly, but that step requires a variety of improvements to the security model of Sailfish OS before it can be implemented in a secure manner.

#### Permissions

Permissions for Android applications are enforced by the Dalvik implementation. Each application can only access the data or functionalities granted to it by the user.
