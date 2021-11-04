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

Every Sailfish application must define a simple Qt C++ application project that creates a QQuickView and instantiates a QML file with an ApplicationWindow as the top-level item. However, other than implementing the QML file itself, you don’t need to do anything else to accomplish this.

Assuming you named your project “myfirstapp”, the Sailfish OS application template generates the source file src/myfirstapp.cpp that does the heavy lifting for you. This file implements the entry point to your application by simply passing the argument count and argument array to the function SailfishApp::main(). This function in turn creates the required QGuiApplication and QQuickView instances and loads your main QML file.

Note that the name of the QML file is not actually passed to SailfishApp::main(). Instead, the function expects the QML file name to be based on the name of your target. Again, if your project name is “myfirstapp”, the Qt project file will contain the declaration TARGET = myfirstapp, and main() will load the QML file qml/myfirstapp.qml.

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

All QML files used by the application are in the directory qml or its subdirectories. When the application starts, the SailfishApp::main() function first loads the QML file qml/myfirstapp.qml.
```qml
import QtQuick 2.0
import Sailfish.Silica 1.0
import "pages"
```

The first two import statements allow the application to import the Qt Quick and Sailfish Silica modules we will later use. In addition, the final import statement makes the QML files under the pages directory available to myfirstapp.qml.
```qml
ApplicationWindow
{
    initialPage: Component { FirstPage { } }
    cover: Qt.resolvedUrl("cover/CoverPage.qml")
}
```

ApplicationWindow is the top-level type of all Sailfish Silica applications. The initialPage property specifies the first page to display when the application is opened. The cover property sets the active cover to be displayed when the application is pushed to the background.

### First Page of the Application
```
=> qml/pages/FirstPage.qml

```
```qml
Page {
    id: page
```

Here, we first create a Page object which is simply a container for the contents of the page. To enable a pull-down menu, we need to create a flickable item which places its children on a surface that can be pulled and flicked. We do this using the SilicaFlickable component. Sailfish Silica provides the types SilicaFlickable, SilicaListView, and SilicaGridView which are styled versions of the Qt Quick flickable, list view, and grid view types.
```qml
SilicaFlickable {
        anchors.fill: parent
```

Next, we add a pulldown menu with one menu item, labelled “Show Page 2″. We then attach an onClicked action to the MenuItem which will push the second page onto the top of the pageStack (provided by ApplicationWindow). Note that PullDownMenu and PushUpMenu must always be nested inside a SilicaFlickable, SilicaListView, or SilicaGridView.
```qml
        PullDownMenu {
            MenuItem {
                text: "Show Page 2"
                onClicked: pageStack.push(Qt.resolvedUrl("SecondPage.qml"))
            }
         }
```

We set the height of SilicaFlickable to be same as the height of its child item called ‘column’ (see next paragraph).
```qml
contentHeight: column.height
```

Finally, we arrange the content vertically. The Column element positions its child items so that they are vertically aligned and not overlapping. We also provide the page title/header using the PageHeader element. The page header is always placed at the top of content. We add a welcome text to our page using the Label element.
```qml
        Column {
            id: column

            width: page.width
            spacing: Theme.paddingLarge
            PageHeader {
                title: "UI Template"
            }
            Label {
                x: Theme.paddingLarge
                text: "Hello Sailors"
                color: Theme.secondaryHighlightColor
                font.pixelSize: Theme.fontSizeExtraLarge
            }
        }
```

The column spacing, label x, color, and font.pixelSize properties use values from Theme type instead of hard coding sizes or colours. This ensures the application adapts to the currently active theme and does not clash with system provided components.

### Second Page of the Application
```
=> qml/pages/SecondPage.qml
```

