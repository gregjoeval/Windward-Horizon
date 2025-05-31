#!/bin/bash

SERVER_REMOTE_FILE=http://www.tasharen.com/wh/WHServer.zip
SERVER_TEMP_FILE=/tmp/WHServer.zip
SERVER_LOCAL_FILE=/windward-horizon/WHServer.zip

echo "Downloading latest dedicated server"

curl -s -o ${SERVER_TEMP_FILE} ${SERVER_REMOTE_FILE}

if [ -f ${SERVER_LOCAL_FILE} ]; then
	echo "Checking local dedicated server is the latest version..."
	SERVER_LOCAL_MD5=`md5sum ${SERVER_LOCAL_FILE} | cut -d' ' -f1`
	SERVER_TEMP_MD5=`md5sum ${SERVER_TEMP_FILE} | cut -d' ' -f1`
	if ! [ "${SERVER_LOCAL_MD5}" = "${SERVER_TEMP_MD5}" ]; then
		echo "Newer version available - Upgrading"
		mv -f ${SERVER_TEMP_FILE} ${SERVER_LOCAL_FILE}
		unzip ${SERVER_LOCAL_FILE} -d /windward-horizon/
	fi
else
	echo "Newer version available - Upgrading"
	mv ${SERVER_TEMP_FILE} ${SERVER_LOCAL_FILE}
	unzip ${SERVER_LOCAL_FILE} -d /windward-horizon/
fi

if [ "${WINDWARD_SERVER_PUBLIC}" = "1" ]; then
	WINDWARD_SERVER_IS_PUBLIC="-public"
fi

if [ "${WINDWARD_SERVER_ADMIN}" ]; then
	mkdir -p /windward-horizon/Windward/ServerConfig
	if [ ! -f /windward-horizon/Windward/ServerConfig/admin.txt ]; then
		echo "${WINDWARD_SERVER_ADMIN}" > /windward-horizon/ServerConfig/admin.txt
	fi
fi

cd /windward-horizon

mono WHServer.exe -service -name "${WINDWARD_SERVER_NAME}" -port ${WINDWARD_SERVER_PORT} -world "${WINDWARD_SERVER_WORLD}" ${WINDWARD_SERVER_IS_PUBLIC}
