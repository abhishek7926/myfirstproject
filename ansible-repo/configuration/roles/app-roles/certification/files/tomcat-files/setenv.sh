export CATALINA_OPTS="$CATALINA_OPTS -XX:MaxPermSize=1024m -XX:+CMSPermGenSweepingEnabled -XX:+CMSClassUnloadingEnabled -Xms512m -Xmx6000m -Dcom.sun.management.jmxremote.port=8090 -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/home/mettl/mettl_logs/"
