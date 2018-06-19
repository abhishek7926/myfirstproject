#!/bin/bash

release_num=$1
component="accenture-app-web"
echo "Deploying $release_num"

# turn on echo 
set -x verbose

# Set Time Zone
TZ='Asia/Kolkata'; 
export TZ

artifact_url=http://nexus.mettl.com:8081/nexus/content/repositories/releases/com/mettl/integration/${component}/${release_num}/${component}-${release_num}.war
echo "will download from $artifact_url"

# web app base 
WEBAPP_BASE="/home/mettl/volume1/${component}/www"
echo "Deploying ${component} to ${WEBAPP_BASE} ........"

INSTALLERS_BASE=/home/mettl/volume1/${component}/installers
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
jar -xf ${component}-${release_num}.war

#Move component web archive to installer directory 
mv ${component}-${release_num}.war ${INSTALLERS_BASE}/${component}_${release_num}-${CURRENT_TIME}.war

#Removing the earlier link
rm -f ${WEBAPP_BASE}

#Creating the link to newly downloaded code
ln -s ${DOWNLOAD_DIR} ${WEBAPP_BASE}

cd ${INSTALLERS_BASE}
source ${HOME}/release/file_functions.sh
deleteOlderFiles ${INSTALLERS_BASE} 10

