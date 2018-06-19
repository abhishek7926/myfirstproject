job('Deploy-InterviewApp-Liquibase') {
//    publishers {
//        publishBuild {
//            discardOldBuilds(30, 50)
//        }
//    }
    parameters{
        stringParam('git_tag')
        choiceParam('TARGET_SERVER', ['interviewapp'])

    }

    steps {
        shell('#!/bin/bash\n' +
                'echo "git_tag=$git_tag" > /tmp/liquibase \n' +
                'sudo su - ansible << \'EOF\' \n' +
                'source /tmp/liquibase \n'+
                'rm -rf interview-app \n' +
                'git clone ' +"ssh://ansible-${ENV}@gerrit.mettl.com:29418/interview-app"+' \n' +
                'cd interview-app/\n' +
                'git checkout ${git_tag} \n' +
                'mvn clean  process-resources -DskipTests -P liquibase\n' +
                'EOF'

        )
    }
}

job('Deploy-Certification-Liquibase') {
//    publishers {
//        publishBuild {
//            discardOldBuilds(30, 50)
//        }
//    }
    parameters{
        stringParam('git_tag')

    }

    steps {
        shell('#!/bin/bash\n' +
                'echo "git_tag=$git_tag" > /tmp/liquibase \n' +
                'sudo su - ansible << \'EOF\' \n' +
                'source /tmp/liquibase \n' +
                'rm -rf Certification \n' +
                'git clone ' +"ssh://ansible-${ENV}@gerrit.mettl.com:29418/Certification"+' \n' +
                'cd Certification\n' +
                'git checkout ${git_tag} \n' +
                'cd certification-liquibase\n' +
                'mvn clean  process-resources -DskipTests -P liquibase\n' +
                'EOF'

        )
    }
}

job('Deploy-Hackathon-Liquibase') {
//    publishers {
//        publishBuild {
//            discardOldBuilds(30, 50)
//        }
//    }
    parameters{
        stringParam('git_tag')
        choiceParam('TARGET_SERVER', ['hackathon'])

    }

    steps {
        shell('#!/bin/bash\n' +
                'echo "git_tag=$git_tag" > /tmp/liquibase \n' +
                'sudo su - ansible << \'EOF\' \n' +
                'source /tmp/liquibase \n'+
                'rm -rf hackathon \n' +
                'git clone ' +"ssh://ansible-${ENV}@gerrit.mettl.com:29418/hackathon"+' \n' +
                'cd hackathon/\n' +
                'git checkout ${git_tag} \n' +
                'mvn clean  process-resources -DskipTests -P liquibase\n' +
                'EOF'

        )
    }
}
