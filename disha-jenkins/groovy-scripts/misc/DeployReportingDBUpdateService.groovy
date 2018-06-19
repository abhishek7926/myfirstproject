component="disha-report"

job("GenericReportingDBUpdateServiceDeployer") {
    parameters{
        stringParam('versionNum')
    }
    steps {
        shell('#!/bin/bash\n' +

                "echo \$versionNum > index.html\n" +
                "aws s3 mv ./index.html s3://${ENV}-deployement-versions/${ENV}/${component}/index.html --region ap-south-1\n"
        )
    }
}
