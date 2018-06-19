job('dsl-server-configuration-ansible') {
  parameters{
    stringParam('inventory')
    stringParam('HOSTNAME')
    choiceParam('playbook', ['site.yml', 'userManagement.yml'])
    stringParam('startAtTask')
    stringParam('patchID')

  }
  steps {
    ENV="${ENV}"
    shell(
            '#!/bin/bash\n' +
                    'echo "invent=$inventory\n' +
                    'host=$HOSTNAME\n' +
                    'startTask=\'"$startAtTask"\' \n' +
                    'patchID=\'"$patchID"\' \n' +
                    'play=$playbook" > /tmp/env\n' +
                    'sudo su - ansible << \'BASH\'\n' +
                    'source /tmp/env\n' +
                    '\n' +
                    'cd /home/ansible/ansible-repo\n' +
                    '\n' +
                    'if [ -z "$patchID" ]; then\n' +
                    'git checkout ' + "${ENV}" +' \n' +
                    'git fetch\n' +
                    'git reset --hard origin/' + "${ENV}" +' \n' +
                    'else \n' +
                    'git checkout ' + "${ENV}" +' \n' +
                    'git fetch\n' +
                    'git reset --hard origin/' + "${ENV}" +' \n' +
                    'echo "$patchID" | bash\n' +
                    'fi\n' +
                    'git status \n' +
                    'IFS=\',\' read -r -a ar <<< "$host"\n' +
                    'if [ -z "$startTask" ]; then \n' +
                    'for item in ${ar[@]}; do \n' +
                    'echo running role on $item;\n' +
                    'ansible-playbook -i /etc/ansible/inventories/$invent /etc/ansible/$play --limit $item \n' +
                    'done\n' +
                    'else \n' +
                    'for item in ${ar[@]}; do \n' +
                    'echo running role on $item;\n' +
                    'ansible-playbook -i /etc/ansible/inventories/$invent /etc/ansible/$play --limit $item --start-at-task "$startTask" \n' +
                    'done\n' +
                    'fi \n' +
                    '\n' +
                    'BASH'



    )
  }
}
