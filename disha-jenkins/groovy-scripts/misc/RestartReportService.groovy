serverUrl="reporting-database-updator.${InternalDomain}"
job("Restart-Reporting-DB-Update-Service") {
    steps {
        shell('#!/bin/bash\n' +
                'start=`date +%s`\n' +
                "while ! nc -w 1 -z ${serverUrl} 22\n" +
                'do\n' +
                'echo "waiting target server availability for 10 seconds"\n' +
                'sleep 10\n' +
                'done\n' +
                'end=`date +%s`\n' +
                'DIFF=$(( $end - $start ))\n' +
                'echo "Waited for $DIFF seconds for the target server"\n'+
                'ssh -o StrictHostKeyChecking=no mettl@'+"${serverUrl}"+ ' "release/misc/startReportDbUpdaterService.sh '+ "${ENV} disha-report -Xmx7000M "+'"\n'
        )
    }
}
