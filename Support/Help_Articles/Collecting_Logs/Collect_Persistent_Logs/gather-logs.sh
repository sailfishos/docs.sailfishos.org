#!/bin/bash

VERSION=5
GATHER_LOGS_DIR="_gather_logs_tmp"
GATHER_LOGS_FULL="/$GATHER_LOGS_DIR"

if [ $(id -u) != 0 ]; then
    echo "This script needs to be run as root."
    exec devel-su -c bash "$0"
fi

copy_to_backup() {
    if [ -e "$1" ]; then
        mkdir -p "$GATHER_LOGS_FULL/backup"
        cp "$1" "$GATHER_LOGS_FULL/backup"
    fi
}

copy_from_backup() {
    local f="$(basename $1)"
    if [ -e "$GATHER_LOGS_FULL/backup/$f" ]; then
        cp "$GATHER_LOGS_FULL/backup/$f" "$1"
    fi
}

echo "$(basename $0) version $VERSION"

if [ ! -d "$GATHER_LOGS_FULL" ]; then
    echo "Preparing for logging..."

    # Disable rate limiter in journal
    copy_to_backup /etc/systemd/journald.conf
    sed -i 's/.*Storage=.*/Storage=persistent/' /etc/systemd/journald.conf
    sed -i 's/.*SystemMaxUse=.*/SystemMaxUse=50M/' /etc/systemd/journald.conf
    sed -i 's/.*RateLimitBurst.*/RateLimitBurst=0/' /etc/systemd/journald.conf
    sed -i 's/.*RateLimitInterval=.*/RateLimitInterval=0/g' /etc/systemd/journald.conf
    sed -i 's/^RuntimeMaxUse/#RuntimeMaxUse/g' /etc/systemd/journald.conf

    # Enable verbose logging for PulseAudio
    copy_to_backup /etc/sysconfig/pulseaudio
    sed -i -e 's/\(CONFIG=".*\)"/\1 -vvvvv"/' /etc/sysconfig/pulseaudio

    # Enable verbose logging for OHM
    copy_to_backup /etc/sysconfig/ohmd.debug
    echo "DEBUG_FLAGS='--verbose=all --trace=\"* format [%C:%L] ; * enabled;* target stdout;*.*=all\"'" > /etc/sysconfig/ohmd.debug

    # Enable verbose logging for BlueZ
    copy_to_backup /etc/tracing/bluez/bluez.tracing
    mkdir -p /etc/tracing/bluez
    echo -e "TRACING=-d\nMGMT_DEBUG=1" > /etc/tracing/bluez/bluez.tracing

    # Enable verbose logging for oFono
    copy_to_backup /var/lib/environment/ofono/gather_logs.conf
    mkdir -p /var/lib/environment/ofono
    echo "OFONO_DEBUG=-d" > /var/lib/environment/ofono/gather_logs.conf

    if [ -d /etc/appsupport.conf.d ]; then
        # Enable AppSupport crash logger
        copy_to_backup /etc/appsupport.conf.d/99-gather-logs-crash-logger.conf
        cat >/etc/appsupport.conf.d/99-gather-logs-crash-logger.conf <<EOF
[Features]
CrashLoggerEnabled=true
EOF

        # Enable verbose logging for alienaudioservice
        copy_to_backup /etc/sysconfig/alienaudioservice.verbose
        echo "RUN_FLAGS=-v" > /etc/sysconfig/alienaudioservice.verbose
    fi

    sync

    echo "System prepared for logging."
    echo "Please restart your device, run it until the issue is reproduced, then re-run this script."
