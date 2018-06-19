#!/bin/bash
function addUsersScript() {
host=$1
dbadmin_username=$2
dbadmin_password=$3
username=$4
password=$5
roles=$6
    mongo -host $host -u $dbadmin_username  -p $dbadmin_password Mettl <<EOF
    use Mettl
 db.addUser( { user: "${username}",
              pwd: "${password}",
              roles: [ ${roles} ]
            } )

EOF
}


function removeUser() {
host=$1
dbadmin_username=$2
dbadmin_password=$3
username=$4
    mongo -host $host -u $dbadmin_username  -p $dbadmin_password Mettl <<EOF
    use Mettl
    db.removeUser("${username}")

EOF
}

function showUsers() {
host=$1
dbadmin_username=$2
dbadmin_password=$3
mongo -host $host -u $dbadmin_username  -p $dbadmin_password Mettl <<EOF
use Mettl
db.system.users.find().pretty();
EOF
}

