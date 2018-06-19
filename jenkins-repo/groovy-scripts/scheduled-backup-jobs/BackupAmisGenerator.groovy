class MyJob{
    public String instanceId
    public String dataService
    public String amisToKeep
    MyJob(instanceId, dataService,amisToKeep){
        this.instanceId=instanceId
        this.dataService=dataService
        this.amisToKeep=amisToKeep
    }

}
def jobList = [new MyJob("${mongo_heavy_primary_instance_id}",'mongo-heavy-primary',15),
               new MyJob("${mongo_heavy_secondary_instance_id}",'mongo-heavy-secondary',15),
               new MyJob("${mongo_light_primary_instance_id}",'mongo-light-primary',15),
               new MyJob("${mongo_light_secondary_instance_id}",'mongo-light-secondary',15),
               new MyJob("${wordpress_instance_id}",'wordpress',15),
               new MyJob("${windows_codelysis_instance_id}",'windows-codelysis',15),
               new MyJob("${windows_codeproject_instance_id}",'windows-codeproject',15)
]

jobList.each { k ->
    job("Create-${k.dataService}-ami-Backup") {
        description("This job will create the ami and volumes backup of ${k.dataService} ")
        triggers {
            cron('@midnight')
        }

        steps {
            shell('#!/usr/bin/env python\n' +

                    "import boto3\n" +
                    "import time\n" +
                    "from datetime import datetime\n" +
                    "instance_id=\"${k.instanceId}\"\n" +
                    "application_name=\"${k.dataService}\" \n" +
                    "region=\"${awsRegion}\"\n" +
                    "mettl_environment=\"${ENV}\"\n" +
                    "ami_name=mettl_environment + \"-\" + application_name + '-' + str(time.strftime(\"%d-%m-%Y-%H-%M-%S\")) + '-will be deleted by scripts'\n" +
                    "client = boto3.client('ec2', region_name=region)\n" +
                    "\n" +
                    "#################################### create image ################################################\n" +
                    "response_create_image = client.create_image(\n" +
                    "        InstanceId=instance_id,\n" +
                    "        Name=ami_name,\n" +
                    "        NoReboot=True\n" +
                    ")\n" +
                    "\n" +
                    "print response_create_image\n" +
                    "search_amis_to_deregister_by_name=mettl_environment + \"-\" + application_name + '-' + \"*-will be deleted by scripts\"\n" +
                    "days_to_keep_amis=${k.amisToKeep}\n" +
                    "\n" +
                    "#################################### fetching all images ##########################################\n" +
                    "existing_images = client.describe_images(Filters=\n" +
                    "        [\n" +
                    "    {\n" +
                    "        'Name': 'name',\n" +
                    "        'Values': [search_amis_to_deregister_by_name,]\n" +
                    "    },\n" +
                    "        ],\n" +
                    "        Owners=['self']\n" +
                    ")\n" +
                    "#################################### searching ami to deregister #####################################\n" +
                    "today=datetime.now().date()\n" +
                    "to_deregister=[]\n" +
                    "print \"ImageId \\tImageDate \\tDays\\n\"\n" +
                    "for i in range(len(existing_images['Images'])) :\n" +
                    "       ami_date=datetime.strptime(existing_images['Images'][i]['CreationDate'].split('T')[0] , '%Y-%m-%d').date()\n" +
                    "       print existing_images['Images'][i]['ImageId'],\"\\t\",ami_date ,\"\\t\",(today - ami_date).days\n" +
                    "       if (today - ami_date).days > days_to_keep_amis :\n" +
                    "               to_deregister.append(existing_images['Images'][i]['ImageId'])\n" +
                    "print to_deregister\n" +
                    "\n" +
                    "#################################### deregistering ami #################################################\n" +
                    "\n" +
                    "for i in range(len(to_deregister)) :\n" +
                    "        deregister_response = client.deregister_image(ImageId=to_deregister[i])\n" +
                    "        print deregister_response\n" +
                    "\n" +
                    "######################  searching snapshots created by to_dregister_amis ###############################\n" +
                    "ami_snapshots_to_delete=[]\n" +
                    "for i in range(len(to_deregister)) :\n" +
                    "       pattern=\"*\" + to_deregister[i] + \"*\"\n" +
                    "       all_snapshots_response = client.describe_snapshots(\n" +
                    "        Filters=[\n" +
                    "    {\n" +
                    "        'Name': 'description',\n" +
                    "        'Values': [\n" +
                    "pattern ,\n" +
                    "    ]\n" +
                    "    },\n" +
                    "        ]\n" +
                    ")\n" +
                    "       for j in range(len(all_snapshots_response['Snapshots'])) :\n" +
                    "               ami_snapshots_to_delete.append(all_snapshots_response['Snapshots'][j]['SnapshotId'])\n" +
                    "print ami_snapshots_to_delete\n" +
                    "\n" +
                    "###################### deleting snapshots created by to_deregister_amis #####################################3\n" +
                    "for i in range(len(ami_snapshots_to_delete)) :\n" +
                    "        delete_snapshot_response = client.delete_snapshot(\n" +
                    "        SnapshotId=ami_snapshots_to_delete[i]\n" +
                    ")\n" +
                    "        print delete_snapshot_response"


            )
        }



        publishers {
            extendedEmail {
                defaultSubject("(${ENV} environment) " + 'scheduled ami backup broke up')
                recipientList('devops@mettl.com')
                defaultContent(
                        '(DEVOPS-ATTENTION $DEFAULT_SUBJECT $BUILD_URL)')
                triggers {
                    failure{
                    }
                }
            }
        }

    }

}


