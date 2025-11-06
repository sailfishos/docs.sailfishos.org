---
title: Develop
permalink: Develop/
nav_exclude: true
layout: default
---

# Get things done

If you're keen to develop for Sailfish OS then this is the right place to start.

Take a moment to look at the contents of this page and you'll see that we'll cover a number of topics : development areas/roles; working with others; open source; key Sailfish OS technologies and right at the bottom there are some guides on common developer tasks.

## Development areas or roles in Sailfish OS

Although there can be some overlap it is helpful to break Sailfish OS development into a number of different areas and/or roles.

### Application developer

Applications extend Sailfish OS functionality and usually provide a user with a new interface to use with their device; they range from small and simple standalone apps to sophisticated suites with complex interactions both with Sailfish OS and the rest of the world. Sailfish OS provides the Silica components (which are built using Qt's QML) to allow developers to integrate the native look and feel into their applications

If you're doing this type of development then you're typically using the Sailfish SDK as your primary code development tool (although you are free to use your own tools in conjunction with those found in the platform developer's toolbox).

The code you are working on may or may not be open source - but you'll certainly be interacting with open source code, tools and/or projects.

The application developer section will cover:

  - Getting started
  - Software Development Kit
  - Sailfish OS Tutorials
  - API Documentation
  - Harbour

Read more about [Application Development](/Develop/Apps).

### User Interface designer

Providing an attractive and usable interface for an application is a challenge.

The User Interface section covers:

  - Logic, consistency and intuitive movement
  - Design Principles
  - UX Framework
  - Gestures
  - Navigation architecture
  - App icons
  - QML

Read more about [User Interface Development](/Develop/Apps/UI).

### Platform developer

If you are developing Sailfish OS itself then this is called platform development. This type of work is much more collaborative and you'll be working on the Sailfish OS code with others in the open source community.

Development in this area is usually standard Linux command line development.

Whilst application development can be relatively relaxed about code changes, platform development has the potential to impact a very large number of users and other developers. This means that the processes for accepting changes into the platform are quite stringent.

Read more about [Platform Development](/Develop/Platform).

### HA developer

Hardware Adaptations are where Sailfish OS meets the low level hardware; development on the kernel, configuration, drivers and similar.

The HA porting process is well documented in the HADK, the Hardware Adaptation Development Kit. Once you begin the porting process you'll almost certainly want to discuss problems with the community on the irc channel. Eventually, when you have a succesful port you may want to release this to the community - or to your build/release engineers.

Read more about [Hardware Adaptation Development](/Tools/Hardware_Adaptation_Development_Kit).

### Build / Release engineer

If you've been tasked with pulling together the work from all the various development branches and delivering working system images then you're a Sailfish OS build/release engineer.

This is a complex area and will cover:

  - OBS projects
  - Promotion, testing
  - Bug/Feature management

### QA engineer

Quality matters and testing is a key part of ensuring that all the components in a Sailfish OS device work together.

As well as running through various test cases you'll need to be familiar with:

  - Flashing
  - Upgrading
  - Running tests
  - Bug reproduction
  - Test tools
  - Bug reporting

## Collaborative development process

Sailfish OS is mainly open source and almost all development on the platform itself happens in the open on public systems.

These approaches work well deployed in a commercial environment too - and many of the systems used in Sailfish OS development are managed and developed as open source projects in their own right.

The community is welcoming and supportive but it's polite to get to know a little about how things are done to avoid wasting other people's time. This section will cover those essentials:

  - Feature / Bug handling using Sailfish Forum
  - Code Submission and Review using GitHub
  - Tagging/Releasing in git
  - Building in OBS
  - Promotion in OBS
  - QA images in IMG

Read more about the [Collaborative Development](/Develop/Collaborate) process.

## Open Source

The majority of Sailfish OS is built using source code which is available under an open source license.

You'll need to know a little about the licenses and what you can and can't do with open source code. It helps to understand how 'upstream' projects work and their relationship to Sailfish OS.

Read more about the [Open Source](/Develop/Open_Source).

## Key Sailfish OS technologies

Sailfish OS uses a large number of different technologies - indeed a glance at the [Sailfish OS Reference](/Reference) area shows a long list of architectural areas, middleware, APIS, systems and tools.

We'll just look at the system and tool technologies most commonly used in a typical developer's day.

  - Qt
    [Qt](http://qt-project.org/) is a powerful cross-platform application library which is ideal for connected devices. In the Sailfish OS system it serves as the main graphical UI and provides consistent APIs into most other commonly used device functions.
  - Qt Creator
    The Qt project provides a sophisticated IDE which has been enhanced to work with Sailfish OS - you can read more about the standard Qt Creator on the [Qt Developer site](https://doc.qt.io/archives/qt-5.6/topics-app-development.html) and then find out about the Sailfish OS extensions.
  - Scratchbox 2
    Scratchbox 2 solves the problem of cross-compilation by creating a virtual development environment that looks like a target system while allowing execution of both target-compatible and host-compatible binaries transparently. Scratchbox 2 is used both by the Sailfish SDK and the OBS.
  - git
    Sailfish OS uses git extensively for managing change. More about code hosting at [Sailfish OS Source](/Services/Development/Sailfish_OS_Source)
  - OBS
    The Open Build System is used to perform automated clean builds of Sailfish OS packages hosted on the git services.
  - IMG
    The IMG system generates Sailfish OS images using the packages created by the OBS
  - Bugzilla
    Sailfish OS uses Bugzilla to track issues and features, internally; the public issue tracking is handled at <https://forum.sailfishos.org/>

Read more about [Sailfish OS Technologies](/Reference).

## Tasks

There are a number of common tasks that most developers need to do:

  - Fix a bug in a core component
  - Create a package
  - Create an image
  - Flash a device
  - Diagnostics

Read more about [Common Development Tasks](/Develop/Common_Tasks).
