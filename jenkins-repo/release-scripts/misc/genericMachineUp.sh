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
COMPONENT=$2
TYPE=$3
ARGUMENT=$4
aws s3 cp s3://deployement-versions/$ENV/$COMPONENT/index.html . --region ap-south-1
VERSION=`cat index.html`
echo "Version found is $VERSION" 

if [ "$TYPE" = "web" ]
then
echo "${COMPONENT}  webapp is  installing with version ${VERSION}"

bash /home/mettl/release/tomcat/deployMettlWebApp.sh $VERSION ${COMPONENT} 
bash /home/mettl/release/tomcat/restartServer.sh ${COMPONENT}-tomcat
elif [ "$TYPE" = "fatWar" ]
then
echo "${COMPONENT}  is  installing with version ${VERSION}"

bash /home/mettl/release/java-services/deployJavaWarService.sh $VERSION ${COMPONENT}
bash /home/mettl/release/java-services/startJavaWarService.sh ${COMPONENT}
elif [ "$TYPE" = "grader" ]
then
aws s3 cp s3://deployement-versions/$ENV/$COMPONENT/$COMPONENT-consumers.html . --region ap-south-1
consumers=`cat $COMPONENT-consumers.html`
bash /home/mettl/release/java-services/deployGrader.sh $VERSION applicationGrader ${consumers}
elif [ "$TYPE" = "service_with_multiple_consumers" ]
then
aws s3 cp s3://deployement-versions/$ENV/$COMPONENT/$COMPONENT-consumers.html . --region ap-south-1
consumers=`cat $COMPONENT-consumers.html`
echo "${COMPONENT} service is  installing with version ${VERSION}"
bash /home/mettl/release/java-services/deployMettlJavaServiceMultipleConsumersWrapper.sh $VERSION ${COMPONENT} ${consumers}
else
echo "${COMPONENT} service is  installing with version ${VERSION}"
bash /home/mettl/release/java-services/deployMettlJavaServiceWrapper.sh $VERSION ${COMPONENT} ${ARGUMENT}

fi

