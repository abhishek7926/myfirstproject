#!/bin/bash

# Check if Release # is specified
if [ $# -eq 0 ]
  then
    echo "Version Number to Deploy is not supplied"
    exit 0;
fi
component=$2
release_num=$1
echo "Deploying $release_num"

# turn on echo
set -x verbose

# Set Time Zone
TZ='Asia/Kolkata';
export TZ

artifact_url=http://nexus.mettl.com:8081/nexus/content/repositories/releases/com/mettl/$component/$release_num/$component-$release_num-$component.zip
echo "will download from $artifact_url"


# web app base
APP_BASE=/home/mettl/volume1/serviceAssesmblies/$component/current-installation
echo "Deploying Scheduler to $APP_BASE ........"


# Make Installation directory (where the war will be downloaded)
CURRENT_TIME=`date +%y%m%d_%H%M%S`
INSTALLERS_BASE=/home/mettl/volume1/serviceAssesmblies/$component/installers
BACKUP_BASE=/home/mettl/volume1/serviceAssesmblies/$component/backup
DOWNLOAD_DIR=$INSTALLERS_BASE/$CURRENT_TIME
echo "Download Direcotry $DOWNLOAD_DIR"
echo "Backup Base $BACKUP_BASE"
echo "Installer base $INSTALLERS_BASE"
echo "CURRENT_TIME $CURRENT_TIME"

# change directory to tomcat webapps
mkdir -p $DOWNLOAD_DIR

echo "Created $DOWNLOAD_DIR ...."


EXISTING_INSTALLATION_TIME=`cat $APP_BASE/installedOn.txt`
if [ -z "$EXISTING_INSTALLATION_TIME" ]; then
    EXISTING_INSTALLATION_TIME="BackedUpOn_$CURRENT_TIME";
fi

# The directory where the existing app will be moved to
BACKUP_DIR=$BACKUP_BASE/$component_$EXISTING_INSTALLATION_TIME
mkdir -p $BACKUP_DIR
echo "Back up directory created : $BACKUP_DIR"


# switch to installer dir
cd $DOWNLOAD_DIR

# pull latest release from jenkins
wget ${artifact_url} --user=deployment --password=deployment123 --auth-no-challenge
mv $component-$release_num-$component.zip $component.zip

# explode the war
unzip $component.zip

echo $CURRENT_TIME >> $DOWNLOAD_DIR/installedOn.txt
#Removing the earlier link
rm -rf ${APP_BASE}

ln -s ${DOWNLOAD_DIR} ${APP_BASE}

source ${HOME}/release/file_functions.sh
deleteOlderFiles ${INSTALLERS_BASE} 10
