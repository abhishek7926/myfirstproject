#!/bin/bash

##################################################################################
#                                                                                #
#To run paratemer to be passed : <mettlde/prod> <componentName> <web/service>    #
#                                                                                #
##################################################################################


ENV=$1
COMPONENT=$2
BASE_NEXUX_URL=$3
START_COMMAND=$4

aws s3 cp s3://deployement-versions/$ENV/$COMPONENT/index.html . --region ap-south-1
VERSION=`cat index.html`
echo "Version found is $VERSION"


echo "${COMPONENT} service is  installing with version ${VERSION}"

/home/mettl/release/java-services/deployProctoringServiceWithCustomBaseNexusUrl.sh $VERSION $COMPONENT $BASE_NEXUX_URL
/home/mettl/release/java-services/placeholderStartJavaService.sh $COMPONENT "$START_COMMAND"
