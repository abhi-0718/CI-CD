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
    }

    stages {
        stage('1.Code Build') {
            steps {
                // Get some code from a GitHub repository
                //git 'https://github.com/jglick/simple-maven-project-with-tests.git'
                
                // To run Maven on a Windows agent, use
				echo 'Building....'
                bat "mvn -Dmaven.test.failure.ignore=true clean package"
            }

            post {
                // If Maven was able to run the tests, even if some of the test
                // failed, record the test results and archive the jar file.
                success {
                    echo 'Successfully Build'
            	}
        	}
    	}

		stage('2.SonarQube analysis'){
			steps{
				withSonarQubeEnv('sonarserver'){
					bat 'mvn clean package sonar:sonar'
				}
			}
		}

		// stage('Quality Gate Check'){
		// 	steps{
		// 		timeout(time: 1, unit: 'HOURS') {
        //             // Parameter indicates whether to set pipeline to UNSTABLE if Quality Gate fails
        //             // true = set pipeline to UNSTABLE, false = don't
        //             waitForQualityGate abortPipeline: true
        //         }
		// 	}
		// }

        stage('3.Building image') {
            steps{
                script {
                    echo 'Building Image'
                    bat 'docker build . -t cloudbased-deployment'
                    echo 'Image Successfully Build'
		    bat 'docker images'
                }
            }
        }

        stage('4.Deploy image to ECR') {
            steps{
                script{
                    echo 'Deploying Image'
                    docker.withRegistry('https://795361990663.dkr.ecr.us-east-1.amazonaws.com/cloudbased-deployment', 'ecr:us-west-1:AWS Credentials') {
//                         bat 'cloudbased-deployment.push("${env.BUILD_NUMBER}")'
                        bat'cloudbased-deployment.push("latest")'
                        echo 'Image Successfully pushed'
                    }
                }
            }
        }


	}

}
