---
title: Platform Configuration
permalink: Reference/I18n/Platform_Configuration/
parent: I18n
layout: default
nav_order: 200
---

This page explains how to configure your Platform project for internationalisation.

## The project .spec file

The tools `lupdate` and `lrelease` are included in `qt5-qttools-linguist`, so add that as a `BuildRequires` requirement. The ".qm" file (Engineering English) gets installed with the normal package (`%files`), the ".ts" file (translation source) gets installed with the `-ts-devel` package.

```
BuildRequires: qt5-qttools-linguist

(...)

%files
%{_datadir}/translations/*.qm

(...)

%package ts-devel
Summary: Translation source for %{name}
License: XXX

%description ts-devel
%{summary}.

%files ts-devel
%{_datadir}/translations/source/*.ts
```

## The project pro file

The simplest way to add translations to your project is to add the following to your qmake project (.pro) file, so that it will trigger `lupdate` to generate the translation files:

```qmake
# Translation Source
TS_FILE = $$OUT_PWD/$$TARGET.ts

# Engineering English Translation
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

Alternatively, if you prefer to use subdirs, you should add `SUBDIRS += translations` to the top-level project file, then create `translations/translations.pro` containing the following:

```qmake
TEMPLATE = aux

# Set name of translation catalog here
TRANSLATION_CATALOG = XXX

# Translation Source
TS_FILE = $$OUT_PWD/$${TRANSLATION_CATALOG}.ts

# Engineering English Translation
EE_QM = $$OUT_PWD/$${TRANSLATION_CATALOG}_eng_en.qm

ts.commands += lupdate $$PWD/.. -ts $$TS_FILE
ts.CONFIG += no_check_exist no_link
ts.output = $$TS_FILE
ts.input = ..

ts_install.files = $$TS_FILE
ts_install.path = /usr/share/translations/source
ts_install.CONFIG += no_check_exist

# XXX should add -markuntranslated "-" when proper translations are in place
engineering_english.commands += lrelease -idbased $$TS_FILE -qm $$EE_QM
engineering_english.CONFIG += no_check_exist no_link
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

## Translation loading and harvesting

The `lupdate` utility is used to gather IDs to be translated from code. It produces an XML .ts file that
is then used to create the translations. The `lrelease` tool compiles a translated .ts file into binary
.qm file, which is finally loaded by the application.

Sailfish platform app translations should be deployed to `/usr/share/translations/`.
The Engineering English translation file should follow the format `<component>_eng_en.qm` and the actual
translations have a locale suffix as in `<component>-fi_FI.qm`. By loading first the Engineering English
translations and then the real ones based on locale, it's guaranteed that no IDs are shown in the user
interface. Loading happens with QTranslator on the C++ side:

```
#define I18N_APP "appname"
#define I18N_DIR "/usr/share/translations"
    
QTranslator translator_eng_en;
translator_eng_en.load(I18N_APP "_eng_en", I18N_DIR);
app.installTranslator(&translator_eng_en);
    
QTranslator translator;
translator.load(QLocale(), I18N_APP, "-", I18N_DIR);
app.installTranslator(&translator);
```

The generated .ts file should be installed into `/usr/share/translations/source/<component>.ts` and
packaged into `<component>-ts-devel.rpm`. It can then be automatically used for translation services
which eventually produce the locale based translations files. The actual translations are not put 
into the source code repository.

For pure QML plugins, the localisation support is unfortunately not so easy. Translation files need
to be loaded before any text property gets set which complicates things. A solution is to have the
C++ side of the plugin take care of initialisation:

```
...
#include <QTranslator>

class AppTranslator: public QTranslator
{
    Q_OBJECT
public:
    AppTranslator(QObject *parent)
        : QTranslator(parent)
    {
        qApp->installTranslator(this);
    }

    ~AppTranslator() override
    {
        qApp->removeTranslator(this);
    }
};

class SailfishModulenamePlugin : public QQmlExtensionPlugin
{
    ...
public:
    void initializeEngine(QQmlEngine *engine, const char *uri)
    {
        if (QLatin1String(uri) != QLatin1String("Sailfish.Modulename")) {
            return;
        }
        ...

        AppTranslator *engineeringEnglish = new AppTranslator(engine);
        AppTranslator *translator = new AppTranslator(engine);
        AppTranslator *modulenameTranslator = new AppTranslator(engine);
        engineeringEnglish->load("sailfish_components_modulename_eng_en", "/usr/share/translations");
        translator->load(QLocale(), "sailfish_components_modulename", "-", "/usr/share/translations");
        modulenameTranslator->load(QLocale(), "modulename", "-", "/usr/share/translations");
    }
    ...
};
```



