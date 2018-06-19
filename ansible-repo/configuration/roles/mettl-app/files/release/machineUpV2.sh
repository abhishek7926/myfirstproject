#!/bin/bash

ENV=$1
scp jarreader@54.251.163.181:/data/${ENV}/proctoring-python.zip $HOME
scp jarreader@54.251.163.181:/data/${ENV}/deployProctoringRelease.sh ${HOME}/volume1/installationScripts/deployProctoringRelease.sh
scp jarreader@54.251.163.181:/data/${ENV}/config.ini ${HOME}/config.ini
chmod +x ${HOME}/volume1/installationScripts/deployProctoringRelease.sh
$HOME/volume1/installationScripts/deployProctoringRelease.sh
