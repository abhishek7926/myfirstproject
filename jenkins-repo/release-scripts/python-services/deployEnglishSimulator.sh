#!/bin/bash

# Check if Release # is specified
if [ $# -eq 0 ]
  then
    echo "Version Number to Deploy is not supplied"
    exit 0;
fi

release_num=$1
echo "Deploying $release_num"

#: turn on echo 
set -x verbose

# Set Time Zone
TZ='Asia/Kolkata';
export TZ

artifact_url=http://nexus.mettl.com:8081/nexus/content/repositories/releases/com/mettl/englishSimulator/$release_num/englishSimulator-$release_num-englishSimulator.zip
echo "will download from $artifact_url"
# web app base 
APP_BASE=/home/mettl/volume1/serviceAssesmblies/englishSimulator/current-installation
echo "Deploying EWS to $APP_BASE ........"


# Make Installation directory (where the war will be downloaded)
CURRENT_TIME=`date +%y%m%d_%H%M%S`
INSTALLERS_BASE=/home/mettl/volume1/serviceAssesmblies/englishSimulator/installers
BACKUP_BASE=/home/mettl/volume1/serviceAssesmblies/englishSimulator/backup
DOWNLOAD_DIR=$INSTALLERS_BASE/$CURRENT_TIME
mkdir -p $INSTALLERS_BASE
mkdir -p $DOWNLOAD_DIR
#cd ${BACKUP_BASE}


EXISTING_INSTALLATION_TIME=`cat $APP_BASE/installedOn.txt`
if [ -z "$EXISTING_INSTALLATION_TIME" ]; then
    EXISTING_INSTALLATION_TIME="BackedUpOn_$CURRENT_TIME";
fi

# The directory where the existing app will be moved to
BACKUP_DIR=$BACKUP_BASE/englishSimulator_$EXISTING_INSTALLATION_TIME
mkdir -p $BACKUP_DIR
echo "Back up directory created : $BACKUP_DIR"


# switch to installer dir
cd $DOWNLOAD_DIR

# pull latest release from jenkins
wget ${artifact_url} --user=deployment --password=deployment123 --auth-no-challenge
mv englishSimulator-$release_num-englishSimulator.zip englishSimulator.zip

# explode the war
unzip englishSimulator.zip
echo $CURRENT_TIME >> $DOWNLOAD_DIR/installedOn.txt
#mv englishSimulator-$release_num-englishSimulator.zip $INSTALLERS_BASE/englishSimulator_$release_num-_$CURRENT_TIME.jar
rm englishSimulator.zip
# move to home directory
cd /home/mettl/volume1/serviceAssesmblies/englishSimulator
rm  current-installation
ln -s ${DOWNLOAD_DIR}/englishSimulator current-installation
