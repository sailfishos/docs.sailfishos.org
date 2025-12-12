---
title: Application Configuration
permalink: Reference/I18n/Application_Configuration/
parent: I18n
layout: default
nav_order: 300
---

This page explains how to configure your application for internationalisation on Sailfish OS. These details are also covered in the [Libsailfishapp](https://sailfishos.org/develop/docs/libsailfishapp/#using-i18n-support-in-your-project) documentation.

As an application developer you have more freedom for how you format and make use of the Qt internationalisation capabilities compared to Platform development. Nevertheless, in the longer term you may find it convenient to follow the [I18n Conventions](/Reference/I18n/I18n_Conventions) for your app.

You may also find it useful to reference the Qt documentation on [Qt Quick internationalisation](https://doc.qt.io/archives/qt-5.6/qtquick-internationalization.html) and [Qt Linguist](https://doc.qt.io/archives/qt-5.6/linguist-programmers.html).

In the examples below we assume your app is called **harbour-myapp**; you'll need to adjust the statements to use the correct name for your app.

## The project .yaml and .spec files

If you use either the Sailfish IDE, or `sfdk init` to create a new application, the translation functionality will be configured automatically. This is the same whether you're developing a QtQuick2 or a QML-only app. For most app development, there should therefore be no need to make changes to the `.yaml` or `.spec` files to support translations.

Nevertheless we briefly explain which parts of the file are relevant, in case a more elaborate configuration is needed.

The default `sailfishapp` dependency added to the `.yaml` file, which will be used to generate the `.spec` file for your project, should be sufficient to handle the translations for your app:

```
PkgConfigBR:
  - sailfishapp >= 1.0.2
```

The generated ".qm" translation files (Engineering English and any other languages you add) are by default installed with the normal package under the `/usr/share/harbour-myapp/translations` directory, and will be automatically picked up by the application when it runs.

The following snippet, automatically added to the `.yaml` file, is used for this:

```
Files:
  - '%{_datadir}/%{name}'
```

This section of `.yaml` is converted into the following snippet in the `.spec` file:

```
%files
%{_datadir}/%{name}
```

## The project pro file

The automatically generated qmake pro file will also be set up to support translations. However, there are reasons why you might want to make changes to this file, for example when adding support for additional languages.

The most important lines related to translation can be found at the end of the generated pro file.

```qmake
# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
TRANSLATIONS += translations/harbour-myapp-de.ts
```

The comments included in the file should be self-explanatory, but we will also cover them here for completeness.

This default configuration assumes you will be using non-ID-based translations. For ID-based translations, you should update the `CONFIG` line to the following:
```
CONFIG += sailfishapp_i18n \
          sailfishapp_i18n_idbased
```

To support additional languages, add them to the `TRANSLATIONS` list.

```
TRANSLATIONS += translations/harbour-myapp-de.ts \
                translations/harbour-myapp-en.ts \
                translations/harbour-myapp-zh_CN.ts
```

After making changes to the pro file, you'll need to run `qmake` in order for the changes to be picked up, before performing another build.

## Disabling translation generation

Simply comment out the `CONFIG` lines described in the previous section in order to disable translation generation. This may be useful to speed up the build process during development.


