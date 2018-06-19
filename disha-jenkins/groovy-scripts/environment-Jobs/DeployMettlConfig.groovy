job('Deploy-Mettl-Config') {
  description('This job will deploy the configuration on the target server, make sure that you should have password less login enabled to the target server')
  scm {
    git("ssh://jenkins-${ENV}@gerrit.mettl.com:29418/mettl-configurations-india.git","${ENV}")

  }
  steps {
    serverUrl="nfs.${InternalDomain}"
    shell('#!/bin/bash\n' +

            'rsync -vrtgoDWe "ssh -o StrictHostKeyChecking=no" --delete ./ mettl@'+"${serverUrl}"+ ':/export/configuration\n'
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

