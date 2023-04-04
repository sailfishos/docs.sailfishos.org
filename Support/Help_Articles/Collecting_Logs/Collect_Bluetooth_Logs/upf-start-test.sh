#!/bin/sh
#
# upf-start-test.sh -- start logging BT 
#
# usage: upf-start-test.sh test-session-name


panic()
{
    echo "error: $*" 1>&2
    exit 1
}

log()
{
    echo "$*"
}

debug_restart_daemon()
{
    DAEMON=$1
    log "Restarting ${DAEMON}"
    if [ "${DAEMON}" = "obex-client" ]; then
	killall ${DAEMON}
	sleep 1
	su -c "/usr/libexec/obex-client -d" defaultuser &
	echo "${DAEMON} restarted with debugging."
    elif [ "${DAEMON}" = "obexd" ]; then
	OUTPUT=$2
	killall ${DAEMON}
	sleep 1
	su -c "/usr/libexec/obexd-wrapper" defaultuser >${OUTPUT} 2>&1 &
	sleep 2
	killall -USR2 ${DAEMON} || panic "Cannot enable debug for ${DAEMON}"
	echo "${DAEMON} restarted with debugging."
    else
	SERVICE=$2
	systemctl restart ${SERVICE} || panic "Cannot restart ${DAEMON}"
        # cut some slack before enabling debug
	sleep 2
	killall -USR2 ${DAEMON} || panic "Cannot enable debug for ${DAEMON}"
	echo "${DAEMON} restarted with debugging."
    fi
}

start_hcidump()
{
    DIR=$1
    OUTPUT=$2
    hcidump -w ${DIR}/hcidump.pcap >${OUTPUT} 2>&1 &
    HCIDUMPPID=$!
    echo ${HCIDUMPPID} > ${DIR}/hcidump.pid || echo "Cannot record hcidump pid"
    sleep 1
}

PREFIX=/var/log/upf
DATETIME=`date +%Y-%m-%d_%H:%M:%S`

NAME=$1
if [ -z ${NAME} ]; then
    echo "usage: $0 test-session-name"
    exit 1
fi

    
DATADIR=${PREFIX}/session-${NAME}

mkdir -p ${DATADIR} || panic "Cannot create directory ${DATADIR}"
echo ${DATETIME} > ${DATADIR}/datetime || panic "Cannot record start timestamp"

start_hcidump ${DATADIR} ${DATADIR}/hcidump.output
debug_restart_daemon bluetoothd bluetooth.service
debug_restart_daemon obexd ${DATADIR}/obexd.output
debug_restart_daemon obex-client


# Crude way to re-register user agents for the new daemons
sleep 3
echo ""
echo "The display will turn black for a moment..."
sleep 3
killall lipstick

echo "Test startup done, directory ${DATADIR}"

exit 0
