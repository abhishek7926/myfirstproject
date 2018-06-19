#!/bin/bash

##################################################################################
#                                                                                #
#To run paratemer to be passed : <mettlde/prod> <componentName> <heapSize>       #
#                                                                                #
##################################################################################

if [ "$#" -lt 3 ]
then
echo "Uasge is ./startReportDbUpdaterService.sh <mettlde/prod> <componentName> <heapSize>"
exit
fi

ENV=$1
COMPONENT=$2
optional_argument=$3
aws s3 cp s3://$ENV-deployement-versions/$ENV/$COMPONENT/index.html . --region ap-south-1
VERSION=`cat index.html`
#VERSION=`curl -u autoDep:deployment123 http://central-jenkins.mettl.com/${ENV}/${COMPONENT}/`
echo "Version found is $VERSION"

echo "spring boot service - ${COMPONENT} is  installing with version ${VERSION}"

bash /home/mettl/release/spring-boot/deploySpringbootServiceWrapper.sh $VERSION ${COMPONENT} $optional_argument
