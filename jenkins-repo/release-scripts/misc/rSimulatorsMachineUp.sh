#!/bin/bash

##################################################################################
#                                                                                #
#To run paratemer to be passed : <mettlde/prod> <componentName> <web/service>    #
#                                                                                #
##################################################################################

if [ "$#" -lt 1 ]
then
echo "Uasge is ./fatJarMachineUp.sh <mettlde/prod>"
exit
fi


ENV=$1
COMPONENT=$2
BASE_NEXUX_URL=$3
pre_argument=$4
service_type=$5

aws s3 cp s3://deployement-versions/$ENV/$service_type/index.html . --region ap-south-1
VERSION=`cat index.html`
echo "Version found is $VERSION"


echo "${COMPONENT} service is  installing with version ${VERSION}"
/home/mettl/release/java-services/deployRSimulatorsServices.sh $VERSION $COMPONENT $BASE_NEXUX_URL "$pre_argument" $service_type

