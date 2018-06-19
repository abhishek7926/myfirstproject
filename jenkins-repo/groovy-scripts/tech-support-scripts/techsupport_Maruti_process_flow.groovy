job("TechSupport_Maruti_process_flow") {
    parameters {
        stringParam('release_num')
        stringParam('schedule_key')
    }

    description("This job will run for maruti Assessment flow")
    steps {
        shell('#!/bin/bash\n' +
                'sudo rm -rf ../workspace_ws* \n' +
                'chmod 777 .\n' +
                'echo "schedule_key=$schedule_key"\n' +
                'release_num=$release_num\n' +
                'sudo su ansible << \'BASH\'\n' +
                'source /tmp/env\n' +
                'component="scripts"\n' +
                'echo "Deploying $release_num"\n' +
                '\n' +
                '# turn on echo \n' +
                'set -x verbose\n' +
                '\n' +
                '# Set Time Zone\n' +
                'TZ=\'Asia/Kolkata\'; \n' +
                'export TZ\n' +
                'artifact_url=http://nexus.mettl.com:8081/nexus/content/repositories/releases/com/mettl/${component}/${release_num}/${component}-${release_num}-assembly.jar\n' +
                'echo "will download from $artifact_url"\n' +
                '# pull latest release from nexus\n' +
                'wget -N ${artifact_url} --user=deployment --password=deployment123 --auth-no-challenge\n' +
                '\n' +
                '# explode the war\n' +
                'jar -xf ${component}-${release_num}-assembly.jar\n' +
                'chmod +x bin/*\n' +
                "./bin/MarutiExcelScript \$schedule_key \n" +
                'BASH'
        )
    }
    publishers {
        extendedEmail {
            defaultSubject("(${ENV} environment) " + 'Maruti Excel Report from Mettl')
            recipientList('tarun.yaduvanshi@mettl.com')
            attachmentPatterns('*.xlsx')
            defaultContent(
                    'Please find the attached excel report\n' +
                            '\n' +
                            '${BUILD_LOG_REGEX, regex="^.*?enabling perform", showTruncatedLines=false, linesBefore=1}')
            triggers {
                always {
                }
            }
        }
    }
}
