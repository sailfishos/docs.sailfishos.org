---
title: I18n Conventions
permalink: Reference/I18n/I18n_Conventions/
parent: I18n
layout: default
nav_order: 200
---

This page explains general conventions which should be followed for internationalisation of Sailfish OS Platform projects, and which also represent helpful guidelines for Sailfish OS applications too.

## Internationalised Text

All human-readable strings in an application or service need to be embedded in such a way that they can be translated. In Sailfish OS applications, the internationalisation capabilities of Qt are leveraged to provide run-time translation of strings. This means that instead of embedding the human-readable string directly in source code, instead the code contains the identifier of a string, and at run-time the appropriate (UTF-8) string (for that identifier, given the current locale) is displayed.

In C++ the `qtTrId()` function should be used. The `lupdate` tool will scan C++ code for uses of this function, and generate the appropriate translation output files for the application or service. The `qtTrId()` function should be used as follows:

```qml
//: This is the context string, which describes to translators in which context the string will be displayed
//% "This is the engineering-english translation, i.e., the string the developer would expect to see in an English localisation"
const QString exampleString = qtTrId("example_internationalised_string_id");
```

In QML the `qsTrId()` function should be used. The semantics are identical to the `qtTrId()` function. An example of its use follows:

```qml
Button {
    //: This text will be displayed in a button, which when clicked will quit the application.
    //% "Quit"
    text: qsTrId("example_application-bt-quit")
    onClicked: Qt.quit()
}
```

Lines starting with `//:` indicate context, provided to the translator to help them in translating. These are always worth adding and are helpful to the translators, but not compulsory.

The following line starting with `//%` indicates the engineering English, a fallback translation if proper translation is missing.
Last creates the actual translation. The ID is formed as `<component>-<placement>-<descriptive text>`.

When developing platform components, `qtTrId()` and `qsTrId()` *must* be used. If you're developing your own application you also have the option to use `tr()` and `qsTr()` instead. The latter offers a simpler approach, while the former offers greater flexibility in some situations.

For details about how to set up your projects for use with translations, and for the differences between platform and application development localisation, see the [Platform](/Reference/I18n/Platform_Configuration) and [Application](/Reference/I18n/Application_Configuration) pages respectively.

## Platform application style requirements

IDs can be reused if it is clear the string has exactly same meaning in the locations used. Keep engineering English included in all occasions. 

Current placement codes are as follows.

| Code | Summary                 | Description
| ---- | ----------------------- | --------------------------------------------------------|
|  ap  |  application name       | Application name, e.g. Media player                     |
|  he  |  header                 | Header in view, e.g. Media player: Music                |
|  bt  |  button                 | Application area buttons                                |
|  no  |  notification           | Notification                                            |
|  bu  |  button                 | Notification area buttons                               |
|  me  |  menu item              | Pull-down or push-up menu item, e.g. Edit contact       |
|  li  |  list item              | Item without data to be displayed, e.g. (unnamed)       |
|  la  |  label                  | Context menu label, e.g. First name                     |
|  va  |  value                  | Context menu value, e.g. In Settings: Language: Finnish |
|  ph  |  textfield placeholders |

In practice the usage has not always been consistent, and should be considered as guidelines.

## Line breaks in translations

It is recommended not to use line breaks in user interface translations as typically translations are 1-2 sentences long and line break can cause text being badly aligned. Exceptions like several paragraphs of text: Use \<\p> or \<br\> for line break.

## Colons

Colons are not carried in translations. If colons are needed, those are added at the code level. Note that for "key: value" type constructs (e.g. combo boxes, informatin labels) colons should generally not be used. The platform style is to instead use colour/emphasis to differentiate the two elements.

See the Combo box page of the Sailfish Silica Component Gallery for good usage of combo boxes without colons.

An example of the case for labels can be seen on the CertificateInfo.qml page (Settings app > System > Certificates > TLS Certificates > Certificate). Here the *key* portion uses `secondaryHighlightColor` while the *value* portion uses `highlightColor`.

## Application names

When creating a `.desktop` file for an application, localised names can be supported as follows:

```
Name=Appname
X-Amber-Translation-Id-Name=appname-ap-name
X-Amber-Translation-Catalog=appname
```

The translation for the ID `appname-ap-name` should be declared in the application code, like this:

```
//% "Appname"
QCoreApplication::setApplicationName(qtTrId("appname-ap-name"));
```

## Other things to localise

Localisation does not stop at having the application translated. Many other details also depend
on the locale, and should be taken into account, such as:

 * date and time formatting, 12/24h
 * number formatting
 * first day of week
 * currency formatting
 * translation can contain plural/singular. Use %n (https://doc.qt.io/qt-5/i18n-source-translation.html#handling-plurals)
 * translation can contain changing values. Use %1, %2 of QString
 * collation (sorting strings)
 * city/country names
 * different calendar systems
 * word and sentence boundaries
 * upper and lower casing strings
 * bidirectional text has quite a few details (not part of first release content)

