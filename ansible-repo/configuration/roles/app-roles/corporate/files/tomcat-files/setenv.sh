export CATALINA_OPTS="$CATALINA_OPTS -XX:MaxPermSize=1024m -XX:+CMSPermGenSweepingEnabled -XX:+CMSClassUnloadingEnabled -Xms512m -Xmx8192m -Dcom.sun.management.jmxremote.port=9999 -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.local.only=false -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/home/mettl/mettl_logs/"