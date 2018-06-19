#!/bin/bash
ROOT_UID=0
SUCCESS=0
E_USERDOESNOTEXIST=71

#test, if both argument are there
if [ $# -eq 2 ]; then
username=$1
pass=$2

        # Check if user already exists.
        sudo -i grep -q "$username" /etc/passwd
        if [ $? -ne $SUCCESS ]
        then
        echo "User $username does not exist."
        exit $E_USERDOESNOTEXIST
        fi

        sudo -i usermod --password $(openssl  passwd $pass) $username
        exit 0
else
        echo  " this programm needs 2 arguments. you have given $# "
        echo  " you have to call the script $0 username and the pass "
        exit 1
fi

exit 2