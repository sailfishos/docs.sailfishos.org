---
title: Coding Conventions
permalink: Develop/Apps/Coding_Conventions/
parent: Apps
layout: default
nav_order: 300
---

# General

As a rule of thumb follow the coding conventions of the open source project you want to contribute to. Most big projects like GStreamer, oFono and Telepathy have their own coding conventions that should be respected when contributing those frameworks.

# Coding Conventions for Qt-based apps and middleware

When developing features for Sailfish applications, follow Qt C++ (which follows standard C++) and QML coding conventions. Sailfish has traditionally been relatively flexible on coding style issues, leaving the decision on the enforcement of conventions to the individual teams and developers. Coding convention rules stir up a lot of opinions, but at the end are not so important as long as developers write clear, concise, readable, testable and in general high quality code they can be proud of.

## Qt Coding Conventions

  - [Qt Coding Style](http://qt-project.org/wiki/Qt_Coding_Style)
  - [Qt C++ Coding Conventions](http://qt-project.org/wiki/Coding-Conventions)
  - [Qt API Design Principles](http://qt-project.org/wiki/API-Design-Principles)

## QML coding conventions

  - [QML Coding Conventions](http://qt-project.org/doc/qt-5.0/qtquick/qml-codingconventions.html)
  - [QML Best Practices](http://qt-project.org/doc/qt-4.8/qml-best-practices-coding.html)

## Additional Sailfish Qt coding conventions

Sources: Sailfish OS Middleware conventions

### Prefer Qt5 Signal/Slot Connection Syntax

Write
```cpp
QObject::connect(&sender, &Sender::signalName, &receiver, &Receiver::slotName);
```

instead of
```cpp
QObject::connect(&sender, SIGNAL(signalName()), &receiver, SLOT(slotName()));
```

Rationale: ensures that the compiler can detect parameter mismatch issues, and provides a minor performance benefit at runtime.

### Prefer C++11 Ranged-For

Write
```cpp
for (const QString &str : someStringList) { ... }
```

or
```cpp
for (const auto &str : someStringList) { ... }
```

instead of
```cpp
for (int i = 0; i < someStringList.size(); ++i) {
    const QString &str(someStringList[i]);
    ...
}
```

Rationale: in general we should prefer C++11 features where supported by the platform compiler.

### Use CamelCase Namespace Names

As for class names, prefer camel-cased namespace names.

Write
```cpp
namespace AppNamespace { /* ... */ }
```

instead of
```cpp
namespace appnamespace { /* ... */ }
```

Rationale: provides consistency with class naming as specified by the Qt Coding Style.

## Additional Sailfish QML coding conventions

Sources: Qt Quick examples, Qt Components conventions

### Omit ";" behind JavaScript function lines

Write
```qml
x = a + b
```

instead of
```qml
x = a + b;
```

Rationale: less code, basically either style way would be fine, but one was chosen.

### Put spaces between conditional statements, code, and curly braces

Write
```qml
if (a) {
```

instead of
```qml
if(a){
```

or
```qml
if ( a ) {
```

Rationale: criteria is mostly esthetic and thus subject to argumentation. Overall adding spaces improves visual grouping (but only if not overused) and helps legibility.

### Write short one line functions in one line

It is ok to write
```qml
onClicked: if (a) doSomething()
```

instead of
```qml
onClicked: {
    if (a) {
        doSomething()
    }
}
```

Rationale: less lines needed, both forms equally readable.

### Omit redundant property assignments

Write
```qml
property bool propertyName
property int propertyName
```

instead of
```qml
property bool propertyName: false
property int propertyName: 0
```

Rationale: less code, QML developer should already know the default values.

### Don't define id for an element if id is not used

Write
```qml
Image {}
```

instead of
```qml
Image {
    id: background
}
```

if you don't need the id.

Rationale: potentially less code. Like with properties only define something if you really need that something.

### Use braces in one-line conditionals

Write
```qml
if (a) {
    doSomething()
}
```

instead of
```qml
if (a)
    doSomething()
```

Rationale: Agreed with the team. Goes against Qt Coding convention, but is generally considered safer.

### Group properties together when grouped property form is available: font {}, anchors {}, border {}, etc.

Write
```qml
anchors {
    horizontalCenter: parent.horizontalCenter
    horizontalCenterOffset: Theme.paddingSmall
}
```

instead of
```qml
anchors.horizontalCenter: parent.horizontalCenter
anchors.horizontalCenterOffset: Theme.paddingSmall
```

Rationale: less code, grouping communicates relation.

### Avoid unnecessary negatives

It is more readable to state
```qml
if (a) .. else ..
```

than
```qml
if (not a) .. else ..
```

and
```cpp
#ifdef USE_SQL
..
#endif
```

instead of
```cpp
#ifdef NO_SQL
..
#endif
```

Rationale: negatives require more mental load to decipher. Avoids double negatives like `!NO_SOMETHING`.

### Keep similar properties close to each other

There is no one clear rule with this, grouping is often contextual: base element properties versus specialized properties, visual versus non-visual properties.

Rationale: proximity implies relation, code is easier to read the less you need to jump between lines when interested in particular behavior/feature.

Some rough general rules to consider :
```
id declaration
property declarations
signal declarations
property bindings, functions and signal handlers
 - Same type items grouped together, javascript functions and signals handlers close to each other.
 - Attached properties after bindings.
 - The most important details that define the component first.
   For example if an interactive item sets some text label property, the bindings define
   the item more than a javascript expression blob.
child items, visual and non-visual grouped together
states
transitions
```

### Mark private API private

You can't stop developers from reading your code, and if they can't tell public symbols from private symbols their code will end up depending on something that changes in later versions. QML doesn't support for private members, however there are a couple of conventions useful for keeping symbols out of the way. The simplest and usually fastest is to prepend an underscore:
```qml
Item {
    property int iAmPublic
    property int _iAmPrivate

    Text {
        text: "Hello"
    }
}
```

## Testing Conventions

Sailfish app development follows Qt conventions, and autotesting is no different.

  - [Testing Qt C++ classes with Qt Test Framework](http://doc.qt.io/qt-5/qtest-tutorial.html)
  - [Testing Qt QML elements with Qt Quick Test Framework](http://doc.qt.io/qt-5/qttest-qmlmodule.html)

There are couple of common anti-patterns highlighted below that you should avoid.

### Prefer compare() over verify() when possible

Write
```qml
compare(value, 10)
```

instead of
```qml
verify(value == 10)
```

Rationale: Compare produces more descriptive error messages and does more type checking.

### Use SignalSpy instead of wait()

Write
```qml
SignalSpy { id: valueSpy; target: object; signalName: "onValueChanged" }
function test_case() {
    signalSpy.clear()
    signalSpy.wait()
    compare(object.value, newValue)
}
```

instead of
```qml
function test_case() {
    wait(100)
    compare(object.value, newValue)
}
```

Rationale: Too short arbitrary wait times may fail, at worst cases irregularly. Too long wait times unnecessarily postpone the completion of the autotest.

# Sailfish Project and deployment conventions

## Application project hierarchy

Project hierarchy of the Sailfish OS system applications.

| Path                                        | Explanation                                                                                                                                |
| ------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------ |
| **sailfish-appname**                        | Use dashes "-" where the space would normally go                                                                                           |
| **sailfish-appname/sailfish-appname.pro**   | Match the pro file name with the folder name                                                                                               |
| **sailfish-appname/appname.cpp**            | C++ application stub that loads the top-level QML document, not named as main.cpp to avoid having dozen main.cpp files in the search index |
| **sailfish-appname/appname.qml**            | Top-level folder contains only one lower-cased qml file                                                                                    |
| **sailfish-appname/pages**                  | Folder containing only page components, a convention for easier autotesting                                                                |
| **sailfish-appname/pages/folder/\*.qml**    | Subcomponents used by the pages                                                                                                            |
| **sailfish-appname/cover**                  | Folder containing application's active cover UI                                                                                            |
| **sailfish-appname/tests/auto/tst_\*.qml**  | Autotests for the application                                                                                                              |
| **sailfish-appname/tests/benchmarks**       | Benchmarks                                                                                                                                 |

## Application deployment folders

This applies to Sailfish OS system applications.

| Path                                                 | Explanation                                                                                                                                           |
| ---------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------- |
| **/usr/bin/sailfish-appname**                        | Binary that gets executed when the application is opened                                                                                              |
| **/usr/share/sailfish-appname**                      | QML documents and other resources, don't bake QML components into binary to allow updating individual components without re-compilation of the binary |
| **/usr/share/applications/sailfish-appname.desktop** | Desktop file                                                                                                                                          |

## Module project hierarchy

| Path                                                   | Explanation                                                                     |
| ------------------------------------------------------ | ------------------------------------------------------------------------------- |
| **sailfish-modulename**                                | Use dashes "-" where the space would normally go                                |
| **sailfish-modulename/sailfish-modulename.pro**        | Match the pro file name with the folder name                                    |
| **sailfish-modulename/sailfish-modulename.qmlproject** | Optional                                                                        |
| **sailfish-modulename/modulename**                     | QML components and C++ elements exposed by the module                           |
| **sailfish-modulename/modulename/modulename.pro**      | Compilation and deployment rules for the module                                 |
| **sailfish-modulename/modulename/qmldir**              | QML module definition file                                                      |
| **sailfish-modulename/modulename/\*.qml**              | Public QML components mentioned in qmldir                                       |
| **sailfish-modulename/modulename/private**             | Internal, non-public components                                                 |
| **sailfish-modulename/modulename/src**                 | C++ code goes here                                                              |
| **sailfish-modulename/modulename/src/src.pri**         | List C++ header and source files here                                           |
| **sailfish-modulename/modulename/src/\*.h/cpp**        | C++ classes exposed to QML                                                      |
| **sailfish-modulename/modulename/src/modulename.cpp**  | Don't use plugin.cpp to avoid having dozen plugin.cpp files in the search index |
| **sailfish-modulename/applications**                   | Example applications showcasing components provided by the module               |
| **sailfish-modulename/tests/auto/tst_\*.qml**          | Autotests for the module                                                        |
| **sailfish-modulename/tests/benchmarks**               | Benchmarks for the module                                                       |
| **sailfish-modulename/doc**                            | Documentation                                                                   |

## Module deployment folders

| Path                                                            | Explanation                                |
| --------------------------------------------------------------- | ------------------------------------------ |
| **/usr/lib/qt5/qml/Sailfish/Modulename**                        | Use Java-style name spacing                |
| **/usr/lib/qt5/qml/Sailfish/Modulename/qmldir**                 | QML module definition file                 |
| **/usr/lib/qt5/qml/Sailfish/Modulename/\*.qml**                 | Public QML components                      |
| **/usr/lib/qt5/qml/Sailfish/Modulename/private**                | Internal, non-public components            |
| **/usr/lib/qt5/qml/Sailfish/Modulename/libmodulenameplugin.so** | Binary plugin exposing C++ elements to QML |