else
    echo "Gathering logs..."

    echo "$VERSION" > "$GATHER_LOGS_FULL/gather_logs_version"

    journalctl -b > "$GATHER_LOGS_FULL/journal"
    /system/bin/logcat -d -f "$GATHER_LOGS_FULL/logcat"

    mkdir -p "$GATHER_LOGS_FULL/etc"
    for f in /etc/hw-release /etc/sailfish-release /etc/passwd /etc/group; do
        cp $f "$GATHER_LOGS_FULL/etc"
    done

    rpm -qa | sort > "$GATHER_LOGS_FULL/installed-packages"

    ssu lr > "$GATHER_LOGS_FULL/ssu-lr"

    df > "$GATHER_LOGS_FULL/df"

    mount > "$GATHER_LOGS_FULL/mount"

    ps > "$GATHER_LOGS_FULL/ps"

    ls -l -n -R /dev > "$GATHER_LOGS_FULL/ls-dev"
    ls -l -n -R /etc > "$GATHER_LOGS_FULL/ls-etc"

    APPSUPPORT_LOGS=0
    # AppSupport
    APPSUPPORT_STATE="$(systemctl is-active aliendalvik)"
    mkdir -p $GATHER_LOGS_FULL/appsupport
    echo "state: $APPSUPPORT_STATE" > $GATHER_LOGS_FULL/appsupport/is-active

    if [ "$APPSUPPORT_STATE" = "active" ] || [ "$APPSUPPORT_STATE" = "activating" ]; then
        APPSUPPORT_LOGS=1
        /usr/sbin/appsupport-attach /bin/logcat -d '*:V' > $GATHER_LOGS_FULL/appsupport/logcat.log
        /usr/sbin/appsupport-attach /bin/dumpsys > $GATHER_LOGS_FULL/appsupport/dumpsys.log
    fi

    if [ -d /tmp/appsupport ]; then
        APPSUPPORT_LOGS=1
        mkdir -p $GATHER_LOGS_FULL/appsupport
        cp -a /tmp/appsupport $GATHER_LOGS_FULL/appsupport
    fi

    APPSUPPORT_USER=
    if [ -f /tmp/appsupport/aliendalvik/alien.user ]; then
        APPSUPPORT_USER="$(cat /tmp/appsupport/aliendalvik/alien.user)"
    fi
    if [ -z "$APPSUPPORT_USER" ]; then
        APPSUPPORT_USER="defaultuser"
    fi

    if [ -d /home/$APPSUPPORT_USER/android_storage/Android ]; then
        APPSUPPORT_LOGS=1
        mkdir -p $GATHER_LOGS_FULL/appsupport
        ls -l -n -R /home/$APPSUPPORT_USER/android_storage/Android > $GATHER_LOGS_FULL/appsupport/ls-android_storage
    fi

    if [ -d /home/.android ]; then
        APPSUPPORT_LOGS=1
        mkdir -p $GATHER_LOGS_FULL/appsupport
        ls -l -n -R /home/.android > $GATHER_LOGS_FULL/appsupport/ls-dot-android
    fi

    # Restore original state
    copy_from_backup /etc/systemd/journald.conf
    copy_from_backup /etc/sysconfig/pulseaudio
    rm -f /etc/sysconfig/ohmd.debug
    copy_from_backup /etc/sysconfig/ohmd.debug
    rm -f /etc/tracing/bluez/bluez.tracing
    copy_from_backup /etc/tracing/bluez/bluez.tracing
    rm -f /var/lib/environment/ofono/gather_logs.conf
    copy_from_backup /var/lib/environment/ofono/gather_logs.conf
    rm -f /etc/sysconfig/alienaudioservice.verbose
    copy_from_backup /etc/sysconfig/alienaudioservice.verbose
    rm -f  /etc/appsupport.conf.d/99-gather-logs-crash-logger.conf
    copy_from_backup /etc/appsupport.conf.d/99-gather-logs-crash-logger.conf

    LOG_PACKAGE="sailfish_logs_$(date +%Y.%m.%d-%H.%M.%S).tar.bz2"
    tar cjf "$LOG_PACKAGE" "$GATHER_LOGS_DIR" -C /
    rm -r -f "$GATHER_LOGS_FULL"
    echo "Logs gathered."
    echo "Contents of the package: full system log (verbose pulseaudio, ohmd, bluetoothd, ofono), logcat, installed packages, ssu lr output, df output, mount output, ps output, ls of /etc /dev /dev/snd, /etc/hw-release, /etc/sailfish-release /etc/passwd (this file doesn't contain actual passwords) /etc/group"
    if [ $APPSUPPORT_LOGS -eq 1 ]; then
        echo "    AppSupport listings of Android files and file permissions, logcat, dumpsys and possible crashlogs"
    fi
    echo ""
    echo "Please submit $LOG_PACKAGE for investigation, thank you!"
fi
