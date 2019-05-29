#!/bin/bash
if [ "${UPDATE_ON_START}" == "true" ]; then
	if [ -f ${SERVER_DIR}/papatcher.go ]; then
    	rm ${SERVER_DIR}/papatcher.go
    fi
	if [ ! -f ${SERVER_DIR}/papatcher.go ]; then
    	echo
    	echo "-------------------------------------------------"
    	echo "-----------'Update on Start' enabled-------------"
    	echo "---Downloading new copy of file 'papatcher.go'---"
        echo "-------------------------------------------------"
		echo
		cd ${SERVER_DIR}
		wget -qO ${SERVER_DIR}/papatcher.go https://raw.githubusercontent.com/planetary-annihilation/papatcher/master/papatcher.go
	fi
	if [ -z "${PA_ACC_NAME}"]; then
		echo "---Please enter your PA account name and restart the Container---"
    	sleep infinity
	fi
	if [ -z "${PA_ACC_PWD}"]; then
		echo "---Please enter your PA account password and restart the Container---"
    	sleep infinity
	fi
else
	echo "---Checking for 'papatcher.go'---"
	if [ ! -f ${SERVER_DIR}/papatcher.go ]; then
		echo "---Downloading 'papatcher.go'---"
		cd ${SERVER_DIR}
		wget -qO ${SERVER_DIR}/papatcher.go https://raw.githubusercontent.com/planetary-annihilation/papatcher/master/papatcher.go
	fi
	if [ -z "${PA_ACC_NAME}"]; then
		echo "---Please enter your PA account name and restart the Container---"
    	sleep infinity
	fi
	if [ -z "${PA_ACC_PWD}"]; then
		echo "---Please enter your PA account password and restart the Container---"
    	sleep infinity
	fi
fi

if [ "${GAME_STREAM}" == "stable" ]; then
	if [ ! -d ${SERVER_DIR}/stable ]; then
		echo "---Installing PA '${GAME_STREAM}'---"
    	(echo "${PA_ACC_NAME}"; sleep 1s; echo ${PA_ACC_PWD}) | go run papatcher.go -stream=${GAME_STREAM} -dir=${SERVER_DIR}
    fi
    if [ "${UPDATE_ON_START}" == "true" ]; then
    	echo
    	echo "---------------------------------------------"
    	echo "---------'Update on Start' enabled-----------"
    	echo "---Checking for PA '${GAME_STREAM}' update---"
        echo "---------------------------------------------"
        echo
    	(echo "${PA_ACC_NAME}"; sleep 1s; echo ${PA_ACC_PWD}) | go run papatcher.go -stream=${GAME_STREAM} -dir=${SERVER_DIR}
    fi
elif [ "${GAME_STREAM}" == "PTE" ]; then
	if [ ! -d ${SERVER_DIR}/PTE ]; then
		echo "---Installing PA '${GAME_STREAM}'---"
    	(echo "${PA_ACC_NAME}"; sleep 1s; echo ${PA_ACC_PWD}) | go run papatcher.go -stream=${GAME_STREAM} -dir=${SERVER_DIR}
    fi
    if [ "${UPDATE_ON_START}" == "true" ]; then
    	echo
    	echo "---------------------------------------------"
    	echo "---------'Update on Start' enabled-----------"
    	echo "---Checking for PA '${GAME_STREAM}' update---"
        echo "---------------------------------------------"
        echo
    	(echo "${PA_ACC_NAME}"; sleep 1s; echo ${PA_ACC_PWD}) | go run papatcher.go -stream=${GAME_STREAM} -dir=${SERVER_DIR}
    fi
else
	echo
    echo "--------------------------------------------"
    echo "----Something went wrong! Please enter------"
    echo "--------the prefered 'Game Stream'!---------"
    echo "-----------Available options are:'----------"
    echo "-----'stable' and 'PTE' (without quotes)----"
    echo "----------and restart the Container---------"
    echo "--------------------------------------------"
    echo
    sleep infinity
fi

echo "---Preparing Server---"
chmod -R 770 ${DATA_DIR}

echo "---Starting Server---"
if [ "${GAME_STREAM}" == "stable" ]; then
	cd ${SERVER_DIR}/stable
	${SERVER_DIR}/stable/server --game-mode ${GAME_MODE} --server-name "${SERVER_NAME}" --mt-enabled --max-players ${MAX_PLAYERS} --headless --allow-lan --port ${GAME_PORT} --password ${SERVER_PASSWORD} ${GAME_PARAMS}
fi
if [ "${GAME_STREAM}" == "PTE" ]; then
	cd ${SERVER_DIR}/PTE
	${SERVER_DIR}/PTE/server --game-mode ${GAME_MODE} --server-name "${SERVER_NAME}" --mt-enabled --max-players ${MAX_PLAYERS} --headless --allow-lan --port ${GAME_PORT} --password ${SERVER_PASSWORD} ${GAME_PARAMS}
fi