The second page is pretty simple. It declares SilicaListView which has a model to define the data to be displayed and a delegate to define how each index of the data should be displayed.
```qml
Page {
    id: page
    SilicaListView {
        id: listView
        model: 20
        anchors.fill: parent
        header: PageHeader {
            title: "Nested Page"
        }
        delegate: BackgroundItem {
            id: delegate

            Label {
                x: Theme.paddingLarge
                text: "Item " + index
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

Covers are the visual representations of backgrounded applications that are displayed on the running applications screen. We create a cover using a CoverBackground element with a centered label inside it.
```qml
CoverBackground {
    Label {
        id: label
        anchors.centerIn: parent
        text: "My Cover"
    }
```

A cover can specify a list of actions that can be performed on the background application. The list is defined using CoverActionList element. Each CoverActionList can define up to two CoverAction items to specify the actions.
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

In the snippet above we display next and pause actions on the cover using two icons. You can also attach signal handlers to these actions to perform a specific function and whilst we won’t cover that in detail in this tutorial, you can try adding onTriggered: console.log("Cover next") to the first CoverAction. Be sure to stop, rebuild, and rerun your application to see the results.

### About Sailfish Silica Components

It’s important to note that Sailfish Silica QML components are designed to be used together. While it may not be immediately obvious, several Silica components cooperate to provide platform-specific functionality.

Editable text fields are one example of this. TextField is the Silica component that provides a one-line editable text field. However, there are several other types that have an effect on how editable text fields behave.

If the TextField is not within a Silica Page, the text field may be obscured by the virtual keyboard. The Page type ensures that page content is scrolled to keep editable text fields visible when the virtual keyboard is shown. Similarly, if the root element of the QML application is not a Silica ApplicationWindow, the background of the virtual keyboard is not correctly styled making it difficult to read the keys.

If you encounter situations where your application behaves differently to other Sailfish OS applications, your first course of action should be to verify that you’re not unintentionally using standard Qt Quick components when a more applicable Silica component is available. This is most likely to be an issue if you’re porting an existing QML application to Sailfish OS.

### Other Files and Directories in This Project

You will notice that in addition to the .qml and .cpp files, there are a couple of other files that we have not touched so far. Let’s quickly go through them before you start exploring the SDK.

`myfirstapp.desktop` is a standard Linux desktop configuration file that describes how a particular program is to be launched, how it appears in menus, etc. This file specifies for example the name and icon of your applcation as they appear in the launcher. More information on the desktop entry specification can be found at standards.freedesktop.org.

`myfirstapp.png` is the launcher icon for the application. The Icon declaration in the .desktop file (e.g. the line Icon=myfirstapp) refers to this image file. The application template takes care of deploying the icon to the correct location, and the Icon declaration in the .desktop file should always refer to the file just by its basename without the suffix. Similarly to the main QML file, the name of the icon is based on the TARGET declaration in the project file. Hence, the icon file name should not be changed unless the TARGET declaration is also updated.

`myfirstapp.pro` is a project file that ties the source code and the resulting application binary together. The file describes how the application is built by creating the Makefile into the appropriate build directory, which is then executed to actually build the application. The CONFIG += sailfishapp declaration in the project file causes your project to be linked against the libsailfishapp library that provides the implementation of the SailfishApp::main() function discussed at the beginning of this tutorial. The CONFIG declaration also ensures the application binary and its data files are deployed to the proper locations both on the emulator and on devices. For more information on the format of the project file, see the qmake Manual.

The qml directory contains files that should be deployed as a part of your application. In addition to QML files, audio, image, and JavaScript files that are used by the application should be placed in this directory or in a subdirectory in it. Basically, anything you put in the qml directory gets deployed when your application is installed in the emulator or on a device.

### Conclusion

Creating intuitive Sailfish Silica UI applications is straightforward. The fact that they are based on QML, a declarative UI language, makes the process fast and easy. It brings in a rich set of user interface elements and an abundance of possibilities. Now you can explore and learn more about how to use them in your application. Check out the media gallery example code available in the SDK for more ideas.

Next, [Packaging Apps](/Develop/Apps/Packaging).
