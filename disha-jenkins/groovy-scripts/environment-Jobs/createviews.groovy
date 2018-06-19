listView('1.Deployment-Jobs') {
    columns{
        status()
        weather()
        name()
        lastSuccess()
        lastFailure()
        lastDuration()
    }
    jobs {
        regex('(?i)(?!.*devops)deploy.*')
    }
}

listView('2.Start-Jobs') {
    columns{
        status()
        weather()
        name()
        lastSuccess()
        lastFailure()
        lastDuration()
    }
    jobs {
        regex('(?i)(?!.*devops)start.*')
    }
}

listView('3.Stop-Jobs') {
    columns{
        status()
        weather()
        name()
        lastSuccess()
        lastFailure()
        lastDuration()
    }
    jobs {
        regex('(?i)(?!.*devops)stop.*')
    }
}

listView('4.Restart-Jobs') {
    columns{
        status()
        weather()
        name()
        lastSuccess()
        lastFailure()
        lastDuration()
    }
    jobs {
        regex('(?i)(?!.*devops)restart.*')
    }
}

listView('5.GENERIC-JOBS') {
    columns{
        status()
        weather()
        name()
        lastSuccess()
        lastFailure()
        lastDuration()
    }
    jobs {
        regex('(?i)(?!.*devops)generic.*')
    }
}

listView('6.DevOps-Jobs') {
    columns{
        status()
        weather()
        name()
        lastSuccess()
        lastFailure()
        lastDuration()
    }
    jobs {
        regex('(?i)(?=.*devops).*')
    }
}