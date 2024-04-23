---
title: I18n
permalink: Reference/I18n/
has_children: true
layout: default
nav_order: 400
---

The following sections explain how to configure Sailfish OS Platform and Application projects for internationalisation (I18n).

## Internationalisation

All of the core components of Sailfish OS are fully internationalised, including the Silica User Interface components as well as core Sailfish OS services and applications. This means that the content of each application and service can be localised to support some specific combination of language, script, input method, and directionality, and that the user experience of the core Sailfish OS services and applications are not hardcoded to only support some specific region's requirements.

When writing new applications or services to contribute to Sailfish OS, it is important to ensure that the contribution is internationalised, so that all users of Sailfish OS can eventually benefit from it.

As far as possible Sailfish OS makes use of the existing Qt internationalisation capabilities. You may therefore find it useful to refer to the Qt documentation on [Qt Quick internationalisation](https://doc.qt.io/qt-5/qtquick-internationalization.html) and [Qt Linguist](https://doc.qt.io/qt-5/linguist-programmers.html).

However, we also have our own conventions and technical requirements which are detailed on these pages. Here you can read more information about the [general conventions](/Reference/I18n/I18n_Conventions) that all Sailfish OS projects need to consider. We also have specific details about the canonical way to configure Qt-based [Platform projects](/Reference/I18n/Platform_Configuration) and [Sailfish applications](/Reference/I18n/Application_Configuration) for internationalisation.

While not mandatory for making use of translations in an app or component, for more general info about the Sailfish OS localisation process, you may also find it interesting to refer to the [L10n section](/Develop/L10n/).

## Localisation

The people from a particular locale will often require the content they consume to use some particular language, script, input methods, directionality and layout. The act of generating the translated texts, supporting the required scripts, implementing the locale-specific input methods, and defining content layouts or directionality is called localisation. Once the localisation tasks for a specific locale have been completed, people from that locale will be able to use the application or service more easily.

### Translations

The first step in localisation is usually defining translations for every user-visible string in the application or user interface. For core Sailfish OS components and applications, the [Sailfish OS Translation Tool](https://translate.sailfishos.org/) is used to define the translation strings. For more information about how to use that tool, please see the page on [Translating Sailfish OS](/Develop/L10n).

The tool includes the translated string identifier, context description, and Engineering English text, for every user-visible string in Sailfish OS. Translators can then contribute a new translation (or correction to an existing translation) for that string, for the localisation they wish to improve. The translation strings are added to the locale-specific catalogue which is then indexed at build time, which applications read from at run-time to display the appropriate translated string in the user interface.

### Input Methods

Different locales require different input methods. In some locales, a QWERTY-layout virtual keyboard is the most common input method, but other locales require different keyboard layouts, and in some locales the most common input method is hand-writing-recognition.

Sailfish OS allows different input methods to be used on the device, including virtual keyboards, physical keyboards, virtual handwriting pads, and microphone input. The input method system used in Sailfish OS is [Maliit](https://github.com/sailfishos/maliit-framework) which provides an extensible plugin architecture. The Sailfish virtual keyboard also has its own extension mechanism to load different types of input UIs.

### Scripts

Different locales use different scripts for text content. These scripts must be supported for displaying text and in the input method. Amongst others, Sailfish OS currently supports the following scripts:

  - Latin
  - Cyrillic
  - Greek
  - Kannada
  - Gujarati
  - Devanagari
  - Bengali
  - Telugu
  - Tamil
  - Punjabi
  - Malayalam
  - Traditional Chinese
  - Simplified Chinese
  - Thai
  - Arabic

### Fonts

To support a variety of languages and scripts, the fonts used in the device must support the script used by the language. The standard font on Sailfish OS is called Sail Sans Pro, but other fonts are supported on the system and new fonts can be added to the font database when required.

### Directionality

Laying out text is a complicated process, involving kerning and ligatures. The directionality of text layout also affects this process, and is important that the application be localised appropriately with respect to content layout and directionality in order to ensure that the content is displayed appropriately.
