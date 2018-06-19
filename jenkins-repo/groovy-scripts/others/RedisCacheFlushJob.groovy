serverUrl="redis.${InternalDomain}"
job("GenericRedisCacheFlushDeployer") {
    description("This job will Clear Redis Cache")
    steps {
        shell('#!/bin/bash\n' +
                'ssh -o StrictHostKeyChecking=no mettl@'+"${serverUrl}"+ " \"redis-cli flushall\"\n"
        )
    }
}
