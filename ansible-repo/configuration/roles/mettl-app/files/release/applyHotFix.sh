#!/bin/bash

RELEASE_NO=$1
COMPONENT=$2

function applyHotFix() {
	RELEASE_NO=$1
	APP_DEPLOYED_FOLDER=$2
	PATCH_FOLDER=$3

	rm -rf ${HOME}/hotfix/
	mkdir ${HOME}/hotfix/
	tar -xzf ${HOME}/${RELEASE_NO}.tar.gz -C ${HOME}/hotfix

	while read fileRelativePath
	do
#		echo "File to be hotfixed $fileRelativePath"
		cp -v ${HOME}/hotfix/${RELEASE_NO}/${PATCH_FOLDER}/${fileRelativePath} ~/volume1/${APP_DEPLOYED_FOLDER}/www/${fileRelativePath}
	done < /home/mettl/files_to_be_hotfixed.lst
#	cp -rv ${HOME}/hotfix/${RELEASE_NO}/${PATCH_FOLDER}/* ~/volume1/${APP_DEPLOYED_FOLDER}/www/
}

applyHotFix ${RELEASE_NO} ${COMPONENT} ${COMPONENT}/src/main/webapp/
