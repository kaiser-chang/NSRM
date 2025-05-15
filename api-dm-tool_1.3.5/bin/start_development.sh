#!/bin/bash
PROFILE=development
SERVER_PORT=7091
MIN_MEM=512m
MAX_MEM=1024m
if [ "$1" != "" ] ; then
    SERVER_PORT=$1
fi
if [ "$2" != "" ] ; then
    MIN_MEM=$2
fi
if [ "$3" != "" ] ; then
    MAX_MEM=$3
fi

P_NAME="api_dm_tool_application_${PROFILE}_${SERVER_PORT}"
CURRENT_JAR=lynxlib-api-dm-tool-application
UPDATE_JAR=lynxlib-api-dm-tool-application-update
BACKUP_JAR=lynxlib-api-dm-tool-application-backup
CURRENT_PID=$(ps -ef|grep -w D$P_NAME |grep -v grep|awk '{print $2}')

echo "${PROFILE} mode"

if [ -z $CURRENT_PID ] ; then
    echo "${P_NAME} is not running"
else
    echo "Kill ${P_NAME} ${CURRENT_PID} process"
	kill -9 $CURRENT_PID
	sleep 5
fi

echo "Checking update version..."

if [ -e "${UPDATE_JAR}.jar" ] ; then

	echo "${UPDATE_JAR}.jar was found."
	
	mv -f  "${CURRENT_JAR}.jar" "${BACKUP_JAR}.jar"
	echo "${CURRENT_JAR}.jar  -> ${BACKUP_JAR}.jar"
	
	mv -f  "${UPDATE_JAR}.jar"  "${CURRENT_JAR}.jar"
	echo "${UPDATE_JAR}.jar -> ${CURRENT_JAR}.jar"
else
	echo "The current jar is the latest version."
fi

echo "Application port is ${SERVER_PORT}."
cp -f "${CURRENT_JAR}.jar" "${CURRENT_JAR}-${PROFILE}-${SERVER_PORT}.jar"
echo "${CURRENT_JAR}.jar -> ${CURRENT_JAR}-${PROFILE}-${SERVER_PORT}.jar"

echo "${P_NAME} is being starting!"
echo "Memory -Xms${MIN_MEM} -Xmx${MAX_MEM}"
nohup java -D$P_NAME -Dfile.encoding=UTF-8 -jar -Xms${MIN_MEM} -Xmx${MAX_MEM} "./${CURRENT_JAR}-${PROFILE}-${SERVER_PORT}.jar" --spring.profiles.active=$PROFILE --server.port=$SERVER_PORT 1>/dev/null 2>&1 &