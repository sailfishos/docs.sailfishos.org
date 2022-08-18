---
title: Application Permissions
permalink: Develop/Apps/Application_Permissions/
parent: Apps
layout: default
nav_order: 550
---

## Application Permissions

Every regular Sailfish OS application is run in a [Sailjail](https://github.com/sailfishos/sailjail) sandbox with a user-approved set of application permissions to limit the scope of malicious activity achievable by exploiting a possible vulnerability in the application.

The permission to access the camera, to use internet connection or to display and edit contact data stored on your device are examples of application permissions controlled by Sailjail. Each application should ask what it needs and not more. The necessary permissions need to be expressed in the [Desktop Entry](/Reference/Core_Areas_and_APIs/Apps_and_MW/Lipstick/Launchers) file of your application.

```
[Desktop Entry]
Type=Application
Name=MyApplication
Icon=my-app-icon
Exec=harbour-myapp

[X-Sailjail]
Permissions=Camera;Internet;Pictures
OrganizationName=org.foobar
ApplicationName=MyApp
```

The complete listing of all available application permissions together with more detailed information on configuring the sandbox for your applications can be found in the [sailjail-permissions](https://github.com/sailfishos/sailjail-permissions) repository. It covers topics related to both newly created applications and applications that were created before sandboxing was introduced, in which case an additional effort is needed in order to migrate application data and configuration to the new sandboxed locations.

List of permissions available to applications distributed through [Harbour](/Develop/Apps/Harbour) can be found from the [Harbour FAQ](https://harbour.jolla.com/faq#4.7.0).

Be aware that during development, when an application is run from the Sailfish IDE, from terminal or by similar means, sandboxing is not active and the application runs without restrictions unless the Sailjail wrapper is used to start the application like in the following example.

```
sailjail /usr/bin/harbour-myapp
```

This way it is also possible to pass [debugging options](https://github.com/sailfishos/sailjail/blob/master/APPDEBUG.md) to Sailjail.
