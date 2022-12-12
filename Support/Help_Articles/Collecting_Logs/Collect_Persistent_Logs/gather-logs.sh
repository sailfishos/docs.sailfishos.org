#!/bin/bash

VERSION=3
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

    rpm -qa > "$GATHER_LOGS_FULL/installed-packages"

    ssu lr > "$GATHER_LOGS_FULL/ssu-lr"

    df > "$GATHER_LOGS_FULL/df"

    mount > "$GATHER_LOGS_FULL/mount"

    ps > "$GATHER_LOGS_FULL/ps"

    ls -l /dev > "$GATHER_LOGS_FULL/ls-dev"
    ls -l /dev/snd > "$GATHER_LOGS_FULL/ls-dev-snd"
    ls -l /etc > "$GATHER_LOGS_FULL/ls-etc"

    # Restore original state
    copy_from_backup /etc/systemd/journald.conf
    copy_from_backup /etc/sysconfig/pulseaudio
    rm -f /etc/sysconfig/ohmd.debug
    copy_from_backup /etc/sysconfig/ohmd.debug
    rm -f /etc/tracing/bluez/bluez.tracing
    copy_from_backup /etc/tracing/bluez/bluez.tracing
    rm -f /var/lib/environment/ofono/gather_logs.conf
    copy_from_backup /var/lib/environment/ofono/gather_logs.conf

    LOG_PACKAGE="sailfish_logs_$(date +%Y.%m.%d-%H.%M.%S).tar.bz2"
    tar cjf "$LOG_PACKAGE" "$GATHER_LOGS_DIR" -C /
    rm -r -f "$GATHER_LOGS_FULL"
    echo "Logs gathered."
    echo "Contents of the package: full system log (verbose pulseaudio, ohmd, bluetoothd, ofono), logcat, installed packages, ssu lr output, df output, mount output, ps output, ls of /etc /dev /dev/snd, /etc/hw-release, /etc/sailfish-release /etc/passwd (this file doesn't contain actual passwords) /etc/group"
    echo ""
    echo "Please submit $LOG_PACKAGE for investigation, thank you!"
fi