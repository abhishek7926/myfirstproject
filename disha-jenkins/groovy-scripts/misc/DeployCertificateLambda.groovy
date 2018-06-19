job('Deploy-Certificate-Lambda') {
    parameters{
        stringParam('versionNum')
    }

    steps {
        shell('#!/bin/bash\n' +
                '\n' +
                'rm -rf *\n' +
                'component=disha-certificate-lambda\n' +
                'release_num=$versionNum\n' +
                "lambda_name=${certificate_lambda_name}\n" +
                "aws_region=${awsRegion}\n" +
                'echo "Deploying $release_num"\n' +
                '\n' +
                '# turn on echo\n' +
                'set -x verbose\n' +
                '\n' +
                '# Set Time Zone\n' +
                'TZ=\'Asia/Kolkata\';\n' +
                'export TZ\n' +
                '\n' +
                'artifact_url=http://nexus.mettl.com:8081/nexus/content/repositories/releases/com/mettl/$component/$release_num/$component-$release_num-$component.zip\n' +
                'echo "will download from $artifact_url"\n' +
                '\n' +
                '# pull latest release from jenkins\n' +
                'wget ${artifact_url} --user=deployment --password=deployment123 --auth-no-challenge\n' +
                '\n' +
                'aws lambda --region $aws_region update-function-code --function-name $lambda_name --zip-file fileb://$component-$release_num-$component.zip'

        )
    }
}