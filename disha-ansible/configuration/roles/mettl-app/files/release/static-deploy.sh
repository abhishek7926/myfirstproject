#!/bin/bash

APP=$1
CURRENT_TIME=`date +%y%m%d_%H%M%S`

GREEN_STATIC_DIR=${HOME}/${APP}/static
BLUE_STATIC_DIR=${HOME}/${APP}/${APP}-${CURRENT_TIME}

mkdir ${BLUE_STATIC_DIR}
echo "Copying the app content"
tar -xzf ${HOME}/${APP}_static.tar.gz -C ${BLUE_STATIC_DIR}

rm -f ${GREEN_STATIC_DIR}

#Creating the link to newly downloaded code
ln -s ${BLUE_STATIC_DIR} ${GREEN_STATIC_DIR}
touch ${GREEN_STATIC_DIR}/latest

source ${HOME}/release/file_functions.sh
deleteOlderFiles ${HOME}/${APP} 4
