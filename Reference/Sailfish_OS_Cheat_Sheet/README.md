---
title: Sailfish OS Cheat Sheet
permalink: Reference/Sailfish_OS_Cheat_Sheet/
layout: default
nav_order: 900
---

## Development Commands

The default IP of the device for USB connections is set in Settings \> Developer tools \> USB IP address, which is by default set to `192.168.2.15`. On this page we are referring to this with **device** which one can use alias for with following methods

**A) (RECOMMENDED)** add following to your `~/.ssh/config` file, which also makes the connection easier to handle if you are using multiple developer devices behind same IP address
```ssh-config
# Dev devices which constantly change the ID
Host device
    User defaultuser
    HostName 192.168.2.15
    StrictHostKeyChecking no
    UserKnownHostsFile=/dev/null
    IdentitiesOnly yes
```

**B)** example to your `/etc/hosts` file, by adding following line there
```
192.168.2.15    device
```

Connect to the device over usb
```nosh
sudo ifconfig usb0 up device
```

Log into the device. Define password in "Settings \> Developer tools \> Remote connection".
```nosh
ssh defaultuser@device
```

Change user to root
```nosh
su       # if on SDK, or
devel-su # if on device
```

Remove changed IP from known_hosts
```nosh
ssh-keygen -R device
```

Update development environment

```nosh
sfdk tools update <target>
```

Build project

```nosh
sfdk config target=<target>
sfdk build # finds the spec under rpm
sfdk --specfile rpm/<package>.spec build # specify spec yourself
```

Copy packages to the device
```nosh
scp ./RPMS/<package>.rpm <user>@device:
```

Listen to system logs
```nosh
devel-su journalctl -fa # Sailfish
devel-su /system/bin/logcat -v time # Android apps
```

