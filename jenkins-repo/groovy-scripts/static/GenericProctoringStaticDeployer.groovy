
job('GenericProctoringStaticDeployer') {
    description('This job will deploy the Proctoring static to s3')
    parameters{
        stringParam('versionNum')
    }
    steps {
        shell('#!/bin/bash\n' +
                'COMPONENT=\'proctoringStatic\'\n' +
                '\n' +
                "S3Url=\"s3://proctoring-static-${ENV}\"\n" +
                '\n' +
                'artifact_name="${COMPONENT}-${versionNum}.war"\n' +
                'artifact_url=http://nexus.mettl.com:8081/nexus/content/repositories/releases/com/mettl/${COMPONENT}/${versionNum}/${artifact_name}\n' +
                'wget ${artifact_url} --user=deployment --password=deployment123 --auth-no-challenge\n' +
                'jar -xf ${artifact_name}\n' +
                '\n' +
                'rm ${artifact_name}\n' +
                '\n' +
                'aws s3 sync scripts ${S3Url}/scripts --region'+" ${awsRegion} --delete"
        )
    }
}
