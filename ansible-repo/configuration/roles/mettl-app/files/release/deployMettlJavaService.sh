#!/bin/bash

release_num=$1
component=$2
echo "Deploying $release_num"

# turn on echo 
set -x verbose

# Set Time Zone
TZ='Asia/Kolkata'; 
export TZ

artifact_url=http://nexus.mettl.com:8081/nexus/content/repositories/releases/com/mettl/${component}/${release_num}/${component}-${release_num}-assembly.jar
echo "will download from $artifact_url"

# Service base 
SERVICE_BASE="/home/mettl/volume1/serviceAssesmblies/${component}/current-installation"
echo "Deploying ${component} to ${SERVICE_BASE} ........"

INSTALLERS_BASE=/home/mettl/volume1/serviceAssesmblies/${component}/installers
CURRENT_TIME=`date +%y%m%d_%H%M%S`

#Directory where we will be copying the web archive
DOWNLOAD_DIR=${INSTALLERS_BASE}/${CURRENT_TIME} 

# Moved to installation directory
mkdir -p  ${DOWNLOAD_DIR}
echo "Created ${DOWNLOAD_DIR} ...."

cd ${DOWNLOAD_DIR}
# pull latest release from nexus
wget ${artifact_url} --user=deployment --password=deployment123 --auth-no-challenge

# explode the war
jar -xf ${component}-${release_num}-assembly.jar

#Move component web archive to installer directory 
mv ${component}-${release_num}-assembly.jar ${INSTALLERS_BASE}/${component}_${release_num}-${CURRENT_TIME}.jar

#Removing the earlier link
rm -rf ${SERVICE_BASE}

#Creating the link to newly downloaded code
ln -s ${DOWNLOAD_DIR} ${SERVICE_BASE}

source ${HOME}/release/file_functions.sh
deleteOlderFiles ${INSTALLERS_BASE} 10
