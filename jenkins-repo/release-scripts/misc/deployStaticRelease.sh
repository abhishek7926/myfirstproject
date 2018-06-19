#!/bin/bash

release_num=$1
echo "Deploying $release_num"

# turn on echo 
set -x verbose

# Set Time Zone
TZ='Asia/Kolkata'; 
export TZ

artifact_url=http://nexus.mettl.com:8081/nexus/content/repositories/releases/com/mettl/web-commons-static/$release_num/web-commons-static-$release_num.war
echo "will download from $artifact_url"


# web app base 
WEBAPP_BASE="/home/mettl/volume1/static/public_html"
echo "Deploying Static to $WEBAPP_BASE ........"


# Make Installation directory (where the war will be downloaded)
CURRENT_TIME=`date +%y%m%d_%H%M%S`
INSTALLERS_BASE=/home/mettl/volume1/static/installers
BACKUP_BASE=/home/mettl/volume1/static/backup
DOWNLOAD_DIR=$INSTALLERS_BASE/$CURRENT_TIME 

# change directory to tomcat webapps
mkdir  -p $DOWNLOAD_DIR
echo "Created $DOWNLOAD_DIR ...."


EXISTING_INSTALLATION_TIME=`cat $WEBAPP_BASE/installedOn.txt`
if [ -z "$EXISTING_INSTALLATION_TIME" ]; then
    EXISTING_INSTALLATION_TIME="BackedUpOn_$CURRENT_TIME";
fi

# The directory where the existing app will be moved to
BACKUP_DIR=$BACKUP_BASE/static_$EXISTING_INSTALLATION_TIME
mkdir -p $BACKUP_DIR
echo "Back up directory created : $BACKUP_DIR"


# switch to installer dir
cd $DOWNLOAD_DIR

# pull latest release from nexus
wget ${artifact_url} --user=deployment --password=deployment123 --auth-no-challenge
mv web-commons-static-$release_num.war webStatic.war


# explode the war
jar -xf webStatic.war
echo $CURRENT_TIME >> $DOWNLOAD_DIR/installedOn.txt
mv webStatic.war $INSTALLERS_BASE/webStatic_$release_num-$CURRENT_TIME.war

rm -rf $WEBAPP_BASE 
ln -s $DOWNLOAD_DIR $WEBAPP_BASE
# Move Existing web app to back up 
#mv /home/mettl/volume1/static/public_html/META-INF $BACKUP_DIR
#mv /home/mettl/volume1/static/public_html/WEB-INF $BACKUP_DIR
#mv /home/mettl/volume1/static/public_html/resources $BACKUP_DIR


# Move newly Exploded Web App to aui
#mv $DOWNLOAD_DIR/resources /home/mettl/volume1/static/public_html/resources
#mv $DOWNLOAD_DIR/WEB-INF /home/mettl/volume1/static/public_html/WEB-INF
#mv $DOWNLOAD_DIR/META-INF /home/mettl/volume1/static/public_html/META-INF

