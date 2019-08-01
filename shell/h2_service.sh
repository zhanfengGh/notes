#! /bin/sh
#
# h2_service.sh
# Copyright (C) 2018 zhanfeng.zhang <zhanfeng.zhang.ga@gmail.com>
#
# Distributed under terms of the MIT license.
#

BASE_DIR=~/workspace/h2
JAR_FILE=${BASE_DIR}/bin/h2-1.4.197.jar


error_exit ()
{
    echo "ERROR: $1 !!"
    exit 1
}

_start() {
	[ ! -e "$JAVA_HOME/bin/java" ] && JAVA_HOME=/usr/java/default
    [ ! -e "$JAVA_HOME/bin/java" ] && JAVA_HOME=$HOME/jdk/java
    [ ! -e "$JAVA_HOME/bin/java" ] && JAVA_HOME=/usr/java
    [ ! -e "$JAVA_HOME/bin/java" ] && JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_181.jdk/Contents/Home
    [ ! -e "$JAVA_HOME/bin/java" ] && error_exit "Please set the JAVA_HOME variable in your environment, We need java(x64)!"
    export JAVA_HOME
    export JAVA="$JAVA_HOME/bin/java"

	JAVA_OPT="-server -Xms64M -Xmx64M"

	JAVA_OPT="${JAVA_OPT} -XX:+UseG1GC -XX:MaxGCPauseMillis=8"
	JAVA_OPT="${JAVA_OPT} -verbose:gc -XX:+PrintGCDetails -XX:+PrintGCDateStamps -XX:+PrintGCTimeStamps"
	JAVA_OPT="${JAVA_OPT} -XX:+PrintGCApplicationConcurrentTime -XX:+PrintGCApplicationStoppedTime"
	JAVA_OPT="${JAVA_OPT} -Xloggc:${BASE_DIR}/log/gc-$(date +%Y_%m_%d-%H_%M).log"

	JAVA_OPT="${JAVA_OPT} -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=${BASE_DIR}/log/out_of_memory.dump"

    H2_OPTIONS="-baseDir ${BASE_DIR}/baseDir/"
    H2_OPTIONS="${H2_OPTIONS} -web -webAllowOthers -webDaemon"
    H2_OPTIONS="${H2_OPTIONS} -tcp -tcpAllowOthers -tcpPassword h2_root"
    H2_OPTIONS="${H2_OPTIONS} -pg -pgAllowOthers"
    H2_OPTIONS="${H2_OPTIONS} $@"
    echo "H2_OPTIONS=${H2_OPTIONS}"

    nohup ${JAVA} ${JAVA_OPT} -cp ${JAR_FILE} org.h2.tools.Server ${H2_OPTIONS} &>${BASE_DIR}/log/nohup.out </dev/null &
}

_stop() {
	pkill -f "${JAR_FILE}"
}

case "$1" in
start)
    echo "starting h2 database..."
    shift;_start
;;
stop)
    echo "stopping h2 database..."
    _stop
;;
restart)
    _stop && _start
;;
*)
    echo "Usage: ${0} start/stop/restart"
;;
esac
