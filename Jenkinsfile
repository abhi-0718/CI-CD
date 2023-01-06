pipeline {
    agent any
    tools {
        maven "Maven"
        jdk "Jdk"
    }
    stages {
        stage('Initialize'){
            steps{
                echo "PATH = ${M2_HOME}/bin:${PATH}"
                echo "M2_HOME = /opt/maven"
            }
        }
        stage('Build') {
            steps {
                dir("https://github.com/abhi-0718/AWSBasedDeployment/tree/main/my-app/src/main/java/com/mycompany/app"){
                sh 'mvn -B -DskipTests clean package'
                }
            }
        }
     }
    post {
       always {
          junit(
        allowEmptyResults: true,
        testResults: '*/test-reports/.xml'
      )
      }
   } 
}
