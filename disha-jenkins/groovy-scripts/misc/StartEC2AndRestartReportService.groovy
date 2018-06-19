serverUrl="report.${InternalDomain}"
job("Start-EC2-And-Restart-Reporting-DB-Update-Service") {
    parameters{
        stringParam('Description', "start scheduled ReportDB updator instance and service")
    }
    triggers {
        cron("0 0 * * *")
    }
    steps {
        shell('#!/usr/bin/env python\n' +
                'import boto3\n' +
                'region =\'ap-south-1\'\n' +
                'instance_list ='+"\'${ReportingDBUpdateServiceEc2Id}\'"+'.split(\',\')\n' +
                '\n' +
                '\n' +
                'client = boto3.client(\'ec2\', region)\n' +
                'response_instance = client.start_instances(\n' +
                '    InstanceIds=instance_list,\n' +
                ')\n' +
                '\n' +
                'waiter = client.get_waiter(\'instance_running\')\n' +
                '\n' +
                'waiter.wait(\n' +
                '    InstanceIds=instance_list,\n' +
                ')'
        )
    }
    publishers {
        flexiblePublish {
            conditionalAction {
                condition {
                    alwaysRun()
                }
                publishers {
                    downstreamParameterized {
                        trigger("Restart-Reporting-DB-Update-Service") {
                            parameters {
                                currentBuild()
                            }
                            condition('SUCCESS')
                        }
                    }
                }
            }

        }
    }
}
