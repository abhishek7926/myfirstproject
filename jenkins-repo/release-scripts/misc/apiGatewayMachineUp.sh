#!/bin/bash

##################################################################################
#                                                                                #
#To run paratemer to be passed : <mettlde/prod> <componentName> <web/service>    #
#                                                                                #
##################################################################################

if [ "$#" -lt 1 ]
then
echo "Uasge is ./genericMachineup.sh <mettlde/prod>"
exit
fi

ENV=$1
COMPONENT=mettl-api-gateway
aws s3 cp s3://deployement-versions/$ENV/$COMPONENT/index.html . --region ap-south-1
VERSION=`cat index.html`
echo "Version found is $VERSION"


echo "mettl-api-gateway service is  installing with version ${VERSION}"
bash /home/mettl/release/java-services/deployProctoringService.sh $VERSION $COMPONENT
cd ~/volume1/serviceAssesmblies/mettl-api-gateway/current-installation
java -jar $COMPONENT.jar --spring.profiles.active=aws

