pipeline{
      agent any 
	tools{
                maven 'Maven'
		jdk 'Jdk'
            }
	stage{
		steps{
			sh 'mvn -B -DskipTests clean package'
		}
	}
        
               	     	         
}
