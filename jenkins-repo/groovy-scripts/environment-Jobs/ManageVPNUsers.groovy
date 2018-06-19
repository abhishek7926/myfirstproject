serverUrl="openvpn.${InternalDomain}"
job("ManageVpnUsers") {
        description("This job will manage vpn users")
        parameters{
                stringParam('USER_NAME')
                nonStoredPasswordParam('PASSWORD')
                choiceParam('Manage', ['Create', 'Delete', 'List'] )

        }
        steps {
                shell('#!/bin/bash\n' +
                        'TARGET_SERVER_IP=${!TARGET_SERVER_IP_STR}\n' +
                        '\n' +
                        "ssh -o StrictHostKeyChecking=no ubuntu@${serverUrl}"+' username=$USER_NAME manage=$Manage password=$PASSWORD \'bash -s\' << \'EOF\'\n' +
                        '\n' +
                        '#cat /etc/passwd | awk -F ":" \'{print $1}\'\n' +
                        '\n' +
                        'if [ "$manage" = "Delete" ]; then\n' +
                        '\tsudo deluser --remove-home $username\n' +
                        'elif [ "$manage" = "Create" ]; then\n' +
                        '\techo "creating user name :  $username"\n' +
                        '\tsudo egrep "^$username" /etc/passwd >/dev/null\n' +
                        '    if [ $? -eq 0 ]; then\n' +
                        '                echo "$username already exists! Changing the password"\n' +
                        '                echo "$username:$password" | sudo chpasswd\n' +
                        '                #echo -e "$password\\n$password" | (passwd --stdin $username) \n' +
                        '    else\n' +
                        '                pass=$(perl -e \'print crypt($ARGV[0], "password")\' $password)\n' +
                        '                sudo useradd -m -p $pass $username\n' +
                        '                [ $? -eq 0 ] && echo "User has been added to system!" || echo "Failed to add a user!"\n' +
                        '\n' +
                        '\n' +
                        '\tfi\n' +
                        'fi\n' +
                        'if [ "$manage" = "List" ]; then\n' +
                        '\tawk -F\'[/:]\' \'{if ($3 >= 1000 && $3 != 65534) print $1}\' /etc/passwd\n' +
                        'fi\n' +
                        '\n' +
                        'EOF\n' +
                        ''

                )
        }
}