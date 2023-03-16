---
title: Providers and Services
permalink: Reference/Core_Areas_and_APIs/Apps_and_MW/Accounts_and_SSO/Providers_and_Services
parent: Accounts and SSO
grand_parent: Apps and MW
layout: default
---

## Providers and Services

Each account in the Accounts&SSO framework is tied to a provider. The provider allows the user to use the account with a number of services. Each account provider can provide various types of services, and each service type can be provided by various providers.

We have [Sailfish Accounts](https://sailfishos.org/develop/docs/sailfish-accounts/) QML API for accessing account data.

A plugin which adds account providers and/or services to the system describes them using description files, which are defined below.

### Provider description files

Each provider must have it's own provider description file. As of Sailfish OS 4.5.0 the location of these files is `/usr/share/accounts/providers` but you can check the location by running the command `pkg-config --variable=providerfilesdir libaccounts-glib` on a [build-shell](/Tools/Platform_SDK/Build_Shell/).

The provider file syntax is specified in a document type definition [accounts-provider.dtd](https://github.com/sailfishos-mirror/libaccounts-glib/blob/master/data/accounts-provider.dtd).

The `provider` tag in the beginning of the provider file has the id of the provider as an optional argument. This id is used for differentiating providers, and it's accessible via property [name](https://sailfishos.org/develop/docs/sailfish-accounts/qml-sailfishaccounts-provider.html/#name-prop) of the [Provider](https://sailfishos.org/develop/docs/sailfish-accounts/qml-sailfishaccounts-provider.html/) type of [Sailfish Accounts](https://sailfishos.org/develop/docs/sailfish-accounts/) QML module . If the id argument is missing, the name of the file without the `.provider` suffix will be used as id. If the id argument is used, it must be the same as the name of the file without the `.provider` suffix.

The description file elements and their usage in Sailfish OS are described in the table below:

| Element     | Description                                               |
| ----------- | --------------------------------------------------------- |
| name        | The name of the provider, as it is displayed to the user. Accessible as property [displayName](https://sailfishos.org/develop/docs/sailfish-accounts/qml-sailfishaccounts-provider.html/#displayName-prop). |
| description | Description for the provider. Accessible via `providerDescription` role of [ProviderModel](https://sailfishos.org/develop/docs/sailfish-accounts/qml-sailfishaccounts-providermodel.html/). |
| icon        | Icon used to represent the provider in the UI. It should be URL which points to an image. Accessible as property [iconName](https://sailfishos.org/develop/docs/sailfish-accounts/qml-sailfishaccounts-provider.html/#iconName-prop) |
| tags        | List of tags for the provider. Tags beginning with `user-group:` are used for access control: Only users in the specified group are allowed to create accounts for the provider. |
| template    | Default configuration values for accounts. These values are used as default for configuration values which don't have defaults specified in the service file. |

### Service description files

Each service that the provider provides is described in a service description file. As of Sailfish OS 4.5.0 the location of these files is `/usr/share/accounts/services` but you can check the location by running the command `pkg-config --variable=servicefilesdir libaccounts-glib` on a [build-shell](/Tools/Platform_SDK/Build_Shell/).

The service file syntax is specified in [accounts-service.dtd](https://github.com/sailfishos-mirror/libaccounts-glib/blob/master/data/accounts-service.dtd).

The `service` tag in the beginning of the service file has the id of the service as an optional argument. This id is used for differentiating services, and it's accessible via property [name](https://sailfishos.org/develop/docs/sailfish-accounts/qml-sailfishaccounts-service.html/#name-prop) of the [Service](https://sailfishos.org/develop/docs/sailfish-accounts/qml-sailfishaccounts-service.html/) type of [Sailfish Accounts](https://sailfishos.org/develop/docs/sailfish-accounts/) QML module . If the id argument is missing, the name of the file without the `.service` suffix will be used as id. If the id argument is used, it must be the same as the name of the file without the `.service` suffix.

The description file elements and their usage in Sailfish OS are described in the table below:

| Element     | Description                                               |
| ----------- | --------------------------------------------------------- |
| type        | The [type](#service-types) of the service                 |
| name        | The name of the service, as it is displayed to the user. Accessible as property [displayName](https://sailfishos.org/develop/docs/sailfish-accounts/qml-sailfishaccounts-service.html/#displayName-prop). note: The settings application does not use these names but it has it's own logic to determine the names. The name field defined here is used only as a fallback. |
| icon        | Icon used to represent the service in the UI. It should be URL which points to an image. Accessible as property [iconName](https://sailfishos.org/develop/docs/sailfish-accounts/qml-sailfishaccounts-service.html/#iconName-prop) |
| provider    | The [provider](#providers) which supports this service    |
| template    | Default configuration values for accounts.                |

### Service type description files

Each service type is described in a service type description file. As of Sailfish OS 4.5.0 the location of these files is `/usr/share/accounts/service_type` but you can check the location by running the command `pkg-config --variable=servicetypefilesdir libaccounts-glib` on a [build-shell](/Tools/Platform_SDK/Build_Shell/).

The service type file syntax is specified in [accounts-service.dtd](https://github.com/sailfishos-mirror/libaccounts-glib/blob/master/data/accounts-service-type.dtd).

The `service-type` tag in the beginning of the service type file has the id of the service type as an optional argument. This id is used for differentiating service types, and it's accessible via property [name](https://sailfishos.org/develop/docs/sailfish-accounts/qml-sailfishaccounts-servicetype.html/#name-prop) of the [ServiceType](https://sailfishos.org/develop/docs/sailfish-accounts/qml-sailfishaccounts-servicetype.html/) type of [Sailfish Accounts](https://sailfishos.org/develop/docs/sailfish-accounts/) QML module . If the id argument is missing, the name of the file without the `.service-type` suffix will be used as id. If the id argument is used, it must be the same as the name of the file without the `.service-type` suffix.

The description file elements and their usage in Sailfish OS are described in the table below:

| Element     | Description                                               |
| ----------- | --------------------------------------------------------- |
| name        | The name of the service type, as it is displayed to the user. Accessible as property [displayName](https://sailfishos.org/develop/docs/sailfish-accounts/qml-sailfishaccounts-servicetype.html/#displayName-prop). |
| icon        | Icon used to represent the service in the UI. It should be URL which points to an image. Accessible as property [iconName](https://sailfishos.org/develop/docs/sailfish-accounts/qml-sailfishaccounts-servicetype.html/#iconName-prop) |
| tags        |  List of tags for the service type. Accessible as property [tags](https://sailfishos.org/develop/docs/sailfish-accounts/qml-sailfishaccounts-servicetype.html/#tags-prop) |

### Predefined service types

The following table lists the service types already known by the system as of Sailfish OS 4.5.0:

| Service type  | Description                                                                   |
| ------------  | -----------                                                                   |
| IM            | A service of this type provides instant messaging capabilities                |
| caldav        | A service of this type allows syncing of calendar data                        |
| carddav       | A service of this type allows syncing of contact data                         |
| developermode | A service of this type allows developer mode to be enabled                    |
| e-mail        | A service of this type allows sending and receiving emails                    |
| microblogging | A service of this type provides short-form blogging capability                |
| posts         | A service of this type provides feed-like posts                               |
| sharing       | A service of this type allows images, videos, and other content to be shared  |
| storage       | A service of this type allows data to be stored and accessed remotely         |
| store         | A service of this type allows purchasing content or applications from a store |
| sync          | A service of this type allows syncing PIM or other data                       |
