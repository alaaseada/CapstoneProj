pipeline {
  environment {
	registry = "aseada/asblog_repo"
        dockerImage = ""
        registryUrl = 'https://index.docker.io/v1/'
        registryCredential = 'dockerhub'
  }
	
  agent any

  stages {
     stage ('Lint') {
       steps {
         sh 'echo "Lint the Dockerfile"'
         sh 'make lint'
       }
     }
     stage('Build Image') {
       steps {
         script {
            dockerImage = docker.build registry +":$BUILD_NUMBER"
	 }
       }
    }
    stage('Deploy Image') {
      steps {
	script {
	      docker.withRegistry('', registryCredential) {
	        dockerImage.push()
	      }
	    }
        }
    }
    stage('Remove unused Docker images'){
      steps {
	sh 'docker rmi $registry:$BUILD_NUMBER'
      }
    }
  }
}
