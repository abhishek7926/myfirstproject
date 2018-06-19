#!/bin/bash
component=$1
optional_argument_list=$2



for optional_argument in $optional_argument_list
do
/home/mettl/release/java-services/startMettlJavaServiceWithOptionalArg.sh $component "$optional_argument"
done
