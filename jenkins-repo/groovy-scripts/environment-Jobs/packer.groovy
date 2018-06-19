job('Devops-Packer') {
    description('This job will create ami for an autoscaling group with ansible config')
    parameters{
        stringParam('run_role_on_host')
        stringParam('base_ami_for_host')
        stringParam('env_vpc')
        stringParam('subnet_id')
        stringParam('patchID')
    }
    steps {
        shell(
                "echo \"patchID='\"\$patchID\"' \n" +

                "run_role_on_host='\"\$run_role_on_host\"' \n" +
                "   base_ami_for_host='\"\$base_ami_for_host\"' \n" +
                "  env_vpc='\"\$env_vpc\"' \n" +
                " subnet_id='\"\$subnet_id\"' \n" +
                "\" > /tmp/packer_env\n" +
                "sudo su - ansible << 'BASH'\n" +
                "source /tmp/packer_env\n" +
                "cd /home/ansible/ansible-repo\n" +
                "echo \$patchID\n" +
                "if [ -z \"\$patchID\" ]; then\n" +
                "git checkout ${ENV} \n" +
                "git fetch\n" +
                "git reset --hard origin/${ENV} \n" +
                "else \n" +
                "git checkout ${ENV} \n" +
                "git fetch\n" +
                "git reset --hard origin/${ENV} \n" +
                "echo \"\$patchID\" | bash\n" +
                "fi\n" +
                "git status \n" +
                "BASH \n" +

                'sed "s/run_role_on_host/$run_role_on_host/g; s/base_ami_for_host/$base_ami_for_host/g; s/env_vpc/$env_vpc/g; s/subnet-id/$subnet_id/g; s/timestamp/{{timestamp}}/g"  /home/ansible/packer > ~/$run_role_on_host-packer.json\n' +
                'cat ~/$run_role_on_host-packer.json\n' +
                '/opt/packer build ~/$run_role_on_host-packer.json'
        )
    }
}