#!/bin/bash
ROOT_UID=0
SUCCESS=0
E_USEREXISTS=70

#test, if both argument are there
if [ $# -eq 2 ]; then
username=$1
pass=$2

        # Check if user already exists.
        sudo -i grep -q "$username" /etc/passwd
        if [ $? -eq $SUCCESS ]
        then
        echo "User $username already exists."
        echo "please choose another username."
        exit $E_USEREXISTS
        fi

        sudo -i useradd -p $(openssl  passwd $pass) -d /home/"$username" -m "$username"

# Check if user already exists.
        sudo -i grep -q "$username" /etc/passwd
        if [ $? -eq $SUCCESS ]
        then
        echo "added user $username"
        exit 0
        fi
        echo "user $username cound not be added"

else
        echo  " this programm needs 2 arguments you have given $# "
        echo  " you have to call the script $0 username and the pass "
        exit 1
fi
