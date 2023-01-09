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
					bat 'mvn clean package sonar:sonar'
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

        stage('3.Building image') {
            steps{
                script {
                    echo '---------------------------Building Image----------------------------------'
                    bat 'docker build . -t ci_cd_dev'
                    echo '---------------------------Image Successfully Build---------------------------------'
		            bat 'docker images'
                }
            }
        }

       
	}

}
