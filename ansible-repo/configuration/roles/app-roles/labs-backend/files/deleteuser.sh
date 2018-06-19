#!/bin/bash
ROOT_UID=0
SUCCESS=0
E_USERDOESNOTEXIST=71

#test, if both argument are there
if [ $# -eq 1 ]; then
username=$1

        # Check if user already exists.
        sudo -i grep -q "$username" /etc/passwd
        if [ $? -ne $SUCCESS ]
        then
        echo "User $username does not exist."
        exit $E_USERDOESNOTEXIST
        fi

        sudo -i userdel $username
        exit $SUCCESS
else
        echo  " this programm needs username arguments you have given $# "

exit 1