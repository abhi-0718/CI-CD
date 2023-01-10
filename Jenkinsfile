// def user
// node {
//     wrap([$class: 'BuildUser']) {
//         user = env.BUILD_USER_ID
//     }
  
//     emailext mimeType: 'text/html',
//                     subject: "[Jenkins]${currentBuild.fullDisplayName}",
//                     to: "abhishek09dubey85@gmail.com",
//                     body: '''<a href="${BUILD_URL}input">click to approve</a>'''
// }


pipeline {
    environment{
        dockerImage = ''
    }
    agent any
    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "Maven"
        git "Git"
        jdk "Jdk"
	dockerTool "Docker"
    }

    stages {
        stage('1.Code Build and Analysis of Code') {
            steps {
                // Get some code from a GitHub repository
                //git 'https://github.com/jglick/simple-maven-project-with-tests.git'
                
                // To run Maven on a Windows agent, use
				echo '-----------------Building code-----------------------'
                
                // bat "mvn clean package"
                withSonarQubeEnv('sonarserver'){
					bat 'mvn clean sonar:sonar'
			bat 'mvn package'
			bat 'mvn clean'
                    echo '---------------Code Build and analysis of code is successfull---------------------'
				}
            }

            post {
                // If Maven was able to run the tests, even if some of the test
                // failed, record the test results and archive the jar file.
                success {
                    echo 'Successfully Build'
            	}
        	}
    	}


		stage('Quality Gate Check'){
			steps{
				timeout(time: 1, unit: 'HOURS') {
                    // Parameter indicates whether to set pipeline to UNSTABLE if Quality Gate fails
                    // true = set pipeline to UNSTABLE, false = don't
                    waitForQualityGate abortPipeline: true
                }
			}
		}

        stage('Selenium Testing'){
            steps{
                echo '-----------------------------SELENIUM TESTING COMPLLETED------------------------------'
            }
        }


        stage('3.Building image') {
            steps{
                script {
                    echo '---------------------------Building Image----------------------------------'
                    bat 'docker build . -t habhi/ci_cd_qa'
                    echo '---------------------------Image Successfully Build---------------------------------'
		            bat 'docker images'
                }
            }
        }

        stage('4.Deploy image to DockerHub') {
            steps{
                script{
                    echo '-----------------------------Deploying Image----------------------------------------'
                    docker.withRegistry('', 'Docker_ID') {
                        bat 'docker push habhi/ci_cd_qa'
                        echo '-------------------------Image Successfully pushed--------------------------------'
                    }
                } 
            }
        }

        stage('Email Approval from Lead') {
            input {
                message "Should we continue?"
                ok "Yes"
            }
//             when {
//                 expression { user == env.BUILD_USER_ID}
//             }
            steps {
                echo  "deployment"
            }
        }
       
	}

}
