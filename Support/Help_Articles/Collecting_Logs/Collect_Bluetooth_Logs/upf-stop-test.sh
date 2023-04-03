#!/bin/sh
#
# upf-stop-test.sh -- stop logging BT 
#
# usage: upf-stop-test.sh test-session-name


panic()
{
    echo "error: $*" 1>&2
    exit 1
}

error()
{
    echo "error: $*"
}

log()
{
    echo "$*"
}

stop_daemon()
{
    DAEMON=$1
    if [ "${DAEMON}" = "obex-client" -o "${DAEMON}" = "obexd" ]; then
	killall "${DAEMON}" || error "Cannot stop ${DAEMON}"
    else
	SERVICE=$2
	log "Stopping ${DAEMON}"
	systemctl stop ${SERVICE} || error "Cannot stop ${DAEMON}"
    fi
}

stop_hcidump()
{
    DIR=$1
    HCIDUMPPID=`cat ${DIR}/hcidump.pid` || error "Cannot read hcidump pid"
    if [ ! -z "${HCIDUMPPID}" ]; then
	kill ${HCIDUMPPID} || error "Cannot kill hcidump"
    fi
}

PREFIX=/var/log/upf
NAME=$1

if [ -z ${NAME} ]; then
    echo "usage: $0 test-session-name"
    exit 1
fi
DATADIR=${PREFIX}/session-${NAME}

if [ ! -d ${DATADIR} ]; then
    panic "Directory ${DATADIR} does not exist."
fi

TIME=`cat ${DATADIR}/datetime | cut -f 2 -d _` || error "Cannot read start timestamp"
if [ ! -z "${TIME}" ]; then
    journalctl --since=${TIME} > ${DATADIR}/journal.log || error "Cannot record journal"
else
    journalctl > ${DATADIR}/journal.log || error "Cannot record journal"
fi

stop_daemon obex-client
stop_daemon obexd
stop_daemon bluetoothd bluetooth.service
stop_hcidump ${DATADIR}

tar -cf $NAME.tar $DATADIR  2> /dev/null
chown 100000:100000 $NAME.tar   ## handles both nemo and defaultuser
echo "" 
HOME=$(pwd)
echo "---------------------------------------------"
echo "Get the file '$NAME.tar'"
echo "from $HOME"
echo "---------------------------------------------"
echo ""
exit 0
