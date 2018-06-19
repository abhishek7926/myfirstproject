#!/bin/bash
component=$1
optional_argument_list=$2

for optional_argument in $optional_argument_list
do
    /home/mettl/release/java-services/stopMettlJavaServiceWithOptionalArg.sh $component "$optional_argument"
done
