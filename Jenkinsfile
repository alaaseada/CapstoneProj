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
	        sh 'echo "test vpc here"'                                                                                    
		sh 'chmod +x ./Infra/vpc/create.sh'     
		sh './Infra/vpc/create.sh' 
        } 
    }
    stage('Deploy to Kubernetes cluster') {
	when {
           branch 'production'
        }
        steps {
            sh 'echo "docker image to be deployed here"'
        } 
    }
  }
}
