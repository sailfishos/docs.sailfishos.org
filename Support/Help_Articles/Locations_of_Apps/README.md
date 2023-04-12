---
title: Locations of Apps
permalink: Support/Help_Articles/Locations_of_Apps/
parent: Help Articles
layout: default
nav_order: 550
---

This document attempts to answer the question _"Where do apps keep their data in the Sailfish filesystem?"_

It may be useful to know the whereabouts of various apps if there is a serious problem with some app or feature. We would not recommend the command line approach for normal users but for those with programming skills.

NOTE 1:  OS release 3.4.0 and later can have either "defaultuser" or "nemo" as the primary user (admin) of Sailfish OS. Therefore, to express the paths in a generic way below, the environment variable "$MYHOME" is used. So, MYHOME stands for either "/home/defaultuser" or "/home/nemo", and it holds its value also after getting the super-user rights with the "devel-su" command.

NOTE 2:  Most of the paths mentioned below require super-user rights for access. Hence, you need to enable the **[Developer-Mode.](/Support/Help_Articles/Enabling_Developer_Mode/)**

# Preparations

Go to your home directory first and define variable MYHOME:

```
cd $HOME
export MYHOME=$(pwd)
devel-su    ## SSH password required 
```

# Sailfish apps

## Calendar

```
$MYHOME/.local/share/system/privileged/Calendar/mkcal/
```

This directory contains the "db" and "db.changed" files for services like Google and CalDAV.

## Exchange Active Sync (EAS)

EAS means the Microsoft Exchange services (email, calendar, contacts).

```
$MYHOME/.local/share/system/privileged/eas-sailfish/
```

This directory contains the SQL database file "sailfish_eas.db".

## Contacts

```
$MYHOME/.local/share/system/privileged/Contacts/qtcontacts-sqlite/  
```

This directory contains SQL files "contacts.db*". They hold the contacts of all accounts and also the local (non-synced) contacts.

## Avatars
```
$MYHOME/.local/share/system/privileged/Contacts/avatars/Google
```

This directory contains the avatars of contacts synced with the Google service.

## Messages (SMS)
```
$MYHOME/.local/share/commhistory/
```

This directory contains SQL database ("commhistory.db*") of text messages. We also have the related document ["Exporting SMS and MMS messages"](https://jolla.zendesk.com/hc/en-us/articles/203569178).

## Notes
```
$MYHOME/.local/share/com.jolla/notes/QML/OfflineStorage/Databases/
```

This directory contains the SQL files "*.ini" and "*.sqlite" of Sailfish Notes.

## Email

The email database is located in
```
$MYHOME/.qmf/
```

This directory contains the folders "database", "mail" and "tmp".

## Call history

The phone call logs are kept in

```
$MYHOME/.local/share/commhistory/commhistory.db
```

This database can be investigated with the comm history tool...

```
commhistory-tool listcalls    
\## shows for example:
10404|3|Sat Feb 1 13:27:30 2014|Sat Feb 1 13:27:30 2014|2|0|1|0|0|(\[/org/freedesktop/Telepathy/Account/ring/tel/account0:+441555555555\])||||-1|||0|0|0|0|0|0||
\## and this is also in commhistory.db  
```

...and with SQLite:

```
sqlite3 .local/share/commhistory/commhistory.db --cmd 'select * from events where id="10404";'
\## shows:
10404|3|1391254050|1391254050|2|0|1|0|0|0|0|/org/freedesktop/Telepathy/Account/ring/tel/account0|+44555555555||||||0||||0|0||||0|0|0||0|0|0
```

## Call recordings

Phone call logs on Sailfish OS 4.0.0 and later are kept in
```
$MYHOME/.local/share/system/privileged/Phone/CallRecordings/
```

The recorded calls are saved in "*.wav" files.

## Ambiences

The storage of built-in ambiences of Sailfish OS resides in
```
/usr/share/ambience
```

Each built-in (default) ambience has a dedicated folder holding the actual ambience file and a subfolder containing the jpg of the background image.

All ambiences, the built-in ones and those created by the user are managed in an SQLite database at
```
$MYHOME/.local/share/system/privileged/Ambienced/ambienced.sqlite
```
  


# Android apps

The common storage area of all Android apps is located at:
```
$MYHOME/android_storage/
```

It also contains the "Android" directory that has all the installed Android apps in the "data" subdirectory:
```
$MYHOME/android_storage/Android/data/
```


