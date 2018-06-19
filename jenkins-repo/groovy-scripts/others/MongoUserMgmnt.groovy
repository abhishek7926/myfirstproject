//job('Devops-Manage-Mongo-User') {
//  description('add,remove or list light/heavy mongo db users')
//  parameters {
//    choiceParam('type', ['light', 'heavy'] )
//    choiceParam('action',['showusers','adduser','removeuser'])
//    stringParam('username')
//    nonStoredPasswordParam('password')
//    stringParam('roles')
//
//  }
//  steps {
//    shell('#!/bin/bash\n' +
//            'if [ "$type" == "light" ]; then\n' +
//            '    host="mettl/mongo-light-new.'+"${InternalDomain}"+',mongo-light-member2.'+"${InternalDomain}" +'"\n' +
//            '    dbadmin_username="mettl-db-user-admin-light-'+"${ENV}" +'"\n' +
//            '  dbadmin_password="'+"${MongoLightMettlAdminPwd}" +'"\n' +
//            'elif [ "$type" == "heavy" ]; then\n' +
//            '    host="mettl/mongo-primary-new.'+"${InternalDomain}"+',mongo-primary-member2.'+"${InternalDomain}"+'"\n' +
//            '    dbadmin_username="mettl-db-user-admin-heavy-'+"${ENV}"+'"\n' +
//            '  dbadmin_password="'+"${MongoHeavyMettlAdminPwd}" +'"\n' +
//            'fi\n' +
//            '  if [ "$action" == "showusers" ]; then\n' +
//            '       mongo -host $host -u $dbadmin_username  -p $dbadmin_password Mettl <<EOF\n' +
//            '       use Mettl\n' +
//            '       db.system.users.find().pretty();\n' +
//            'EOF\n' +
//            '  elif [ "$action" == "adduser" ]; then\n' +
//            '       mongo -host $host -u $dbadmin_username  -p $dbadmin_password Mettl <<EOF\n' +
//            '       use Mettl\n' +
//            '       db.addUser( { user: "${username}",\n' +
//            '                   pwd: "${password}",\n' +
//            '                   roles: [ ${roles} ]\n' +
//            '                 } )\n' +
//            'EOF\n' +
//            '  elif [ "$action" == "removeuser" ]; then\n' +
//            '       mongo -host $host -u $dbadmin_username  -p $dbadmin_password Mettl <<EOF\n' +
//            '       use Mettl\n' +
//            '       db.system.users.find().pretty();\n' +
//            'EOF\n' +
//            '       mongo -host $host -u $dbadmin_username  -p $dbadmin_password Mettl <<EOF\n' +
//            '       use Mettl\n' +
//            '       db.removeUser("${username}")\n' +
//            'EOF\n' +
//            '       mongo -host $host -u $dbadmin_username  -p $dbadmin_password Mettl <<EOF\n' +
//            '       use Mettl\n' +
//            '       db.system.users.find().pretty();\n' +
//            'EOF\n' +
//            '  fi'
//
//
//
//    )
//  }
//}