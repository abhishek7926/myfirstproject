serverUrl="redis-user-session.${InternalDomain}"
job("GenericRedisUserSessionCacheFlushDeployer") {
    description("This job will Clear Redis Cache")
    steps {
        shell(
                '#!/bin/bash\n' +
                'redis-cli -h '+"${serverUrl}"+  ' -p 6379 flushall'


        )
    }
}
