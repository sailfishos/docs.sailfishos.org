---
title: Apps
permalink: Develop/Apps/
has_children: true
layout: default
nav_order: 100
---

# Getting started

Getting started with the SDK is a fairly simple process:

## Install

[Download the latest SDK](/Tools/Sailfish_SDK) installers and install it. Read more about [SDK Installation](/Tools/Sailfish_SDK/Installation).

## Run

Run the SDK and use it to create an application! The SDK comes with a handy Sailfish OS application template that gives you a quick way to create your very first Sailfish OS application. Just go to File -\> New File or Project in the IDE.

Read more about creating your [First SDK Application](/Develop/Apps/Your_First_App)

## Explore

Learn about the building blocks of the Sailfish user interface with the [documentation](/Develop/Apps#building-blocks) provided by our SDK.

[Join Sailfish Forum](https://forum.sailfishos.org) for updates and support.

## Submit

When your app is ready bring it to the Harbour and we’ll make sure it’s working, compatible with Sailfish OS and help you launch it for Jolla device. After that you can follow the development on your dashboard and make any corrections.

Read more about [Harbour](/Develop/Apps/Harbour)

# Software Development Kit

[Sailfish SDK](/Tools/Sailfish_SDK) is a collection of tools for developing Sailfish OS applications. It includes:

  - Sailfish IDE: A Qt Creator based integrated development environment (IDE)
  - Sailfish OS build engine for cross compilation
  - The Sailfish OS Emulator
  - sfdk command line tool for developing without using Sailfish IDE
  - Tutorial, Design and API Documentation
  - Repositories for additional libraries and open source code

## Sailfish IDE

Sailfish IDE is based on Qt Creator, the cross platform integrated development environment (IDE) tailored to the needs of Qt developers, extended with support for Sailfish UI application development using Sailfish Silica components. It provides a sophisticated code editor with version control, project and build management system integration. More information on Qt Creator in general can be found at qt.io.

## Sailfish OS build engine

The Sailfish OS build engine is a virtual machine (VM) containing the Sailfish OS development toolchains and tools. It also includes a Sailfish OS target for building and running Sailfish and QML applications. The target is mounted as a shared folder to allow Sailfish IDE to access the compilation target. Additionally, your home directory is shared and mounted in the VM, thus giving access to your source code for compilation.

The build engine also supports additional build targets and cross-compilation toolchains. Additional build targets may be installed using the Sailfish SDK Installer/Maintenance Tool. Installed build targets may be then further managed within Sailfish IDE using Options \> Sailfish OS \> Build Engine \> Manage Build Targets.

## Emulator

The emulator is an x86 VM image containing a stripped down version of the target device software. It emulates most of the functions of the target device running Sailfish operating system, such as gestures, task switching and ambience

## sfdk command line tool

sfdk is a command line tool which allows you to build software packages without using the Sailfish IDE. You can find the sfdk executable inside the bin directory of your Sailfish SDK installation. On Windows we recommend using it from MSYS2 shell for the best experience. On macOS a more recent version of `bash` and `bash-completion@2` from Homebrew is recommended.

## Building blocks

A Sailfish OS application takes advantage of the Sailfish OS stack to allow rapid development of beautiful, content-rich applications which work flawlessly on a variety of different formfactors with minimal adjustment. This section describes the layers in the Sailfish OS stack upon which applications are based.

### Qt 5

Sailfish OS apps are based on Qt 5, which enables developers to develop applications with intuitive user interfaces for multiple targets, faster than ever before. Qt 5 makes it easier to address the latest UI paradigm shifts that touch screens and tablets require. More info about Qt can be found from [Qt Project’s website](http://doc.qt.io/qt-5).

### Qt Quick2

Qt Quick 2 is next generation of Qt Quick being a high-level UI technology which allows developers and UI designers to work together to create animated, touch-enabled UIs and lightweight applications. More information is available in the [Qt Quick2 documentation](http://doc.qt.io/qt-5/qtquick-index.html).

### Wayland

In current release of Sailfish OS uses Wayland instead of X11 in graphics pipeline giving improved user experience. Sailfish OS is delivered with a fully functional compositor which takes care of window management and outputting graphics to screen. More information of Wayland can be found from [Wayland homepage](https://wayland.freedesktop.org).

### Sailfish Silica

Sailfish Silica is a QML module which provides Sailfish UI components for applications. Their look and feel fits with the Sailfish visual style and behavior and enables unique Sailfish UI application features, such as pulley menus and application covers. More information is available in [Silica documentation](https://sailfishos.org/develop/docs/silica/).

### Platform APIs

Sailfish OS uses an openly developed and mobile optimized core, for the majority of its own core components. We provide you real time access to the open source code utilized at <https://github.com/sailfishos/>

We are actively working to identify the set of platform APIs that we can officially support with compatibility promises. In the meantime you can experiment by extending the Sailfish OS target in the SDK with development headers you are interested in.

### Open source code

Naturally, we are providing the open source code used in this release. You can find this at releases.sailfishos.org. In the event the source code for a binary was not provided to you along with the binary, you may also receive a copy of the source code on physical media by submitting a written request to us. More information is available in the written offer for source code.

# Sailfish OS Tutorials

In this section, you will find tutorials we have prepared for helping you in the development of Sailfish OS applications. We will add more tutorials here as they become available.

## Combining C++ with QML

QML is the preferred way of developing applications for Sailfish OS. However there are many cases where this is by itself not enough and dropping into native code is necessary. Common reasons include performance, utilizing existing C/C++ libraries and so on. This tutorial describes how to create an application that combines a QML frontend with a C++ backend. ([Read more…](/Develop/Apps/Tutorials/Combining_C++_with_QML))

## Creating an application in Python

In addition to C++, Python is a fully supported language for developing Sailfish OS applications. It is especially suitable for those applications that have modest resource requirements. If your application does heavy duty processing we recommend using C++ instead of Python. In this tutorial we will create a simple Python app for displaying a list of colors. ([Read more…](/Develop/Apps/Tutorials/Creating_an_application_in_Python))

## Building packages - advanced techniques

Sailfish SDK provides a streamlined developer experience through the Sailfish IDE. However, native support is only available for projects that use either qmake or CMake as their build system, which may not be the case when porting existing applications over to Sailfish OS and especially when working on platform components. Such projects may be built manually from command line and with an intermediate step involved it is also possible to open them in the Sailfish IDE, with the usual advanced editing features enabled. Techniques described in this document are also useful to those who prefer using a different code editing environment or want to use Sailfish SDK in the context of a continuous integration system. ([Read more…](/Develop/Apps/Tutorials/Building_packages_-_advanced_techniques))

## QML Live Coding With Qt QmlLive

Creating Qt Quick applications for Sailfish OS can be more effective with the help of Qt QmlLive tool from Qt Automotive Suite. Qt QmlLive supports live coding with two essential features. First it allows to distribute source code modifications, removing the need to redeploy your application to see the effect. Secondly it can instruct yor application which particular QML component should it load instead of the "main" one, so that each component can be worked on independently. ([Read more...](/Develop/Apps/Tutorials/QML_Live_Coding_With_Qt_QmlLive))

# Guidelines

## Coding Conventions

Sailfish applications are written in Qt and QML, and should follow Qt coding conventions. For more information see [coding conventions ](/Develop/Apps/Coding_Conventions) page.

## UI Definition of Done

[UI Definition of Done](/Develop/Apps/UI/Definition_of_Done) is enforced for feature contributions made for the platform, but provides a good checklist for app development also.

## Common Pitfalls

[Common Pitfalls page](https://sailfishos.org/develop/docs/silica/sailfish-application-pitfalls.html/) lists common anti-patterns in Sailfish app development.

# API Documentation

In this section, you will find relevant documentation that you can refer to when developing Sailfish OS applications. We will add more API documentation here as they become available.

## Sailfish Silica

The Sailfish SDK includes Sailfish Silica, a QML module for developing your own Sailfish applications. Sailfish applications are written with a combination of QML and C++ code. QML is a declarative language provided by the Qt framework that makes it easy to create stylish, custom user interfaces with smooth transitions and animations; a QML-based user interfaces can be connected to a C++ based application back-end that implements more complex application functionality or accesses third-party C++ libraries.

Read [Silica API documentation](https://sailfishos.org/develop/docs/silica) for more information on how to develop Sailfish-style applications.

## Sailfish Pickers

The Sailfish Pickers module provides a set of picker components for selecting content when developing your own Sailfish applications.

Read [Sailfish Pickers API documentation](https://sailfishos.org/develop/docs/sailfish-components-pickers/) for more information.

## libsailfishapp

To ease development of applications for Sailfish and to make sure paths for the applications are set correctly, and application startup time is accelerated, third party applications on Sailfish OS should use libsailfishapp. This library provides certain convenience functions to set up the project, install all files into the right directories, and get important paths at runtime via convenience methods.

Read [libsailfishapp documentation](https://sailfishos.org/develop/docs/libsailfishapp) for more information on how to use the library.

## Sailfish Icon Reference

Sailfish icon packages provide hundreds of platform-style vector icons that can be used by Sailfish applications. The platform icons fall into five size categories: generic size variants small, medium and large, and special categories for cover action and notification icons. The icons are automatically scaled to target display dimensions and don't need to be resized by the app.

You can browse the available icons in the latest [Sailfish Icon Reference documentation](https://sailfishos.org/develop/docs/jolla-ambient). Or print A3-size [(outdated) one pager](https://sailfishos.org/content/uploads/2018/11/icon_reference.png) to your wall.

## Configuration Settings API

The Configuration module provides types to access configuration settings stored in DConf from QML. The types provide a property-based API supporting asynchronous reading and writing of configuration values and change notifications, enabling DConf to be used seamlessly within QML property bindings.

See [Configuration API documentation](https://sailfishos.org/develop/docs/nemo-qml-plugin-configuration) for more information.

## DBus API

The Nemo Mobile D-Bus QML Plugin allows you to access services on the system and session bus, as well as provide your own services. D-Bus is used for interprocess communication. Several system services expose an interface over D-Bus that can be used by third party software and other middleware.

See [DBus API documentation](https://sailfishos.org/develop/docs/nemo-qml-plugin-dbus) for more information.

## Notifications API

The QML Plugins Notifications QML Plugin provides C++ class and QML types allowing notifications to be published. A notification will have a specific category, and depending on its category will trigger a variety of graphical (banners, events-view popups, etc) and non-graphical (sounds and vibrations) feedback for the user.

See [Notifications API documentation](https://sailfishos.org/develop/docs/nemo-qml-plugin-notifications) for more information.

## MDM API

Mobile device management is an important requirement for many use cases, allowing the functionality of a particular device or fleet of devices to be restricted or controlled in a variety of ways or in response to certain events (e.g. in the case of a lost or stolen device). Sailfish OS provides the Sailfish OS MDM Framework to allow permitted MDM applications to apply restrictive policies or to manually enable, disable, or trigger specific functionality on the device. The 2nd party API provided by MDM Framework is still in active development and to some extent subject to change.

See [MDM API documentation](https://sailfishos.org/develop/docs/sailfish-mdm/) for more information.

## Sailfish Share API

The Sailfish Share API allows the Sharing UI to be loaded out-of-process, and display the sharing capabilities to allow the user to share files and content via any available sharing method, such as Bluetooth, SMS, email, social media accounts, etc.

See [Sailfish Share API documentation](https://sailfishos.org/develop/docs/declarative-transferengine/) for more information.

## Sailfish WebView API

The Sailfish WebView provides a straightforward and flexible way for you to introduce access to Web pages and websites into your applciation.

See [Sailfish WebView API documentation](https://sailfishos.org/develop/docs/sailfish-components-webview/) for more information.

## Amber Web Authorization Framework

Many applications need to interact with remote services to provide their functionality to the user. One industry-standard mechanism by which the remote service can delegate authorization for specific actions to the application is called OAuth. The Amber Web Authorization Framework provides both C++ and QML API which allows application developers to easily integrate OAuth1.0a and OAuth2 flows into their application, including a simple TCP server which can listen for web-browser redirects.

See [Amber Web Authorization Framework documentation](https://sailfishos.org/develop/docs/amber-web-authorization/) for more information.
