
job('GenericMeanStaticDeployer') {
    description('This job will deploy the Mean static to s3')
    parameters{
        stringParam('versionNum')
    }
    steps {
        shell('#!/bin/bash\n' +
                'COMPONENT=\'mean-stack-ide\'\n' +
                '\n' +
                "S3Url=\"s3://mean-static-${ENV}\"\n" +
                '\n' +
                'artifact_name="${COMPONENT}-${versionNum}-${COMPONENT}.zip"\n' +
                '\n' +
                'rm -rf theia-ide\n' +
                'artifact_url=http://nexus.mettl.com:8081/nexus/content/repositories/releases/com/mettl/${COMPONENT}/${versionNum}/${artifact_name}\n' +
                'wget ${artifact_url} --user=deployment --password=deployment123 --auth-no-challenge\n' +
                'unzip ${artifact_name}\n' +
                '\n' +
                'rm ${artifact_name}\n' +
                '\n' +
                'aws s3 sync theia-ide ${S3Url}/theia-ide --region'+" ${awsRegion} --delete"
        )
    }
}
