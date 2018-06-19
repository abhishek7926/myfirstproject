versionNum=$1
graderType=$2

if [ $graderType == "applicationGrader" ]; then
consumers=$3
else
consumers="1"
fi

if [ $graderType == "applicationGrader" ] ; then
/home/mettl/release/java-services/stopMettlJavaServiceWithOptionalArg.sh grader applicationGrader
/home/mettl/release/java-services/deployMettlJavaService.sh $versionNum grader
/home/mettl/release/java-services/startMettlJavaServiceWithOptionalArg.sh grader applicationGrader $consumers
else
/home/mettl/release/java-services/stopMettlJavaServiceWithOptionalArg.sh grader grader
/home/mettl/release/java-services/stopMettlJavaServiceWithOptionalArg.sh grader revaluation
/home/mettl/release/java-services/stopMettlJavaServiceWithOptionalArg.sh grader authBlockedCandidate

/home/mettl/release/java-services/deployMettlJavaService.sh $versionNum grader 

/home/mettl/release/java-services/startMettlJavaServiceWithOptionalArg.sh grader grader $consumers
/home/mettl/release/java-services/startMettlJavaServiceWithOptionalArg.sh grader revaluation $consumers
/home/mettl/release/java-services/startMettlJavaServiceWithOptionalArg.sh grader authBlockedCandidate $consumers
fi
