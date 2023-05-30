---
title: Code Walkthrough
permalink: Develop/Apps/Code_Walkthrough/
parent: Apps
layout: default
nav_order: 400
---

## Code Walkthrough

The template contains the essentials of a simple Sailfish OS application. We’ll go through the code to help understand the essentials.

When generating a new project based on the Sailfish OS application template, some of the files in the Qt Creator project are named after the name of the project. In the following discussion the project name “myfirstapp” is used as an example.

### Application Entry
```
=> src/myfirstapp.cpp
```

Every Sailfish application must define a simple Qt C++ application project that creates a [`QQuickView`](https://doc.qt.io/qt-5/qquickview.html) and instantiates a QML file with an [`ApplicationWindow`](https://sailfishos.org/develop/docs/silica/qml-sailfishsilica-sailfish-silica-applicationwindow.html/) as the top-level item. However, other than implementing the QML file itself, you don’t need to do anything else to accomplish this.

Assuming you named your project “myfirstapp”, the Sailfish OS application template generates the source file `src/myfirstapp.cpp` that does the heavy lifting for you. This file implements the entry point to your application by simply passing the argument count and argument array to the function [`SailfishApp::main()`](https://sailfishos.org/develop/docs/libsailfishapp/sailfishapp.html/#main). This function in turn creates the required [`QGuiApplication`](https://doc.qt.io/qt-5/qguiapplication.html) and [`QQuickView`](https://doc.qt.io/qt-5/qquickview.html) instances and loads your main QML file.

Note that the name of the QML file is not actually passed to [`SailfishApp::main()`](https://sailfishos.org/develop/docs/libsailfishapp/sailfishapp.html/#main). Instead, the function expects the QML file name to be based on the name of your target. Again, if your project name is “myfirstapp”, the Qt project file will contain the declaration `TARGET = myfirstapp`, and `main()` will load the QML file `qml/myfirstapp.qml`.

The application template creates the QML file for you but you should be aware of the fact that the file cannot be renamed without updating the TARGET definition in the .pro file.
```cpp
#ifdef QT_QML_DEBUG
#include
#endif

#include


int main(int argc, char *argv[])
{
    // SailfishApp::main() will display "qml/myfirstapp.qml", if you need more
    // control over initialization, you can use:
    //
    //   - SailfishApp::application(int, char *[]) to get the QGuiApplication *
    //   - SailfishApp::createView() to get a new QQuickView * instance
    //   - SailfishApp::pathTo(QString) to get a QUrl to a resource file
    //
    // To display the view, call "show()" (will show fullscreen on device).

    return SailfishApp::main(argc, argv);
}
```

### Top-level QML file
```
=> qml/myfirstapp.qml
```

All QML files used by the application are in the directory qml or its subdirectories. When the application starts, the [`SailfishApp::main()`](https://sailfishos.org/develop/docs/libsailfishapp/sailfishapp.html/#main) function first loads the QML file `qml/myfirstapp.qml`.
```qml
import QtQuick 2.0
import Sailfish.Silica 1.0
import "pages"
```

The first two import statements allow the application to import the Qt Quick and Sailfish Silica modules we will later use. In addition, the final import statement makes the QML files under the pages directory available to `myfirstapp.qml`.
```qml
ApplicationWindow
{
    initialPage: Component { FirstPage { } }
    cover: Qt.resolvedUrl("cover/CoverPage.qml")
    allowedOrientations: defaultAllowedOrientations
}
```

[`ApplicationWindow`](https://sailfishos.org/develop/docs/silica/qml-sailfishsilica-sailfish-silica-applicationwindow.html/) is the top-level type of all Sailfish Silica applications. Each application window contains a single page stack, accessible through the [`pageStack`](https://sailfishos.org/develop/docs/silica/qml-sailfishsilica-sailfish-silica-applicationwindow.html/#pageStack-prop) property, that determines the content to be displayed by the application. The stack is made up of [`Page`](https://sailfishos.org/develop/docs/silica/qml-sailfishsilica-sailfish-silica-page.html) objects.

The [`initialPage`](https://sailfishos.org/develop/docs/silica/qml-sailfishsilica-sailfish-silica-applicationwindow.html/#initialPage-prop) property specifies the first page to display when the application is opened. The [`cover`](https://sailfishos.org/develop/docs/silica/qml-sailfishsilica-sailfish-silica-applicationwindow.html/#cover-prop) property sets the active cover to be displayed when the application is pushed to the background.

[`allowedOrientations`](https://sailfishos.org/develop/docs/silica/qml-sailfishsilica-sailfish-silica-applicationwindow.html/#allowedOrientations-prop) property sets the orientations that the interface may be rotated to. As described in the [documentation](https://sailfishos.org/develop/docs/silica/qml-sailfishsilica-sailfish-silica-applicationwindow.html/#allowedOrientations-prop), binding it to [`defaultAllowedOrientations`](https://sailfishos.org/develop/docs/silica/qml-sailfishsilica-sailfish-silica-applicationwindow.html/#defaultAllowedOrientations-prop) makes the application follow the default orientation behaviour of the platform applications.

### First Page of the Application
```
=> qml/pages/FirstPage.qml

```
```qml
Page {
    id: page
    allowedOrientations: Orientation.All
```
Here, we first create a [`Page`](https://sailfishos.org/develop/docs/silica/qml-sailfishsilica-sailfish-silica-page.html/) object which is simply a container for the contents of the page. With [`allowedOrientations`](https://sailfishos.org/develop/docs/silica/qml-sailfishsilica-sailfish-silica-page.html/#allowedOrientations-prop) we could restrict the allowed orientations of the page. Effectively the set of allowed orientations is an intersection of the allowed orientations in the `ApplicationWindow` and the `Page`.

To enable a pull-down menu, we need to create a flickable item which places its children on a surface that can be pulled and flicked. We do this using the [`SilicaFlickable`](https://sailfishos.org/develop/docs/silica/qml-sailfishsilica-sailfish-silica-silicaflickable.html/) component. Sailfish Silica provides the types [`SilicaFlickable`](https://sailfishos.org/develop/docs/silica/qml-sailfishsilica-sailfish-silica-silicaflickable.html/), [`SilicaListView`](https://sailfishos.org/develop/docs/silica/qml-sailfishsilica-sailfish-silica-silicalistview.html), and [`SilicaGridView`](https://sailfishos.org/develop/docs/silica/qml-sailfishsilica-sailfish-silica-silicagridview.html) which are styled versions of the Qt Quick flickable, list view, and grid view types.


```qml
SilicaFlickable {
        anchors.fill: parent
```

Next, we add a pulldown menu with one menu item, labelled “Show Page 2″. [`qsTr()`](https://doc.qt.io/qt-5/qtquick-internationalization.html#1-use-qstr-for-all-literal-user-interface-strings) is a function which provides localised strings. Depending on the UI language of the device, the end user will see different texts.

We then attach an [`onClicked`](https://sailfishos.org/develop/docs/silica/qml-sailfishsilica-sailfish-silica-menuitem.html/#clicked-signal) action to the [`MenuItem`](https://sailfishos.org/develop/docs/silica/qml-sailfishsilica-sailfish-silica-menuitem.html/) which will push the second page onto the top of the [`pageStack`](https://sailfishos.org/develop/docs/silica/qml-sailfishsilica-sailfish-silica-applicationwindow.html/#pageStack-prop) (provided by [`ApplicationWindow`](https://sailfishos.org/develop/docs/silica/qml-sailfishsilica-sailfish-silica-applicationwindow.html/)). Note that [`PullDownMenu`](https://sailfishos.org/develop/docs/silica/qml-sailfishsilica-sailfish-silica-pulldownmenu.html) and [`PushUpMenu`](https://sailfishos.org/develop/docs/silica/qml-sailfishsilica-sailfish-silica-pushupmenu.html) must always be nested inside a [`SilicaFlickable`](https://sailfishos.org/develop/docs/silica/qml-sailfishsilica-sailfish-silica-silicaflickable.html), [`SilicaListView`](https://sailfishos.org/develop/docs/silica/qml-sailfishsilica-sailfish-silica-silicalistview.html), or [`SilicaGridView`](https://sailfishos.org/develop/docs/silica/qml-sailfishsilica-sailfish-silica-silicalistview.html).

```qml
        PullDownMenu {
            MenuItem {
                text: qsTr("Show Page 2")
                onClicked: pageStack.animatorPush(Qt.resolvedUrl("SecondPage.qml"))
            }
         }
```

We set the height of [`SilicaFlickable`](https://sailfishos.org/develop/docs/silica/qml-sailfishsilica-sailfish-silica-silicaflickable.html) to be same as the height of its child item called ‘column’ (see next paragraph).
```qml
        contentHeight: column.height
```

Finally, we arrange the content vertically. The [`Column`](https://doc.qt.io/qt-5/qml-qtquick-column.html) element positions its child items so that they are vertically aligned and not overlapping. We also provide the page title/header using the [`PageHeader`](https://sailfishos.org/develop/docs/silica/qml-sailfishsilica-sailfish-silica-pageheader.html) element. The page header is always placed at the top of content. We add a welcome text to our page using the [`Label`](https://sailfishos.org/develop/docs/silica/qml-sailfishsilica-sailfish-silica-label.html) element.
```qml
        Column {
            id: column

            width: page.width
            spacing: Theme.paddingLarge
            PageHeader {
                title: qsTr("UI Template")
            }
            Label {
                x: Theme.horizontalPageMargin
                text: qsTr("Hello Sailors")
                color: Theme.secondaryHighlightColor
                font.pixelSize: Theme.fontSizeExtraLarge
            }
        }
```

The column [`spacing`](https://doc.qt.io/qt-5/qml-qtquick-column.html#spacing-prop), label [`x`](https://doc.qt.io/qt-5/qml-qtquick-item.html#x-prop), [`color`](https://doc.qt.io/qt-5/qml-qtquick-text.html#color-prop), and [`font.pixelSize`](https://doc.qt.io/qt-5/qml-qtquick-text.html#font.pixelSize-prop) properties use values from [`Theme`](https://sailfishos.org/develop/docs/silica/qml-sailfishsilica-sailfish-silica-theme.html/) type instead of hard coding sizes or colours. This ensures the application adapts to the currently active theme and does not clash with system provided components.

### Second Page of the Application
```
=> qml/pages/SecondPage.qml
```

The second page is pretty simple. It declares [`SilicaListView`](https://sailfishos.org/develop/docs/silica/qml-sailfishsilica-sailfish-silica-silicalistview.html) which has a model to define the data to be displayed and a delegate to define how each index of the data should be displayed.
```qml
Page {
    id: page

    allowedOrientations: Orientation.All

    SilicaListView {
        id: listView
        model: 20
        anchors.fill: parent
        header: PageHeader {
            title: qsTr("Nested Page")
        }
        delegate: BackgroundItem {
            id: delegate

            Label {
                x: Theme.horizontalPageMargin
                text: qsTr("Item") + " " + index
                anchors.verticalCenter: parent.verticalCenter
                color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
            }
            onClicked: console.log("Clicked " + index)
        }
        VerticalScrollDecorator {}
    }
}
```

### Application Cover
```
=> qml/cover/CoverPage.qml
```

Covers are the visual representations of backgrounded applications that are displayed on the running applications screen. We create a cover using a [`CoverBackground`](https://sailfishos.org/develop/docs/silica/qml-sailfishsilica-sailfish-silica-coverbackground.html) element with a centered label inside it.
```qml
CoverBackground {
    Label {
        id: label
        anchors.centerIn: parent
        text: qsTr("My Cover")
    }
```

A cover can specify a list of actions that can be performed on the background application. The list is defined using [`CoverActionList`](https://sailfishos.org/develop/docs/silica/qml-sailfishsilica-sailfish-silica-coveractionlist.html) element. Each CoverActionList can define up to two [`CoverAction`](https://sailfishos.org/develop/docs/silica/qml-sailfishsilica-sailfish-silica-coveraction.html) items to specify the actions.
```qml
CoverActionList {
        id: coverAction

        CoverAction {
            iconSource: "image://theme/icon-cover-next"
        }

        CoverAction {
            iconSource: "image://theme/icon-cover-pause"
        }
    }
```

In the snippet above we display next and pause actions on the cover using two icons. You can also attach signal handlers to these actions to perform a specific function and whilst we won’t cover that in detail in this tutorial, you can try adding `onTriggered: console.log("Cover next")` to the first CoverAction. Be sure to stop, rebuild, and rerun your application to see the results.

### About Sailfish Silica Components

It’s important to note that Sailfish Silica QML components are designed to be used together. While it may not be immediately obvious, several Silica components cooperate to provide platform-specific functionality.

Editable text fields are one example of this. [`TextField`](https://sailfishos.org/develop/docs/silica/qml-sailfishsilica-sailfish-silica-textfield.html) is the Silica component that provides a one-line editable text field. However, there are several other types that have an effect on how editable text fields behave.

If the TextField is not within a Silica [`Page`](https://sailfishos.org/develop/docs/silica/qml-sailfishsilica-sailfish-silica-page.html), the text field may be obscured by the virtual keyboard. The Page type ensures that page content is scrolled to keep editable text fields visible when the virtual keyboard is shown. Similarly, if the root element of the QML application is not a Silica [`ApplicationWindow`](https://sailfishos.org/develop/docs/silica/qml-sailfishsilica-sailfish-silica-applicationwindow.html), the background of the virtual keyboard is not correctly styled making it difficult to read the keys.

If you encounter situations where your application behaves differently to other Sailfish OS applications, your first course of action should be to verify that you’re not unintentionally using standard Qt Quick components when a more applicable Silica component is available. This is most likely to be an issue if you’re porting an existing QML application to Sailfish OS.

### Other Files and Directories in This Project

You will notice that in addition to the .qml and .cpp files, there are a couple of other files that we have not touched so far. Let’s quickly go through them before you start exploring the SDK.

`myfirstapp.desktop` is a standard Linux desktop configuration file that describes how a particular program is to be launched, how it appears in menus, etc. This file specifies for example the name and icon of your applcation as they appear in the launcher. More information on the `Desktop Entry` specification can be found at [Freedesktop.org Specifications](https://standards.freedesktop.org) page.

The .desktop file also contains `X-SailJail` section, which defines the sandboxing profile for the application. `OrganizationName` and `ApplicationName` are used for determining the directory names used for storing application configuration, data and cache files. `Permissions` field lists all the permissions that our application requests. As our example does not need any permissions, we leave the field empty. You can find more detailed description of the X-SailJail section in the [Sailfish OS application sandboxing and permissions](https://github.com/sailfishos/sailjail-permissions#sailfish-os-application-sandboxing-and-permissions) documentation.

```ini
[X-Sailjail]
OrganizationName=org.myorg
ApplicationName=myfirstapp
Permissions=
```

`myfirstapp.png` is the launcher icon for the application. The `Icon` declaration in the .desktop file (i.e. the line `Icon=myfirstapp`) refers to this image file. The application template takes care of deploying the icon to the correct location, and the Icon declaration in the .desktop file should always refer to the file just by its basename without the suffix. Similarly to the main QML file, the name of the icon is based on the TARGET declaration in the project file. Hence, the icon file name should not be changed unless the TARGET declaration is also updated.

`myfirstapp.pro` is a project file that ties the source code and the resulting application binary together. The file describes how the application is built by creating the `Makefile` into the appropriate build directory, which is then executed to actually build the application. The `CONFIG += sailfishapp` declaration in the project file causes your project to be linked against the libsailfishapp library that provides the implementation of the `SailfishApp::main()` function discussed at the beginning of this tutorial. The CONFIG declaration also ensures the application binary and its data files are deployed to the proper locations both on the emulator and on devices. For more information on the format of the project file, see the [qmake Manual](https://doc.qt.io/qt-5/qmake-manual.html).

The qml directory contains files that should be deployed as a part of your application. In addition to QML files, audio, image, and JavaScript files that are used by the application should be placed in this directory or in a subdirectory in it. Basically, anything you put in the qml directory gets deployed when your application is installed in the emulator or on a device.

### Conclusion

Creating intuitive Sailfish Silica UI applications is straightforward. The fact that they are based on QML, a declarative UI language, makes the process fast and easy. It brings in a rich set of user interface elements and an abundance of possibilities. Now you can explore and learn more about how to use them in your application. Check out the media gallery example code available in the SDK for more ideas.

Next, [Packaging Apps](/Develop/Apps/Packaging).
