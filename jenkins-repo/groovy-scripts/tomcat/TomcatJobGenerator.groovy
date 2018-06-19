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
def jobList = [new MyJob('Corporate', 'mettl-ui', 'corporate-tomcat', 'corporate'),
               new MyJob('SharedReportCorporate', 'mettl-ui', 'shared-report-corporate-tomcat', 'shared-report-corporate'),
               new MyJob('Contest','contest','contest-tomcat','contest'),
               new MyJob('AdminPanel','adminPanel','adminPanel-tomcat','adminpanel'),
               new MyJob('PreLogin','preLogin','prelogin-tomcat','prelogin'),
               new MyJob('Certification','certification-web','certification-tomcat','certification'),
               new MyJob('LMS','mettl-lms-app','mettl-lms-app-tomcat','lms'),
               new MyJob('ApiDemo','mettl-api-demo','mettl-api-demo-tomcat','api-demo'),
               new MyJob('360Feedback','360Degree-web','360Feedback-tomcat','360feedback'),
               new MyJob('IGT','igt-web','igt-web-tomcat','igt'),
               new MyJob('HPE','hpe-web','hpe-web-tomcat','hpe'),
               new MyJob('NDLM',' ndlm','ndlm-tomcat','ndlm-info'),
               new MyJob('ChatService',' chatService','chatService-tomcat','chat-service'),
               new MyJob('MettlNotificationApp',' Notification','notification-tomcat','notification'),
               new MyJob('MobileApp',' mobileApp','mobileApp-tomcat','offline-app'),
               new MyJob('DuoLingo','manualProctoringApis','manualProctoringApis-tomcat','duo-lingo'),
               new MyJob('ClientApi', 'clientApi', 'client-api-tomcat', 'client-api'),
               new MyJob('Feedback', 'feedback', 'feedback-tomcat', 'feedback'),
               new MyJob('TestNotification', 'MettlTestNotificationApp', 'MettlTestNotificationApp-tomcat', 'test-notification'),
               new MyJob('Uber', 'candidate-custom-registration', 'candidate-custom-registration-tomcat', 'uber'),
               new MyJob('ProctoringUi', 'proctoring-ui', 'proctoring-ui-tomcat', 'proctoring-ui'),
               new MyJob('mongo-api', 'mongo-api', 'mongo-client-archival-tomcat', 'mongo_client_archival'),
               new MyJob('StatusApp', 'StatusApp', 'status-mettl-tomcat', 'status-mettl'),
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