See also [logcat usage help article](https://jolla.zendesk.com/hc/en-us/articles/204110913)

Search log for keyword 'account' ignoring the case
```nosh
devel-su journalctl | grep -i account
```

Open file (apk, media file, vcard, call number, etc.) with appropriate app.
```nosh
xdg-open file # e.g. xdg-open image.jpg
```

List shared library dependencies
```nosh
ldd /usr/lib/qt5/qml/modulepath/libmodule.so
```

List exported symbols
```nosh
zypper in binutils && nm -D /usr/lib/library.so.0
```

Set DConf value
```nosh
dconf write /desktop/meego/background/portrait/picture_filename \'/pathto/wallpaper.jpg\'
```

Print DConf value
```nosh
dconf read /desktop/meego/background/portrait/picture_filename
```

List incoming hardware input events

Install mcetool
```nosh
zypper in mce-tools
```

```nosh
evdev_trace -t
```

Find folders that take more than 100MB of space
```nosh
du -a -x / | awk '{if($1 > 102400) print int($1/1024) "MB" " " $2 }' # root partition
du -a -x /home | awk '{if($1 > 102400) print int($1/1024) "MB" " " $2 }' # home partition
```

List RPM packages that take the most space in the system
```nosh
rpm -qa --queryformat '%{size} %{name}\n' | sort -rn | more
```

Execute QML document.
```nosh
devel-su -p pkcon install qt5-qtdeclarative-qmlscene # install qmlscene
devel-su ln -s /usr/lib/qt5/bin/qmlscene /usr/bin/qmlscene # add symbolic link to path
qmlscene app.qml # run
```

Cleaning up the leftover packages from the system, first refresh the database, then check leftover and lastly remove wanted packages:
```nosh
zypper ref
zypper packages --orphaned
zypper remove --clean-deps PACKAGENAME
```

## Diagnostics

Saving logs is always good
```nosh
devel-su journalctl -a > ~/saved.journal
```

Add -f to contiously listen to the log output:
```nosh
devel-su journalctl -fa
```

The systemd journal is persistent over reboots in devel branch and in release branches if you want to have this behaviour you can edit /etc/systemd/journald.conf and set
```
Storage=persistent
```

By default, the systemd journal throttles output from particularly noisy processes, which can be frustrating when trying to debug an application. Preventing journald from throttling logging from a verbose process - edit /etc/systemd/journald.conf and set
```ini
RateLimitBurst=9999
RateLimitInterval=5s
```

Which will cause systemd to throttle journal output from any process which emits more than 9999 lines of output in any five second interval NOTE: after doing changes for /etc/systemd/journald.conf you should reboot the device.

Various processes can be made more verbose by setting certain environment variables:
```nosh
QT_LOGGING_RULES="*.debug=true"               # any application or service using Qt Categorized Logging
QT_LOGGING_RULES="buteo.*.debug=true"         # Buteo processes and any Buteo sync plugin
SSO_LOGGING_LEVEL=3 SSOUI_LOGGING_LEVEL=3     # Accounts&SSO services
CONTACTSD_DEBUG=1                             # contactsd instant messaging roster synchronisation daemon
QTCONTACTS_SQLITE_TWCSA_TRACE=1 QTCONTACTS_SQLITE_TRACE=1  # qtcontacts-sqlite backend debug output
QT_LOGGING_RULES="org.kde.pim.mkcal.debug=true"            # mKCal debug output
QT_LOGGING_RULES="kf.calendarcore.debug=true" # KCalendarCore debug output
LIPSTICK_COMPOSITOR_DEBUG=1                   # homescreen debug output
```

Qt category logging can be contolled by editing qtlogging.ini. This is an override file - so if that file doesn't exist, just the "default" logging categories are enabled, but if that file does exist, then the categories specified in the file are used:
```nosh
/home/<user>/.config/QtProject/qtlogging.ini
```

There are many categories defined in Sailfish OS such as:
```
org.sailfishos.settings.memorycard
org.sailfishos.browser.core
```

Qt logging categories can be searched from sources by looking for `Q_LOGGING_CATEGORY`.

`
Some processes can be made more verbose by installing specific "tracing" packages which configure the service to be more verbose when installed (via `devel-su -p pkcon install <pkgname>`). Some examples include:
```
connman-tracing
bluez5-tracing
connectionagent-qt5-tracing
```

Unfortunately, due to the heterogeneous nature of the packages in Sailfish OS, there is no unified way to enable verbose debug logging, and so the contributor will in some cases have to read the source code to figure out what they need to do to make debug logging work. It may even require setting some #define in source code, and rebuilding the package.

### Home Screen and Compositor diagnostics

Lipstick debugs can be enabled by adding LIPSTICK_COMPOSITOR_DEBUG=1 to /var/lib/environment/compositor/\*.conf.

Now restart lipstick and you have a small box at the bottom of the screen for debugging the top most window. "Dump" button outputs data of the top most window to the journal. "Expose" button shows current windows.

In case screen is locked or/and touch is not responding but you have an access to the device. Top most window can be dumped like:
```nosh
dbus-send --type=method_call --print-reply --dest=org.nemomobile.compositor.debug /debug org.nemomobile.compositor.debug.dump
```

Similarly use LIPSTICK_COMPOSITOR_TOUCH_DEBUG=1 to debug touch issues with edge swipes.

### Calling diagnostics

Enabling voicecall manager debug logs requires modifying source codes, rebuilding and installing the project packages:
```
voicecall/lib/src/common.h -> #define WANT_TRACE
```

Enabling Phone app logs requires modifying source code line:
```
/usr/share/voicecall-ui-jolla/VoiceCallManager.qml -> enableDebugLog: true
```

### Backup Diagnostics

On the target device go to the command line. Download there [Backup status reporting script](https://github.com/sailfishos/the-vault/blob/master/tools/the-vault-storage-report.sh) and make it executable.
```nosh
curl -o the-vault-storage-report.sh https://github.com/sailfishos/the-vault/blob/master/tools/the-vault-storage-report.sh && chmod a+x the-vault-storage-report.sh
```

Execute the command in privileged mode.
```nosh
devel-su -p ./the-vault-storage-report.sh > /home/<user>/backup-status-report.txt
```

Attach resulting `/home/<user>/backup-status-report.txt` file to your bug report.

### OS Update Diagnostics

Provide the journal of the OS update and /var/log/zypp/history, so developers can debug what went wrong.

### Browser Diagnostics / Debugging

Content moved to [Working with Browser](/Reference/Core_Areas_and_APIs/Browser/Working_with_Browser)

### Multimedia debugging

There are different debugging mechanisms available depending on the subsystem used:

#### GStreamer

The environment variable [GST_DEBUG](https://gstreamer.freedesktop.org/documentation/tutorials/basic/debugging-tools.html?gi-language=c) can be used to selectively increase GStreamer logging per element e.g.
```nosh
GST_DEBUG=droidcamsrc:2 jolla-camera
```

to set the debug log level of the camera element to WARN. Other useful values are 1 (Error), 4 (Info) and 5 (Debug).

[DOT file generation](https://developer.ridgerun.com/wiki/index.php/How_to_generate_a_Gstreamer_pipeline_diagram_%28graph%29) is enabled in recent versions of QtMultimedia for camera and media playback. These files describe the GStreamer pipeline at certain points, so you can see which elements are being used and the properties of the data passing between them. They can be transformed into images using 'graphviz'.
```nosh
GST_DEBUG_DUMP_DOT_DIR=/tmp/ jolla-gallery
```

Then on a PC with graphviz installed, this script will turn any DOT files in the current directory into PNG images:
```nosh
DOT_FILES=`find ./*.dot`
for file in $DOT_FILES
do
    dest=`sed s/.dot/.png/ <<< "$file"`
    dot -Tpng $file > $dest
done
```

#### Camera

Although GST_DEBUG can be used to obtain logs for the droidcamsrc element of gst-droid, the droidmedia and Android Stagefright components will log to the android system log. This can be viewed as root by using:
```nosh
devel-su
/usr/libexec/droid-hybris/system/bin/logcat
```

All log lines since boot are displayed, with the oldest lines being removed once a size limit is reached. This means there can be a lot of irrelevant output already collected in logcat before you start debugging. To remove this, call logcat with -c.

### Email / Active Sync (e-mail) debugging

Email logging can be made more verbose by editing configuration files and rebooting:
```nosh
/home/<user>/.config/QtProject/Messageserver.conf  # email, QtMessagingFramework configuration file
/home/<user>/.config/eas-sailfish.conf  # Exchange ActiveSync plugin configuration file
```

For example, to make the Exchange ActiveSync plugin fully verbose, first ensure that journald won't throttle logging output (see the notes on editing `/etc/systemd/journald.conf` [burst limits](/Reference/Sailfish_OS_Cheat_Sheet#diagnostics)) and then ensure that the `/home/<user>/.config/eas-sailfish.conf` file contains the following:
```ini
[logging]
Sailfish.eas=d
Sailfish.easnetwork=d
Sailfish.easwbxml=d
```

Add the following to the same file to have log output saved to `/var/tmp/eas.log`.
```ini
Sailfish.logfile=/var/tmp/eas.log
```

After making changes to the file you'll need to restart the daemon using `systemctl --user restart sailfish-eas` to apply them.

To make the QMF (generic email) component fully verbose, and output logs to the `/home/<user>/qmf.log` file, modify `/home/<user>/.config/QtProject/Messageserver.conf` to contain the following:
```ini
[FileLog]
Enabled=1
Path=/home/<user>/qmf.log

[LogCategories]
IMAP=1
Messaging=1
POP=1
SMTP=1

[StdStreamLog]
Enabled=0

[Syslog]
Enabled=0
```

### System service debugging

Sometimes changes to system services that are being started at boot cause unwanted results and the service crashes. Or the service crashes only on device boot. These can be resolved by checking the backtraces of such service. This set of instructions applies generally for other services as well.

This requires only `gdb` from the `sdk` repository:
```nosh
ssu ar sdk && pkcon refresh && pkcon install gdb
```

And the relevant debuginfo (and debugsource, installed as dependency) packages to have meaningful output.

In order to get the backtrace out from a service during boot create a following gdb command file (suffix does not matter):
```ini
set width 0
set height 0
set verbose off
set logging file <path_to_log_file>
set logging on
handle SIG33 pass nostop noprint
run
backtrace full
```

And add a systemd drop-in file to `/usr/lib/systemd/system/<service_name>.service.d/override.conf` with the content to override the existing service file variables:
```ini
[Service]
ExecStart=
ExecStart=/usr/bin/gdb --batch --command=<command_file> --args <copy_this_part_from_original_service_file>
Restart=no
```

`ExecStart` needs to be cleared to avoid error `Service has more than one ExecStart= setting, which is only allowed for Type=oneshot services. Refusing`. `Restart` is prevented in order to avoid overwriting the log file.

For example with ofono following can be used. Put the following (change path to `--command` if needed) and do:
```nosh
mkdir -p /usr/lib/systemd/system/ofono.service.d/
cat << EOM >/usr/lib/systemd/system/ofono.service.d/override.conf
[Service]
ExecStart=
ExecStart=/usr/bin/gdb --batch --command=/root/ofono.gdb --args /usr/sbin/ofonod -n --nobacktrace \$OFONO_ARGS \$OFONO_DEBUG
Restart=no
EOM
```

To make sure that the change is applied do:
```nosh
systemctl daemon-reload
```
And reboot the device. The log is available with the backtrace in `<path_to_log_file>` pointed in the `<command_file>`.

When there is no need for gdb anymore the `override.conf` can be removed. After removal `daemon-reload` and service restart is required for the change to be in effect.

## Restart System Services

Restart user session
```nosh
systemctl restart user@100000
```

Restart networking. Warning! Disconnects your SSH connection.
```nosh
systemctl restart connman.service
```

Restart home screen
```nosh
systemctl --user restart lipstick
```

Restart keyboard
```nosh
systemctl --user restart maliit-server
```

Restart Phone application
```nosh
systemctl --user restart voicecall-ui-prestart
```

Restart Phone middleware
```nosh
systemctl restart ofono
systemctl-user restart voicecall-manager
```

## Repository handling

All following commands require root access rights
```nosh
devel-su
```

Register the device for R&D services. This is the same as enabling it from Settings app user interface by enabling Setting | "Developer tools" | "Enable developer updates" toggle.
```nosh
ssu r
```

Check that the time is correct on the device
```nosh
ssu up
```
    
Go to RnD mode
```nosh
ssu re -r latest
```
    
Query and change RnD Flavour
```nosh
ssu fl # query
ssu fl devel|staging
```

Set to normal sales release device
```nosh
ssu domain sales
ssu release <latest release>
# set registered=false in ssu.ini
pkcon refresh
```
    
Add custom repository (credentials automatically added, if required)
```nosh
ssu ar repository-name URL
ssu updaterepos     #alternative: ssu ur
pkcon refresh
pkcon update
```
    
Manage custom repositories. Custom repositories appear in the section "Enabled repositories (user)" in the output of the command ssu lr.
```nosh
ssu rr repository-name  # remove
ssu dr repository-name  # disable
ssu er repository-name  # enable
ssu lr                  # list

ssu updaterepos
pkcon refresh
pkcon update
```

Never override global repositories such as *adaptation-common* as that will mess up your device when upgrading it. Before upgrade make sure *Enabled repositories (global)* are not listed in *Enabled repositories (user)* as follows:

```nosh
devel-su ssu lr
```

If you have *Enabled repositories (global)* listed in the *Enabled repositories (user)*, remove each of them as follows (e.g. *adaptation-common*):

```nosh
devel-su ssu rr adaptation-common
devel-su ssu up
devel-su pkcon refresh
```

## Package Handling

Privileged rights required
```nosh
devel-su -p
```

Show SW version
```nosh
version
```

Update software
```nosh
version --dup
```

Pkcon commands
```nosh
pkcon refresh   # Update repositories

pkcon search name [PACKAGE_NAME]
pkcon install [PACKAGE_NAME]
pkcon get-details [PACKAGE_NAME]
pkcon remove [PACKAGE_NAME]
pkcon update [PACKAGE_NAME]

pkcon install-local [FILE_NAME]

pkcon repo-list
pkcon repo-enable [REPO_ID]
pkcon repo-disable [REPO_ID]

pkcon       # Lists the full command syntax and options.
```

Pkmon commands
```nosh
pkmon       # Shows the download progress as a live log.
```

Zypper commands for SDK (pkcon is preferred on device)
```nosh
zypper lr # list repositories
zypper ref # update repositories
zypper update # update packages
zypper se packagename # search packages
zypper in packagename # install packages
zypper info packagename # check package information
zypper info -t pattern patternname # check pattern information
zypper verify # check dependencies
```

RPM commands
```nosh
rpm -ivh <rpm-file> # installs rpm package (verbose, print hash marks)
rpm -ivh --nodeps --force <rpm-file> # installs rpm package without checking dependencies (as you know they are ok...)
rpm -e <package> # remove package
rpm -ql <package-name> # list files in package
rpm -qlP <file> # list files in package
rpm -qf <file> # find out what package file belongs to
rpm -qpR <rpm-file> # find out package dependencies
rpm -qR <package-name> # find out package dependencies
rpm -q --changelog <package> | head # list the recent changelog items of a package
rpm -q --whatrequires <package> # find out reverse dependencies
rpm -qa | grep <string> # list all packages that have <string> in their names
rpm -qa | xargs rpm -qR | grep -b5 <package> # query all packages, check whether they depend on package
rpm -U --oldpackage --replacepkgs --replacefiles <package> # reinstall rpm package
rpm -qa | awk '{print $0" "$0}' | xargs printf "echo PACKAGE: %s && rpm -q --scripts %s\n" | sh # List RPM scripts by package
rpm -qa --queryformat '%{license}\t%{name}-%{version}-%{release}\n' | sort # List package by license.
```

Clear corrupted rpm database (as root):
```nosh
rm -rf /var/lib/rpm/__db* ; rpm --rebuilddb
```

Run packagekitd with debug output (as root):
```nosh
G_MESSAGES_DEBUG=all /usr/libexec/packagekitd --keep-environment --verbose
```

## Clearing, Importing and Exporting User Data

### Phone

Install commhistory-tool if not already installed.
```nosh
devel-su -p pkcon install libcommhistory-qt5-tools
```

Export call logs, run as user
```nosh
commhistory-tool export -calls call_logs.dat
```

Import, run as user
```nosh
commhistory-tool import call_logs.dat
```

Clear call logs, run as user
```nosh
commhistory-tool deleteall -calls
```

Add call logs data, run as user
```nosh
commhistory-tool import-json calllogs.json
```

Restart Phone application to see changes in effect.
```nosh
pkill voicecall-ui
```

### Messages

Export messages, run as user
```nosh
commhistory-tool export -groups messages.dat
```

Import, run as user
```nosh
commhistory-tool import messages.dat
```

Remove all message conversations, run as user
```nosh
commhistory-tool deleteall -groups
```

Import message data, run as user
```nosh
commhistory-tool import-json messages.json
```

Restart Messages application to see changes in effect.
```nosh
pkill jolla-messages
```

### People

Install vcardconverter if not already installed.
```nosh
devel-su -p pkcon install nemo-qml-plugin-contacts-qt5-tools
```

Import contacts from vCard
```nosh
devel-su -p vcardconverter contacts.vcf
```

Export contacts that are stored in the device internal memory to vCard
```nosh
devel-su -p vcardconverter --export contacts.vcf
```
If that doesn't write any contacts, you need to specify the collection. Obtain a list of available collections like so:
```nosh
devel-su -p contacts-tool collections
```
This will print something like the following:
```nosh
   ID: qtcontacts:org.nemomobile.contacts.sqlite::xxxxxxxx31  Name: aggregate
   ID: qtcontacts:org.nemomobile.contacts.sqlite::xxxxxxxx32  Name: local
   ID: qtcontacts:org.nemomobile.contacts.sqlite::xxxxxxxx33  Name: SIM    
```
Use the complete string starting with `qtcontacts:` as the collecion ID:
```nosh
devel-su -p vcardconverter --export local_contacts.vcf qtcontacts:org.nemomobile.contacts.sqlite::xxxxxxxx32
```

### Calendar

Install icalconverter if not already installed
```nosh
devel-su -p pkcon install nemo-qml-plugin-calendar-qt5-tools
```

Import events from iCal
```nosh
devel-su -p icalconverter import calendar.ics
```

Import events using Calendar import page (two possibilities)
```nosh
dbus-send --print-reply --type=method_call --dest=com.jolla.calendar.ui /com/jolla/calendar/ui com.jolla.calendar.ui.importFile string:$HOME/<readableDir>/calendar.ics
xdg-open calendar.ics
```
Both assume that the ICS data are actually in a directory that is visible from inside the jail the calendar application is running into, for instance `$HOME/Documents/`.

Export local calendar events to iCal
```nosh
devel-su -p icalconverter export calendar.ics
```

### Browser

Set the home page.
```nosh
dconf write /apps/sailfish-browser/settings/home_page "'http://jolla.com'"
```

### Media

Transfer content to the device
```nosh
scp *.jpg <user>@device:Pictures
scp *.mp4 <user>@device:Videos
scp *.pdf <user>@device:Documents
scp *.ogg <user>@device:Music
```

### Ambiences

Set image as the ambience.
```nosh
dbus-send --session --print-reply --dest=com.jolla.ambienced /com/jolla/ambienced com.jolla.ambienced.setAmbience string:"file://home/<user>/Pictures/image.jpg"
```

### Homescreen

Reset order of apps in Homescreen launcher.
```nosh
rm /home/<user>/.config/lipstick/applications.menu
```

### Weather

Remove weather locations
```nosh
rm /home/<user>/.local/share/sailfish-weather/weather.json
```

In some SFOS installations, the location is here:
```nosh
rm /home/<user>/.local/share/org.sailfishos/sailfish-weather/weather.json
```    
    
## Blocking Device Suspend

Install mcetool
```nosh
zypper in mce-tools
```

Disable late suspend
```nosh
mcetool -searly
```

Disable early suspend
```nosh
mcetool -sdisabled
```

Restore normal suspend policy
```nosh
mcetool -senabled
```

## Screen Brightness

Install mcetool
```nosh
zypper in mce-tools
```

Set brightness setting to maximum value
```nosh
mcetool -b100
```

Disable screen dimming when home screen or applications are open
```nosh
mcetool -Don
```

Disable screen dimming when the lock screen is open
```nosh
mcetool -tdisabled
```

Go back to normal behavior
```nosh
mcetool -Doff -tenabled
```

For problem with unusually dark display, try disabling als-based display brightness filtering
```nosh
mcetool -gdisabled
```

Reset all mce values to their defaults
```nosh
systemctl stop mce.service
rm /var/lib/mce/builtin-gconf.values
systemctl start mce.service
```

## Show Dialogs

### Alarm Dialog

Show timer alarm in 3 seconds (ticker=3).
```nosh
timedclient-qt5 -b'TITLE=button0' -e'APPLICATION=nemoalarms;TITLE=Timer;type=countdown;timeOfDay=1;triggerTime=1395217218;ticker=3'
```

Show clock alarm in 3 seconds (ticker=3).
```nosh
timedclient-qt5 -b'TITLE=button0' -e'APPLICATION=nemoalarms;TITLE=Clock;type=event;timeOfDay=772;ticker=3'
```

### Connection Dialog
```nosh
dbus-send --print-reply --type=method_call --dest=com.jolla.lipstick.ConnectionSelector / com.jolla.lipstick.ConnectionSelectorIf.openConnection string:
```

### USB Dialog

Connect cable. Make sure "Settings -\> USB -\> Default USB mode" is set to "Always ask".

### Unresponsive App Dialog

Make app unresponsive by stopping its execution.
```nosh
kill -SIGSTOP `pgrep appname` # e.g. jolla-messages
```

Continue execution by calling
```nosh
kill -SIGCONT `pgrep appname` # e.g. jolla-messages
```

### Side Loading Dialog
```nosh
xdg-open package.rpm
```

### Call Request Dialog
```nosh
xdg-open "tel://0123456789"
```

### Supplementary Service Dialog

Type [USSD code](https://en.wikipedia.org/wiki/Unstructured_Supplementary_Service_Data#Code_table) with Phone dialer, for example, `*#31#` shows the status of caller line restriction.

### Audio Warning Dialog

Change headset audio warning timeout by adding following lines to /etc/pulse/mainvolume-listening-time-notifier.conf.
```
timeout = 1
sink-list = sink.primary
mode-list = lineout
```

Then run:
```nosh
systemctl --user restart pulseaudio.service
```

Now play a song over 1 minute with a normal headset in Media Player to see a warning dialogue.

Reset too-loud volume warning.
```nosh
/usr/bin/dconf write /desktop/<user>/audiowarning true
```

Now play a song over the headset and turn the volume to maximum to see a warning dialogue.

### The Other Half Installation Dialog

Sign in to Jolla store. Attach new TOH back cover.

## Show settings

Settings (Bluetooth, Accounts, Text input, VPN, etc.) are declared on JSON files found in /usr/share/jolla-settings/entries/

You can launch Settings app in a respective settings page using the following DBus method (opens USB settings page)
```nosh
dbus-send --type=method_call --print-reply --dest=com.jolla.settings /com/jolla/settings/ui com.jolla.settings.ui.showPage string:system_settings/connectivity/usb
```

Works for JSON settings of type "page". Property "path" found in JSON file is used to identify the settings page, which the method takes as an argument.
