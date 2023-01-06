pipeline {
    agent any

    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "Maven"
        git "Git"
        jdk "Jdk"
    }

    stages {
        stage('Build') {
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

		stage('SonarQube analysis'){
			steps{
				withSonarQubeEnv('sonarserver'){
					bat 'mvn clean package sonar:sonar'
				}
			}
		}
	}

}
