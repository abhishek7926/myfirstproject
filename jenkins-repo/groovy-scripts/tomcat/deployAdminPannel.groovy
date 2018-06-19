//job('Do-Not-Use-AdminPanel-Deployment') {
//  description('deplpoy admin job using job dsl')
//  parameters {
//    stringParam('release_num')
//    choiceParam('ENV', ['de', 'prod'] )
//  }
//  steps {
//    shell('#!/bin/bash\n' +
//      'TOMCAT_FOLDER_NAME=admin-panel-tomcat\n' +
//      'ARTIFACT_NAME=adminPanel\n' +
//      'ANSBILE_HOST_GROUP="${ENV}-admin-panel"\n\n' +
//
//      'ansible-playbook -i /etc/ansible/inventories/${ENV} /etc/ansible/deployment.yml --extra-vars "tomcat_folder_name=${TOMCAT_FOLDER_NAME} ARTIFACT_NAME=${ARTIFACT_NAME} release_num=${release_num} ansible_host_group=${ANSBILE_HOST_GROUP} env=${ENV}"'
//      )
//  }
//}
