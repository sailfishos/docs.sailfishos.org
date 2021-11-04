---
title: Browser
permalink: Reference/Core_Areas_and_APIs/Browser/
has_children: true
parent: Core Areas and APIs
layout: default
nav_order: 200
---

## Sailfish OS Browser

The web browser in Sailfish OS is a fully open-source component which has been developed in active collaboration with community members. It uses Sailfish Silica UI elements for the browser chrome, and an embedded Gecko engine for content rendering. The source code can be found at <https://github.com/sailfishos/sailfish-browser> and is available under a permissive MPLv2.0 license.

## Debugging

For newer versions of Gecko, the environment variable MOZ_LOG is used to enable logging for various modules. There is no option to turn all logging on, so explicit module names must be found in the source (grep for LazyLogModule).

Useful module names we've used so far include:

  - nsComponentManager - Component loading and unloading
  - GMP - Gecko Media Plugin activity
  - PlatformDecoderModule - system codecs such as ffmpeg
