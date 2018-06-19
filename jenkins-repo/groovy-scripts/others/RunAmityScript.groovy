job("RunAmityScript") {
    parameters {
        fileParam('questions.xlsx', 'questions xl')
        stringParam('release_num')
        stringParam('assessment_name')
        stringParam('client_id')
        stringParam('public_key')
        stringParam('private_key')
        stringParam('comma_separated_schedule_names')
        stringParam('question_ip')

    }

    description("This job will run amity assessment creation script in scripts artifact")
    steps {
        shell('#!/bin/bash\n' +
                'chmod 777 .\n' +
                'echo "client_id=$client_id\n' +
                'assessment_name=\'"$assessment_name"\'\n' +
                'release_num=$release_num\n' +
                'question_ip=$question_ip\n' +
                'public_key=$public_key\n' +
                'private_key=$private_key\n' +
                'comma_separated_schedule_names=\'"$comma_separated_schedule_names"\'" > /tmp/env\n' +
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
                "./bin/MakeAssessmentsFromAmityExcel questions.xlsx \"\$assessment_name\" \$client_id \$question_ip \$public_key \$private_key http://api.${PublicDomain} \"\$comma_separated_schedule_names\"\n" +
                'BASH'
        )
    }
}