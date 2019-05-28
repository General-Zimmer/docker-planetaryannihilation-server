#!/bin/bash
echo "---sleep---"
sleep infinity

wget -qO papatcher.go https://raw.githubusercontent.com/planetary-annihilation/papatcher/master/papatcher.go

(echo "${PA_ACC_NAME}"; sleep 1s; echo ${PA_ACC_PWD}) | go run papatcher.go -stream=${GAME_STREAM} -dir=${SERVER_DIR}


./server --allow-lan --game-mode PAExpansion1:lobby --server-name "chipsServer" --mt-enabled --max-players 12 --headless

echo "---Preparing Server---"

chmod -R 770 ${DATA_DIR}


echo "---Starting Server---"
cd ${SERVER_DIR}
${SERVER_DIR}/ ${GAME_PARAMS}