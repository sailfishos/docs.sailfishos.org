---
title: Accounts and SSO
permalink: Reference/Core_Areas_and_APIs/Apps_and_MW/Accounts_and_SSO/
parent: Apps and MW
grand_parent: Core Areas and APIs
layout: default
has_children: true
---

## Accounts And Single Sign On

Sailfish OS allows the user to create an account on the device, sign in on the device, and then have multiple Sailfish OS applications and services able to access the service with that account. Only privileged applications are able to access account information, or use account credentials to sign on to services.

### API

The current API for the Accounts domain in Sailfish OS is the Accounts&SSO API, originally by Nokia and now maintained by Canonical. It consists of native C and C++ APIs, as well as QML bindings, however only the C and C++ APIs are currently available in Sailfish OS. There are plans to migrate away from the Accounts&SSO APIs due to concerns about its implementation and maintainability, however no concrete roadmap for that work has yet been established.

The upstream Accounts&SSO repository can be found at: <https://gitlab.com/groups/accounts-sso>

### Storage Backend

The signond component of the Accounts&SSO project stores account credentials on Sailfish OS. It supports different storage plugins, including encrypted databases, plain-text databases, and secure-storage (hardware-protected) areas. Account credentials are linked to accounts via an identifier which is stored in an account setting. The libaccounts-glib component on the Accounts&SSO project stores account settings in an sqlite database.

### Roadmap

There are plans to move away from Accounts&SSO and instead implement an accounts framework specifically for Sailfish OS. It would consist of a lightweight API layer which uses private DBus connections to talk to a central accounts daemon. That accounts daemon would be responsible for servicing requests made via DBus, enforcing per-application access controls, secure storage, and OAuth2 token management and refreshing.

Currently, no concrete roadmap for this work has yet been defined. Contributions are welcome.

### Account plugins

New account types can be added to the system via plugins. A plugin describes the services it provides using [description files](Providers_and_Services) and provides [Accounts Settings UI integration](Settings_UI).
