#!/bin/bash
PROFILE=production
SERVER_PORT1=7093
if [ "$1" != "" ] ; then
    SERVER_PORT1=$1
fi
SERVER_PORT2=7094
if [ "$2" != "" ] ; then
    SERVER_PORT2=$2
fi

P_NAME="api_dm_tool_application_${PROFILE}_${SERVER_PORT1}"
CURRENT_PID=$(ps -ef|grep -w D$P_NAME |grep -v grep|awk '{print $2}')

if [ -z $CURRENT_PID ] ; then
    echo "$P_NAME is not running"
else
    echo "Kill $P_NAME $CURRENT_PID process"
	kill -9 $CURRENT_PID
	sleep 5
fi

P_NAME="api_dm_tool_application_${PROFILE}_${SERVER_PORT2}"
CURRENT_PID=$(ps -ef|grep -w D$P_NAME |grep -v grep|awk '{print $2}')

if [ -z $CURRENT_PID ] ; then
    echo "$P_NAME is not running"
else
    echo "Kill $P_NAME $CURRENT_PID process"
	kill -9 $CURRENT_PID
	sleep 5
fi
