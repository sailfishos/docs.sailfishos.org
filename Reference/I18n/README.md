---
title: I18n
permalink: Reference/I18n/
layout: default
nav_order: 400
---

## Internationalisation

All of the core components of Sailfish OS are fully internationalised, including the Silica UI components as well as core Sailfish OS services and applications. This means that the content of each application and service can be localised to support some specific combination of language, script, input method, and directionality, and that the user experience of the core Sailfish OS services and applications are not hardcoded to only support some specific region's requirements.

When writing new applications or services to contribute to Sailfish OS, it is important to ensure that the contribution is internationalised, so that all users of Sailfish OS can eventually benefit from it.

### Internationalised Text

All human-readable strings in an application or service need to be embedded in such a way that they can be translated. In Sailfish OS applications, the internationalisation capabilities of Qt are leveraged to provide run-time translation of strings. This means that instead of embedding the human-readable string directly in source code, instead the code contains the identifier of a string, and at run-time the appropriate (UTF-8) string (for that identifier, given the current locale) is displayed.

In C++ the qtTrId() function should be used. The `lupdate` tool will scan C++ code for uses of this function, and generate the appropriate translation output files for the application or service. The qtTrId() function should be used as follows:
```qml
//: This is the context string, which describes to translators in which context the string will be displayed
//% "This is the engineering-english translation, i.e., the string the developer would expect to see in an English localisation"
const QString exampleString = qtTrId("example_internationalised_string_id");
```

In QML the qsTrId() function should be used. The semantics are identical to the qtTrId() function. An example of its use follows:
```qml
Button {
    //: This text will be displayed in a button, which when clicked will quit the application.
    //% "Quit"
    text: qsTrId("example_application-bt-quit")
    onClicked: Qt.quit()
}
```

The qmake project (.pro) file must trigger lupdate to generate the translation files. For example:
```qmake
# translations
TS_FILE = $$OUT_PWD/$$TARGET.ts
EE_QM = $$OUT_PWD/$$TARGET_eng_en.qm

ts.commands += lupdate $$PWD -ts $$TS_FILE
ts.CONFIG += no_check_exist
ts.output = $$TS_FILE
ts.input = .

ts_install.files = $$TS_FILE
ts_install.path = /usr/share/translations/source
ts_install.CONFIG += no_check_exist

engineering_english.commands += lrelease -idbased $$TS_FILE -qm $$EE_QM
engineering_english.CONFIG += no_check_exist
engineering_english.depends = ts
engineering_english.input = $$TS_FILE
engineering_english.output = $$EE_QM

engineering_english_install.path = /usr/share/translations
engineering_english_install.files = $$EE_QM
engineering_english_install.CONFIG += no_check_exist

QMAKE_EXTRA_TARGETS += ts engineering_english
PRE_TARGETDEPS += ts engineering_english
INSTALLS += ts_install engineering_english_install
```

### Directionality

Some locales have specific requirements for directionality of content. For example, in English-speaking locales, text and content should be laid out left-to-right and top-to-bottom, however in some other locales a different directionality is required (e.g., top-to-bottom then left-to-right, or right-to-left). Some content will also need to be mirrored (e.g., directional arrow images) when the layout is reversed.

Applications should be written so that the layout is internationalised, by making use of the directionality support in Qt Quick, via the horizontalAlignment, layoutMirroring, layoutDirection, and effectiveLayoutDirection properties, and querying Qt.application.layoutDirection to determine which alignment to use at run-time (the value of which is determined from the layout direction defined in the currently active translation file).

## Localisation

The people from a particular locale will often require the content they consume to use some particular language, script, input methods, directionality and layout. The act of generating the translated texts, supporting the required scripts, implementing the locale-specific input methods, and defining content layouts or directionality is called localisation. Once the localisation tasks for a specific locale have been completed, people from that locale will be able to use the application or service more easily.

### Translations

The first step in localisation is usually defining translations for every user-visible string in the application or UI. For core Sailfish OS components and applications, the [Sailfish OS Translation Tool](https://translate.sailfishos.org/) is used to define the translation strings. For more information about how to use that tool, please see the page on [Translating Sailfish OS](/Develop/L10n).

The tool includes the translated string identifier, context description, and engineering english text, for every user-visible string in Sailfish OS. Translators can then contribute a new translation (or correction to an existing translation) for that string, for the localisation they wish to improve. The translation strings are added to the locale-specific catalogue which is then indexed at build time, which applications read from at run-time to display the appropriate translated string in the UI.

The translation file will also define the layout directionality (e.g.: left-to-right and top-to-bottom; right-to-left and top-to-bottom; etc) required for that locale.

### Input Methods

Different locales require different input methods. In some locales, a QWERTY-layout virtual keyboard is the most common input method, but other locales require different keyboard layouts, and in some locales the most common input method is hand-writing-recognition.

Sailfish OS allows different input methods to be used on the device, including virtual keyboards, physical keyboards, virtual handwriting pads, and microphone input. The input method system used in Sailfish OS is [Maliit](https://github.com/sailfishos/maliit-framework) which provides an extensible plugin architecture, allowing third-party input method engines (such as from Nuance) to be installed into the system.

### Scripts

Different locales use different scripts for text content. These scripts must be supported for displaying text and in the input method. Amongst others, Sailfish OS currently supports the following scripts:

  - Latin
  - Cyrillic
  - Bokmål
  - Sanskrit

#### Fonts

To support a variety of languages and scripts, the fonts used in the device must support the script used by the language. The standard font on Sailfish OS is called Sail Sans Pro, but other fonts are supported on the system and new fonts can be added to the font database when required.

#### Directionality

Laying out text is a complicated process, involving kerning and ligatures. The directionality of text layout also affects this process, and is important that the application be localised appropriately with respect to content layout and directionality in order to ensure that the content is displayed appropriately.
