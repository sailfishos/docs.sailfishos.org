---
title: API Checklist
permalink: Develop/Apps/Harbour/API_Checklist/
parent: Harbour
grand_parent: Apps
layout: default
nav_order: 100
---

# Adding an API to the list of allowed in Harbour

From time to time we get requests for allowing the usage of certain APIs in apps which are approved in Harbour.

Even though we would like to allow as many APIs as possible, we must take some precautions. We should understand that the API forms a contract between an app and the underlying framework. An app expects that the framework will implement the documented functionality, and keep on doing so at least for some time.

In order to ease the process of deciding whether we should add an API to the allowed list, we have put together the following checklist. Generally speaking, if an API fullfills all of the checkpoints, there is no reason for us to not allow it. On the otherhand, each API should be considered individually - there are cases where making exceptions can be justified, i.e. we might add an API even if some of the points are not fullfilled.

## API Checklist

  - API should be considered stable
      - An API can be considered stable, if any of the following is true:
          - API is considered stable by upstream
          - The API hasn't changed for a year
          - We are not planning to upgrade the API to an incompatible version in the near future
      - e.g. we can open official Qt Modules with API compatibility promises

<!-- end list -->

  - API is not considered deprecated

<!-- end list -->

  - API must not expose sensitive user data

<!-- end list -->

  - API needs to be testable
      - Ideally with autotests
      - If we don't have test cases, there has to be at least an app which uses the API which can be used for verification purposes

<!-- end list -->

  - API needs to work for the intended use

<!-- end list -->

  - API is reviewed by sailors (ideally area owner) before publishing

<!-- end list -->

  - API documentation exists and can be published
      - Platform-specific limitations documented (e.g. Sailfish OS lacks support for more advanced QtFeedback haptic features)

<!-- end list -->

  - API is useful for multiple apps
      - It is not a requirement to have such apps included in our images

<!-- end list -->

  - API must already exist in our repositories

<!-- end list -->

  - If we already have C++/QML APIs for a specific purpose, we should not allow e.g. C API for the same purpose
      - Lower level C APIs are typically not allowed

<!-- end list -->

  - Sailfish OS is written with C, C++ and QML, no new language runtimes
