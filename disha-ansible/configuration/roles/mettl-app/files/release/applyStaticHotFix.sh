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

	cp -rv ${HOME}/hotfix/${RELEASE_NO}/${PATCH_FOLDER}/* ~/volume1/${APP_DEPLOYED_FOLDER}
}

applyHotFix ${RELEASE_NO} static/public_html/ ${COMPONENT}/src/main/webapp/
