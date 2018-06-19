job('Devops-Deploy-Mettl-Scripts') {
    description('This job will deploy Mettl scripts on nfs server')
    scm {
        git("ssh://jenkins-${ENV}@gerrit.mettl.com:29418/jenkins-repo.git","${ENV}")

    }
    steps {
        serverUrl="nfs.${InternalDomain}"
        shell('#!/bin/bash\n' +
                'rsync -avWe "ssh -o StrictHostKeyChecking=no" --delete mettl-scripts/ mettl@'+"${serverUrl}"+ ':/export/mettl-scripts/\n'
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

