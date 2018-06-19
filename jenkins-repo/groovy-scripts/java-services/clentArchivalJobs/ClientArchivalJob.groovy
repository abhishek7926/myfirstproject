job("ArchiveClient") {
    description("This job will deploy the ArchiveClient on the target server, make sure that you should have password less login enabled to the target server")
    parameters{
        stringParam('versionNum')
        stringParam('clientId')
        stringParam('isExecuteDelete')
    }
    steps {
        shell('#!/bin/bash\n' +
                'ssh -o StrictHostKeyChecking=no mettl@client_archival.xyzpvt "/home/mettl/release/java-services/deployMettlJavaService.sh $versionNum mettl-archival "\n' +
                'ssh -o StrictHostKeyChecking=no mettl@client_archival.xyzpvt "cd /home/mettl/volume1/serviceAssesmblies/mettl-archival/current-installation"\n' +
                'ssh -o StrictHostKeyChecking=no mettl@client_archival.xyzpvt "chmod +x  bin/Archival"\n' +
                'ssh -o StrictHostKeyChecking=no mettl@client_archival.xyzpvt "eval bin/Archival $clientId $isExecuteDelete  >> /home/mettl/mettl_logs/mettl-archival_console.log 2>&1 &"'
        )
    }
}
