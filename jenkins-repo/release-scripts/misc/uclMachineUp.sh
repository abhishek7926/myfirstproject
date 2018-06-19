#!/bin/bash

##################################################################################
#                                                                                #
#To run paratemer to be passed : <mettlde/prod> <componentName> <web/service>    #
#                                                                                #
##################################################################################

if [ "$#" -lt 3 ]
then
echo "Uasge is ./genericMachineup.sh <mettlde/prod> <componentName> <web/service>"
exit
fi

ENV=$1
Deployement_Folder=$2
COMPONENT=$3
TYPE=$4
ARGUMENT=$5
aws s3 cp s3://deployement-versions/$ENV/$Deployement_Folder/index.html . --region ap-south-1
VERSION=`cat index.html`
echo "Version found is $VERSION" 

if [ "$TYPE" = "web" ]
then
echo "${COMPONENT}  webapp is  installing with version ${VERSION}"

bash /home/mettl/release/tomcat/deployMettlWebApp.sh $VERSION ${COMPONENT} 
bash /home/mettl/release/tomcat/restartServer.sh ${COMPONENT}-tomcat
else
echo "${COMPONENT} service is  installing with version ${VERSION}"
bash /home/mettl/release/java-services/deployMettlJavaServiceWrapper.sh $VERSION ${COMPONENT} ${ARGUMENT}
fi

