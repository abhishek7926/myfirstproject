class MyJob{
    public String volId
    public String dataService
    public String snapshotsToKeep
    MyJob(volId, dataService,snapshotsToKeep){
        this.volId=volId
        this.dataService=dataService
        this.snapshotsToKeep=snapshotsToKeep
    }

}
def jobList = [new MyJob("${fes_volume_id}",'Fes',15),
               new MyJob("${skillmaster_admin_volume_id}",'Skillmaster-admin' ,15),
               new MyJob("${skillmaster_special_volume_id}",'Skillmaster-special',15),
               new MyJob("${skillmaster_general_volume_id}",'Skillmaster-general',15),
               new MyJob("${igt_volume_id}",'Igt',15),
               new MyJob("${static_volume_id}",'Static',15),
               new MyJob("${fhgfs_volume_id}",'Fhgfs',15),
               new MyJob("${master_1_elasticsearch_volume_id}",'Master-1-elasticsearch',15),
               new MyJob("${master_2_elasticsearch_volume_id}",'Master-2-elasticsearch',15),
               new MyJob("${master_3_elasticsearch_volume_id}",'Master-3-elasticsearch',15),
               new MyJob("${data_1_elasticsearch_volume_id}",'Data-1-elasticsearch',15),
               new MyJob("${data_2_elasticsearch_volume_id}",'Data-2-elasticsearch',15),
               new MyJob("${labs_1_user_volume_id}",'Labs-1-user',15),
               new MyJob("${labs_2_user_volume_id}",'Labs-2-user',15)


]

jobList.each { k ->
    job("Create-${k.dataService}-Volume-Backup") {
        description("This job will create the snapshot of ${k.dataService} ")
        triggers {
            cron('@midnight')
        }

        steps {
            shell('#!/usr/bin/env python\n' +

//                    " /var/lib/jenkins/jobs/new_create_volume_snapshot.py \"${k.volId}\" \"${k.dataService}\" \"${k.snapshotsToKeep}\"  \"${ENV}\""
                    "import sys\n" +
                    "import os\n" +
                    "import json\n" +
                    "from datetime import datetime, date, time, timedelta\n" +
                    "volume_id=\"${k.volId}\"\n" +
                    "service_name=\"${k.dataService}\"\n" +
                    "days_to_keep_snapshot=${k.snapshotsToKeep}\n" +
                    "mettl_environment=\"${ENV}\"\n" +
                    "snapshot_token=mettl_environment+\"_\"+service_name+\"_will be deleted automcatically by scripts\"\n" +
                    "cut_off_date = datetime.utcnow() - timedelta(days=days_to_keep_snapshot)\n" +
                    "print \"cut off date for deleting is\", cut_off_date\n" +
                    "\n" +
                    "\n" +
                    "snapshot_description= '%s%s'%(str(date.today()),snapshot_token)\n" +
                    "print \"creating snapshot with description -%s\"%snapshot_description\n" +
                    "os.system('aws ec2 create-snapshot --volume-id \"%s\" --region ${awsRegion} --description \"%s\"'%(volume_id,snapshot_description))\n" +
                    "\n" +
                    "f = os.popen('aws ec2 describe-snapshots --region ${awsRegion} --filters Name=volume-id,Values=\"%s\" Name=description,Values=\"*%s\"'%(volume_id,snapshot_token))\n" +
                    "snapshots_json = f.read()\n" +
                    "snapshots_obj = json.loads(snapshots_json)\n" +
                    "snapshots_list=snapshots_obj['Snapshots']\n" +
                    "for one_snapshot in snapshots_list:\n" +
                    "\tsnapshot_id=one_snapshot['SnapshotId']\n" +
                    "\tsnapshot_start_time=one_snapshot['StartTime']\n" +
                    "\tsnapshot_date_arr=snapshot_start_time.split(\"T\")\n" +
                    "\tsnapshot_date = datetime.strptime(snapshot_date_arr[0],'%Y-%m-%d')\n" +
                    "\tprint \"start_date of snapshot id %s is %s\"%(snapshot_id,snapshot_date)\n" +
                    "\tif(cut_off_date>snapshot_date):\n" +
                    "        \tprint \"deleting\", snapshot_id\n" +
                    "\t\tdeletion_command='aws ec2 delete-snapshot --region ${awsRegion} --snapshot-id %s'%snapshot_id\n" +
                    "\t\tprint \"command to be executed -\", deletion_command\n" +
                    "\t\tos.system(deletion_command)\n" +
                    "\t\tprint  snapshot_id,\"deleted\"\n" +
                    "\telse:\n" +
                    "\t\tprint \"not deleting\", snapshot_id"
            )
        }



        publishers {
            extendedEmail {
                defaultSubject("(${ENV} environment) " + 'scheduled ebs snapshot backup broke up')
                recipientList('devops@mettl.com')
                defaultContent(
                        '(DEVOPS-ATTENTION $DEFAULT_SUBJECT')
                triggers {
                    failure {
                    }
                }
            }
        }

    }

}
