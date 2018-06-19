serverUrl="static.${InternalDomain}"
job('Deploy-Static') {
    description('This job will deploy the static on the target server, make sure that you should have password less ' +
            'login enabled to the target server')
    parameters{
        stringParam('versionNum')
    }
    wrappers {
        buildUserVars()
    }
    steps {
        shell('#!/bin/bash\n' +
                'ssh -o StrictHostKeyChecking=no mettl@'+"${serverUrl}"+ ' "release/misc/deployStaticRelease.sh $versionNum" '

        )
    }
    publishers {
        extendedEmail {
            defaultSubject("(${ENV} environment) "+'$DEFAULT_SUBJECT (Version Number: $versionNum)')
            defaultContent(
                    'Started By: $BUILD_USER\n' +
                            '\n' +
                            'Check console output at $BUILD_URL to view the results.\n')
            triggers {
                always {
                }
            }
        }
    }

}
