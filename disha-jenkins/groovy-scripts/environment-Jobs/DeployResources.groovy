job('GenericDishaCMSResourcesDeployer') {
    description('This job will deploy Disha CMS static resources on the s3')
    parameters{
        stringParam('versionNum')

    }
    steps {
        shell('#!/bin/bash\n' +
                'COMPONENT="disha-cms-res"\n' +
                '\n' +
                'S3Url="s3://'+"${ENV}"+'-cms-resources"\n' +
                '\n' +
                '\n' +
                'artifact_url=http://nexus.mettl.com:8081/nexus/content/repositories/releases/com/mettl/$COMPONENT/${versionNum}//$COMPONENT-${versionNum}.jar\n' +
                'wget ${artifact_url} --user=deployment --password=deployment123 --auth-no-challenge\n' +
                'jar -xf ${COMPONENT}-${versionNum}.jar\n' +
                '\n' +
                'rm ${COMPONENT}-${versionNum}.jar\n' +
                '\n' +
                'aws s3 sync resources ${S3Url}/resources --region ap-south-1 --delete\n' +
                'aws s3 sync trainingcurriculam ${S3Url}/trainingcurriculam --region ap-south-1 --delete\n' +
                'aws cloudfront create-invalidation --distribution-id '+"${disha_cms_cloudfrontId}"+' --invalidation-batch "{ \\"Paths\\": { \\"Quantity\\": 1, \\"Items\\": [\\"/*\\"]  }, \\"CallerReference\\": \\"${COMPONENT}_invalidation_"$(date +%d-%m-%y-%H-%M-%S)"\\" }"'
        )
    }
}

job('GenericDishaWebResourcesDeployer') {
    description('This job will deploy Disha Web static resources on the s3')
    parameters{
        stringParam('versionNum')

    }
    steps {
        shell('#!/bin/bash\n' +
                'COMPONENT="disha-web-res"\n' +
                '\n' +
                'S3Url="s3://'+"${ENV}"+'-web-resources"\n' +
                '\n' +
                '\n' +
                'artifact_url=http://nexus.mettl.com:8081/nexus/content/repositories/releases/com/mettl/$COMPONENT/${versionNum}//$COMPONENT-${versionNum}.jar\n' +
                'wget ${artifact_url} --user=deployment --password=deployment123 --auth-no-challenge\n' +
                'jar -xf ${COMPONENT}-${versionNum}.jar\n' +
                '\n' +
                'rm ${COMPONENT}-${versionNum}.jar\n' +
                '\n' +
                'aws s3 sync resources ${S3Url}/resources --region ap-south-1 --delete\n' +
                'aws cloudfront create-invalidation --distribution-id '+"${disha_web_cloudfrontId}"+' --invalidation-batch "{ \\"Paths\\": { \\"Quantity\\": 1, \\"Items\\": [\\"/*\\"]  }, \\"CallerReference\\": \\"${COMPONENT}_invalidation_"$(date +%d-%m-%y-%H-%M-%S)"\\" }"'
        )
    }
}