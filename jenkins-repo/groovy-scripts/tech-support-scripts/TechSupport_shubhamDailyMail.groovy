job("TechSupport_shubhamDailyMail") {
    parameters {
        stringParam('release_num')
        stringParam('client_id')
    }

    description("This job will run amity assessment creation script in scripts artifact")
    triggers {
        cron('0 10,17 * * *')
    }
    steps {
        shell('#!/bin/bash\n' +
                'sudo rm -rf ../workspace_ws* \n' +
                'chmod 777 .\n' +
                'echo "client_id=$client_id\n' +
                'release_num=$release_num\n' +
                'outputfilename=\'"$outputfilename"\'" > /tmp/env\n' +
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
                "./bin/ExportQuestionAnalyticsForAllQuestionsClient nodedata.xlsx \$client_id \"\$outputfilename\" \n" +
                'BASH'
        )
    }
    publishers {
        extendedEmail {
            defaultSubject("(${ENV} environment) " + 'Accumulative Excel Report from Mettl (Version Number: $versionNum)')
            recipientList('tarun.yaduvanshi@mettl.com,kaustubh.bansal@mettl.com')
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
