serverUrl="ldap.mettl.${InternalDomain}"
job("UserManagement_LDAP") {
    description("Use to manage users, groups and permission.")
    keepDependencies(false)
    parameters {
        choiceParam("Task", ["Select", 1, 2, 3, 4, 5, 6, 7], """1. Add a User
2. List the Users
3. Remove a User
4. Create a Group
5. Remove a Group
6. Add a User to Group
7. Remove a User from Group""")
        stringParam("UserName", "", "Username format firstname-lastname")
        stringParam("GroupName", "superuser", "")
        stringParam("GroupID", "8000", "")
        stringParam("PubKey", "", "Enter the Public Key")
    }
    disabled(false)
    concurrentBuild(false)
    steps {
        shell("""#!/bin/bash
echo "Username is \$UserName"
echo "Group Name is \$GroupName"
echo "Group id is \$GroupID"
echo "Public key is \$PubKey"
touch /tmp/\$UserName.pub
echo "\$PubKey" > /tmp/\$UserName.pub
UserN=\$(ssh -o StrictHostKeyChecking=no ec2-user@${serverUrl} "getent passwd | grep -w \$UserName | awk -F: '{ print \\\$1 }'")
UserCount=\$(ssh -o StrictHostKeyChecking=no ec2-user@${serverUrl} "getent passwd | grep -w \$UserName | wc -l")
GrpCount=\$(ssh -o StrictHostKeyChecking=no ec2-user@${serverUrl} "getent group | grep -w \$GroupName | wc -l")
GrpName=\$(ssh -o StrictHostKeyChecking=no ec2-user@${serverUrl} "getent group | grep -w \$GroupName | awk -F: '{ print \\\$1 }'")
GiD=\$(ssh -o StrictHostKeyChecking=no ec2-user@${serverUrl} "getent group | grep -w \$GroupID | wc -l")
GrID=\$(ssh -o StrictHostKeyChecking=no ec2-user@${serverUrl} "getent group | grep -w \$GroupID | awk -F: '{ print \\\$3 }'")
echo \$GiD
case \$Task in
1)
echo "Adding user"
if [[ "\$UserCount" == "0" && ! -z "\$UserName" && ! -z "\$PubKey" ]];
then
echo "Adding user \$UserName"
echo "Copying publc key to /keys"
scp /tmp/\$UserName.pub ec2-user@${serverUrl}:/keys
ssh -o StrictHostKeyChecking=no -t ec2-user@${serverUrl} <<EOT
sudo su
cd
bash useradd.sh \$UserName
EOT
echo "User Added."
else
echo "Not added... User exist or Invalid username or Invalid Public key"
exit 1
fi
;;

2)
echo "Users List"
echo "-----------------------------------------"
ssh -o StrictHostKeyChecking=no ec2-user@${serverUrl} "getent passwd | awk -F:  '{ print \\\$1 }'"
echo "-----------------------------------------"
;;

3)
echo "Removing User"
if [[ "\$UserCount" == "1" && ! -z \$UserName && "\$UserName" == "\$UserN"  ]];
then
echo "Removing user \$UserName"
ssh -o StrictHostKeyChecking=no -t ec2-user@${serverUrl} <<EOF
sudo su
cd
bash userdelete.sh \$UserName
EOF
echo "User deleted"
else
echo "User doesn't exist"
fi
;;

4)
echo "Creating group"
if [[ "\$GrpCount" == "0" && "\$GroupID" != "\$GrID" && ! -z "\$GroupName" && "\$GroupName" != "\$GrpName" ]];
then
echo "Creating new group \$GroupName"
ssh -o StrictHostKeyChecking=no -t ec2-user@${serverUrl} <<EOF
sudo su
cd
bash groupadd.sh \$GroupName \$GroupID
EOF
echo "Group added"
else 
echo"Group already exist/Existing Group Id"
fi
;;

5)
echo "Removing Group"
if [[ "\$GrpCount" == "1" && ! -z "\$GroupName" && "\$GroupName" == "\$GrpName" ]];
then
echo "Removing Group \$GroupName with GID \$GrID"
ssh -o StrictHostKeyChecking=no -t ec2-user@${serverUrl} <<EOF
sudo su
cd
bash delete_group.sh \$GroupName
EOF
echo "Group Removed"
else
echo "Group doesn't exist"
fi
;;

6)
echo "Adding user to another group"
if [[ "\$UserName" == "\$UserN" && ! -z "\$GroupName" && ! -z "\$UserName" ]];
then
echo "Adding user \$UserName to Group \$GroupName"
ssh -o StrictHostKeyChecking=no -t ec2-user@${serverUrl} <<EOF
sudo su
cd
bash add_user_to_grp.sh \$GroupName \$UserName
EOF
echo "User \$UserName added to Group \$GroupName"
else
echo "User/Group don't exist/Check the input"
fi
;;

7)
echo "Removing a user from a group"
if [[ "\$UserName" == "\$UserN" && "\$GroupName" == "\$GrpName" && ! -z "\$GroupName" && ! -z "\$UserName" ]];
then
echo "Removing user \$UserName to Group \$GroupName"
ssh -o StrictHostKeyChecking=no -t ec2-user@${serverUrl} <<EOF
sudo su
cd
bash delete_user_from_group.sh \$GroupName \$UserName
EOF
echo "User \$UserName deleted from Group \$GroupName"
else
echo "User/Group don't exist/Check the input"
fi
;;

*)
echo "Input a valid choice"
;;
esac""")
    }
}