---
title: Gallery Accounts
permalink: Reference/Core_Areas_and_APIs/Apps_and_MW/Accounts_and_SSO/Gallery_Accounts
parent: Accounts and SSO
grand_parent: Apps and MW
layout: default
---

# Gallery Accounts

In order to implement a new type of gallery account, we need three parts: 
1. Gallery Extension Plugin, which implements a media source for the gallery application
2. [Buteo client plugin](/Reference/Core_Areas_and_APIs/Apps_and_MW/Synchronization/#buteo-client-plugin) which implements synchronization. On the Accounts and SSO side, the plugin [provides](../Providers_and_Services#provider-description-files) a [sync service](/Reference/Core_Areas_and_APIs/Apps_and_MW/Accounts_and_SSO/Providers_and_Services#predefined-service-types). The service is called `<provider>-images`, where `<provider>` is the id of the provider.
3. [Settings UI](/Reference/Core_Areas_and_APIs/Apps_and_MW/Accounts_and_SSO/Settings_UI)

In practice it usually does not make sense to download all images from the server during synchronization, but just store the information about available images. The gallery media source can then download and cache the images when the user wants to view the images.

## Gallery Extension Plugin

Gallery extension plugins implement media sources for the gallery application.

The gallery application looks for media sources in `/usr/share/jolla-gallery/mediasources`. Each media source is a QML component, with `MediaSource` as a root element. `MediaSource` is included in the `com.jolla.gallery 1.0` module.

### MediaSource

`MediaSource` has a few properties, which are described below:

| Property | Type   | Description                                                |
| -------- | ----   | -----------                                                |
| icon     | url    | See [MediaSourceIcon](#mediasourceicon)                    |
| page     | url    | See [MediaSourcePage](#mediasourcepage)                    |
| title    | string | Label of the album                                         |
| ready    | bool   | Only those media sources which are ready are visible       |
| model    |        | Top level model for the media source                       |
| count    | int    | Total number of images provided by this media source       |
| busy     | bool   | If true, busy indicator is shown on the gallery start page |

### MediaSourceIcon

The `icon` property of `MediaSource` is a URL, pointing to a component which provides an icon to be displayed on the gallery start page.

`MediaSourceIcon` provides a base class to be used for the icons. It extends `Item` with following properties:

| Property      | Type | Description                                              |
| --------      | ---- | -----------                                              |
| timerInterval | int  | Interval for the timer, in milliseconds                  |
| timerEnabled  | bool | Must be set to true to enable timer                      |
| model         | var  | model of the media source, automatically set when loaded |

`MediaSourceIcon` has one signal, `timerTriggered`, which is emitted when the timer is triggered.

### MediaSourcePage

The `page` property of `MediaSource` is a URL, pointing to a component which provides a gallery page for the media source.

`MediaSourcePage` provides a base class for the pages. It extends `Page` with following properties, which are set automatically when the page is created.

| Property | Type   | Description        |
| -------- | ----   | -----------        |
| title    | string | Media source title |
| model    | var    | Media source model |

## Service configuration

The sync service configuration is done via [Settings UI](/Reference/Core_Areas_and_APIs/Apps_and_MW/Accounts_and_SSO/Settings_UI). The location of image files on the server is configured via settings key `images_path`. If `OnlineSyncAccountCreationAgent` or `OnlineSyncAccountsSettingsAgent` are used, this setting is configured in the advanced settings dialog.

## Sync profiles

The [sync profiles](/Reference/Core_Areas_and_APIs/Apps_and_MW/Synchronization/#sync-profiles) are created by the Account settings UI. If `OnlineSyncAccountCreationAgent` or `OnlineSyncAccountsSettingsAgent` are used, the profiles are created for those services listed in sharedScheduleServices.


