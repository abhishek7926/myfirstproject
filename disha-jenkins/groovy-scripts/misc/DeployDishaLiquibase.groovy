job('Deploy-Disha-Liquibase') {
    parameters{
        stringParam('git_tag')
    }

    steps {
        shell('#!/bin/bash\n' +
                'echo "git_tag=$git_tag" > /tmp/env \n' +
                'sudo su - ansible << \'EOF\' \n' +
                'source /tmp/env \n' +
                'rm -rf disha\n' +
                "git clone ssh://ansible-${ENV}@gerrit.mettl.com:29418/disha\n" +
                'cd disha/\n' +
                'git checkout $git_tag\n' +
                'mvn clean  process-resources -DskipTests -P liquibase\n'+
                'EOF'

        )
    }
}

job('Deploy-NDLM-Info-Liquibase') {
    parameters{
        stringParam('git_tag')
    }

    steps {
        shell('#!/bin/bash\n' +
                'echo "git_tag=$git_tag" > /tmp/env \n' +
                'sudo su - ansible << \'EOF\' \n' +
                'source /tmp/env \n' +
                'rm -rf ndlm.info\n' +
                "git clone ssh://ansible-${ENV}@gerrit.mettl.com:29418/ndlm.info\n" +
                'cd ndlm.info/\n' +
                'git checkout $git_tag\n' +
                'mvn clean  process-resources -DskipTests -P liquibase\n'+
                'EOF'

        )
    }
}