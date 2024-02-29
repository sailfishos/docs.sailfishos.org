#!/bin/bash

VERSION=4

# collect-logs.sh
#
# Collecting logs from a SAILFISH OS device
# This is a shotgun approach, i.e., we collect versatile information covering the usual reasons for problems.
# No passwords are extracted.
#
# Jolla Oy
# 2022-12-12
#
###############################################################################
#
# Check if this script is run as root. If not force to root now.
if [ $(id -u) -ne 0 ]; then
   exec devel-su bash $0
fi
echo ""
echo "Collecting some logs from a Sailfish OS device"
echo "This is 'collect-logs.sh' version '$VERSION'"
echo ""
echo "This script is compatible with OS release 4.4.0 and later"
echo ""
sleep 3s
#
# Make a temporary directory to collect the files.
# This directory will be automatically deleted when the script runs to end.
# At the end of this script, a tar container is created to the home directory to keep the logs.
#
echo ""
TMPDIR=$(mktemp -d)
#
echo "1. HW and SW" 
echo "- device details"
echo "- software release details"
cp /etc/hw-release $TMPDIR/hw-release.txt
cp /etc/os-release $TMPDIR/sw-release.txt
sleep 0.5s
echo ""
#
echo "2. RAM usage by top processes" 
echo "- free RAM in the system"
echo "- top 20 processes by RAM usage"
free -m > $TMPDIR/free-m-ram.txt
ps aux | awk '{print $2, $4, $11}' | sort -k2rn | head -n 20 > $TMPDIR/ps-top-20-proc-by-ram-usage.txt
ps > $TMPDIR/ps.txt
sleep 0.5s
echo ""
#
echo "3. Storage usage" 
echo "- biggest folders in device storage in root partition"
echo "- biggest folders in device storage in home partition"
du -a -x / | awk '{if($1 > 102400) print int($1/1024) "MB" " " $2 }' | sort -nr > $TMPDIR/folders-gt-100MB-in-root.txt
du -a -x /home | awk '{if($1 > 102400) print int($1/1024) "MB" " " $2 }' | sort -nr > $TMPDIR/folders-gt-100MB-in-home.txt
df > "$TMPDIR/df.txt"
echo ""
#
echo "4. Ifconfig"
echo "- interface configurations: currently active"
echo "- interface configurations: all"
ifconfig -v > $TMPDIR/ifconfig-active.txt
ifconfig -a -v > $TMPDIR/ifconfig-all.txt
echo ""
#
echo "5. Journal" 
echo "- journal log (starting from the previous bootup)"
journalctl -a --no-pager > $TMPDIR/journal.txt
echo ""
#
echo "6. Repositories and SSU status"
echo "- ssu repositories"
ssu lr > $TMPDIR/ssu-lr.txt
echo "- ssu status"
ssu s > $TMPDIR/ssu-s.txt
echo ""
#
echo "7. Binary code packages"
echo "- all rpm's"
rpm -qa | sort > $TMPDIR/rpm-all.txt
echo "- pkcon: all Sailfish packages (installed and available)"
pkcon get-packages > $TMPDIR/pkcon-all.txt
echo ""
#
echo "8. Traces from OS updates"
echo "- systemboot.log"
cp /var/log/systemboot.log $TMPDIR/systemboot.txt
echo "- systemupdate.log"
cp /var/log/systemupdate.log $TMPDIR/systemupdate.txt 2> /dev/null
echo "- history"
cp /var/log/zypp/history $TMPDIR/history.txt
#
echo ""
echo "9. Android logs"
ALIENDALVIK=$(rpm -qa | grep aliendalvik)
if [ "$ALIENDALVIK" = "" ]; then
    echo "Android AppSupport not installed on this device. Skipping Android logs."
else
    MODELSTR=$(ssu s | grep model)
    # Model and release specific commands:
    RELEASESTR=$(cat /etc/os-release | grep VERSION_ID= )
        
    LOGCATCMD=""
    if [ "${MODELSTR:14:12}" = "Jolla (SbJ /" ] || [ "${MODELSTR:14:12}" = "Jolla Table" ]; then 
        LOGCATCMD="/opt/alien/system/bin/logcat -d -v time"
    fi
	if [ "${MODELSTR:14:12}" = "Jolla C (l50" ] || [ "${MODELSTR:14:10}" = "Xperia X (" ]; then 
        LOGCATCMD="chroot /opt/alien  /system/bin/logcat -d -v time"
    fi
    
    # The next block covers Xperia 10, 10 II, 10 III, and XA2
    if [ "${MODELSTR:14:10}" = "Xperia 10 " ] || [ "${MODELSTR:14:10}" = "Xperia XA2" ]; then 
        # Longer command if release is 4.5. or later
        LOGCATCMD="appsupport-attach /system/bin/logcat -d"
        if [ "${RELEASESTR:11:5}" = "4.4.0" ]; then
            LOGCATCMD="lxc-attach -q -n aliendalvik -- /system/bin/logcat -d"       
        fi
    fi

    # Did we catch any Android logs?
    if [ "$LOGCATCMD" != "" ]; then
	echo "- logcat log"
        echo "- status of Android AppSupport"
        $LOGCATCMD > $TMPDIR/android-logcat.txt
	systemctl status aliendalvik.service > $TMPDIR/aliendalvik-status.txt
    else
        echo "Android logcat logs were not collected from this device".
    fi
fi
#
chown 100000:100000 $TMPDIR/*.txt   ## handles both nemo and defaultuser
#
echo ""
echo "Done. All logs collected."
DATENOW=$(date +"%Y-%m-%d")
TIMENOW=$(date +"%H%M")
THERESULT="basic-logs-$DATENOW-$TIMENOW.tar"
#
tar -cf $THERESULT $TMPDIR/*.*  2> /dev/null
chown 100000:100000 $THERESULT   ## handles both nemo and defaultuser
echo "" 
ITISHERE=$(pwd)
echo "---------------------------------------------"
echo "Get the file '$THERESULT'"
echo "from $ITISHERE."
echo "---------------------------------------------"
echo ""










