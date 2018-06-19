class MyJob{
  public String jobName
  public String artifactName
  public String tomcatFolderName
  public String server
  MyJob(jobName,artifactName, tomcatFolderName, server){
    this.jobName=jobName
    this.artifactName=artifactName
    this.tomcatFolderName=tomcatFolderName
    this.server=server
  }
}
def jobList = [new MyJob('DishaWebTcmap', 'disha-web', 'disha-web-tomcat', 'web-tcmap'),
               new MyJob('DishaLocation', 'location-server-app', 'location-server-app-tomcat', 'location'),
               new MyJob('DishaUsername', 'disha-username', 'disha-username-tomcat', 'username'),
               new MyJob('DishaIfsc', 'disha-Ifsc', 'disha-ifsc-tomcat', 'ifsc'),
               new MyJob('DishaEligibility', 'eligibility-service', 'eligibility-app-tomcat', 'eligibility'),
               new MyJob('DishaPmgdishaInfo', 'ndlm', 'pmg-disha-tomcat', 'pmgdisha_info'),
               new MyJob('Biometric', 'biometric', 'biometric-tomcat', 'biometric'),
               new MyJob('BiometricAdmin', 'biometricAdmin', 'biometricAdmin-tomcat', 'biometric-admin'),
               new MyJob('CertificateApp', 'disha-certificate', 'disha-certificate-tomcat', 'certificate'),
               new MyJob('PracticeApp', 'practice-test-web', 'practice-test-tomcat', 'practice'),
]

jobList.each{ k ->
  serverUrl="${k.server}.${InternalDomain}"
  job("Generic${k.jobName}Deployer") {
    description("This job will deploy the ${k.jobName} on the target server, make sure that you should have password less login enabled to the target server")
    parameters{
      stringParam('versionNum')
    }
    steps {
      shell('#!/bin/bash\n' +


        'ssh -o StrictHostKeyChecking=no mettl@'+"${serverUrl}"+ ' "release/tomcat/stopServer.sh '+ "${k.tomcatFolderName}"+'"\n'+
        'ssh -o StrictHostKeyChecking=no mettl@'+"${serverUrl}"+ ' "release/tomcat/deployMettlWebApp.sh $versionNum '+ "${k.artifactName}"+'"\n'+
        'ssh -o StrictHostKeyChecking=no mettl@'+"${serverUrl}"+ ' "release/tomcat/startServer.sh '+ "${k.tomcatFolderName}"+'"\n'
        )
    }
  }

    job("GenericStop${k.jobName}") {
        description("This job will stop the ${k.jobName} on the target server, make sure that you should have password less login enabled to the target server")
        steps {
            shell('#!/bin/bash\n' +

                    'ssh -o StrictHostKeyChecking=no mettl@'+"${serverUrl}"+ ' "release/tomcat/stopServer.sh '+ "${k.tomcatFolderName}"+'"\n'

            )
        }
    }

    job("GenericStart${k.jobName}") {
        description("This job will start the ${k.jobName} on the target server, make sure that you should have password less login enabled to the target server")
        steps {
            shell('#!/bin/bash\n' +

                    'ssh -o StrictHostKeyChecking=no mettl@'+"${serverUrl}"+ ' "release/tomcat/startServer.sh '+ "${k.tomcatFolderName}"+'"\n'

            )
        }
    }

    job("GenericRestart${k.jobName}") {
        description("This job will stop the ${k.jobName} on the target server, make sure that you should have password less login enabled to the target server")
        steps {
            shell('#!/bin/bash\n' +

                    'ssh -o StrictHostKeyChecking=no mettl@'+"${serverUrl}"+ ' "release/tomcat/stopServer.sh '+ "${k.tomcatFolderName}"+'"\n'+
                    'ssh -o StrictHostKeyChecking=no mettl@'+"${serverUrl}"+ ' "release/tomcat/startServer.sh '+ "${k.tomcatFolderName}"+'"\n'

            )
        }
    }
}

