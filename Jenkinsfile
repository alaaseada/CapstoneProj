pipeline {
  environment {
	registry = "aseada/asblog_repo"
        dockerImage = ""
        registryCredential = 'dockerhub'
	clusterName = ''
  }
  agent any
  stages {
     stage ('Lint') {
       steps {
         sh 'echo "Lint the Dockerfile"'
         sh 'make lint'
       }
     }
    stage('Build Kubernetes cluster') {
	when {
           branch 'development'
        }
        steps {
	        sh 'echo "test say hello here"'                                                                                    
		sh 'chmod +x ./sayHello.sh'     
		sh './sayHello.sh' 
        } 
    }
    stage('Deploy to Kubernetes cluster') {
	when {
           branch 'production'
        }
        steps {
            sh 'echo "docker image to be deployed here"'
	    sh 'chmod +x ./sayHello.sh'
	    sh './sayHello.sh'
        } 
    }
  }
}
