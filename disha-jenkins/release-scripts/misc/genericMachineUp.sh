#!/bin/bash

##################################################################################
#                                                                                #
#To run paratemer to be passed : <mettlde/prod> <componentName> <web/service>    #
#                                                                                #
##################################################################################

if [ "$#" -lt 3 ]
then
echo "Uasge is ./genericMachineup.sh <mettlde/prod> <componentName> <web/service/spring-boot>"
exit
fi

ENV=$1
COMPONENT=$2
TYPE=$3
aws s3 cp s3://$ENV-deployement-versions/$ENV/$COMPONENT/index.html . --region ap-south-1
VERSION=`cat index.html`
#VERSION=`curl -u autoDep:deployment123 http://central-jenkins.mettl.com/${ENV}/${COMPONENT}/`
echo "Version found is $VERSION"

if [ "$TYPE" = "web" ]
then
echo "${COMPONENT}  webapp is  installing with version ${VERSION}"

bash /home/mettl/release/tomcat/deployMettlWebApp.sh $VERSION ${COMPONENT}
bash /home/mettl/release/tomcat/restartServer.sh ${COMPONENT}-tomcat
elif [ "$TYPE" = "spring-boot" ]
then
echo "spring boot service - ${COMPONENT} is  installing with version ${VERSION}"

bash /home/mettl/release/spring-boot/deploySpringbootServiceWrapper.sh $VERSION ${COMPONENT}
else
echo "${COMPONENT} service is  installing with version ${VERSION}"
bash /home/mettl/release/java-services/deployMettlJavaServiceWrapper.sh $VERSION ${COMPONENT}
fi