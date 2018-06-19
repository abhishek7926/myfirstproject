versionNum=$1
component=$2
optional_argument_list=$3


/home/mettl/release/java-services/stopMultipleInstanceJavaService.sh $component "$optional_argument_list"

/home/mettl/release/java-services/deployMettlJavaService.sh $versionNum $component

/home/mettl/release/java-services/startMultipleInstanceJavaService.sh $component "$optional_argument_list"


