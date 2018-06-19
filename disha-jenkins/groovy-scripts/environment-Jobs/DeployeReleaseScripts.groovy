job('Devops-Deploy-Release-Scripts') {
    description('This job will deploy release scripts on nfs server')
    scm {
        git("ssh://jenkins-${ENV}@gerrit.mettl.com:29418/disha-jenkins.git","${ENV}")
    }
    steps {
        serverUrl="nfs.${InternalDomain}"
        shell('#!/bin/bash\n' +
                'rsync -avWe "ssh -o StrictHostKeyChecking=no" --delete release-scripts/ mettl@'+"${serverUrl}"+ ':/export/release-scripts/\n'
        )
    }
    publishers {
        slackNotifier {
            room('#jenkins')
            notifyAborted(true)
            notifyFailure(true)
            notifyNotBuilt(false)
            notifyRepeatedFailure(false)
            notifyUnstable(true)
            notifyBackToNormal(true)
            notifySuccess(true)
            startNotification(true)
            includeTestSummary(false)
            includeCustomMessage(false)
            customMessage(null)
            sendAs(null)
            commitInfoChoice('NONE')
            teamDomain(null)
            authToken(null)
            authTokenCredentialId(null)
        }
    }
}

