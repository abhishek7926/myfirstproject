#!/bin/bash

##################################################################################
#                                                                                #
#To run paratemer to be passed : <mettlde/prod> <componentName> <web/service>    #
#                                                                                #
##################################################################################

if [ "$#" -lt 4 ]
then
echo "Uasge is ./startRServerNodeClient.sh <mettlde/prod>"
exit
fi


ENV=$1
COMPONENT=$2
BASE_NEXUX_URL=$3
node_script=$4
service_type=$5

aws s3 cp s3://deployement-versions/$ENV/$service_type/index.html . --region ap-south-1
VERSION=`cat index.html`
echo "Version found is $VERSION"


echo "${COMPONENT} service is  installing with version ${VERSION}"
/home/mettl/release/misc/deployMettlZipComponentWithCustumBaseNexsusUrl.sh $VERSION $COMPONENT $BASE_NEXUX_URL

/home/mettl/release/node-services/startRServerNodeClient.sh $COMPONENT $node_script