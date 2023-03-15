def call(String buildStatus = 'STARTED') {
    buildStatus = buildStatus ?: 'SUCCESS'
    def color
    if (buildStatus == 'SUCCESS') {
        color = '#47ec05'
    } else if (buildStatus =='UNSTABLE') {
        color = '#d5ee0d'
    } else {
        color = '#ec2805'
    }

    def msg = "${buildStatus}: '${env.JOB_NAME}' #${env.BUILD_NUMBER}:\n${env.BUILD_URL}"

    slackSend(color: color, message: msg)
}

//in jenkinsfile in the top: @library('slack') _
 post{
    // Use sendNotification.groovy from shared library and provide current build result as paramater
    sendNotification currentBuild.result
 }