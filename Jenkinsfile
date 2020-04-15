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
	        sh 'echo "change permissions"' 
		sh 'chmod +x ./infra/vpc/create.sh && chmod +x ./infra/cluster/create.sh && chmod +x ./infra/cluster/getClusterName.sh && chmod +x ./infra/nodes/create.sh'
		sh './infra/vpc/create.sh' 
		sh './infra/cluster/create.sh'
	 	sh './infra/nodes/create.sh'
		sh './kubernetes/changeTag.sh'
		sh 'infra/cluster/getClusterName.sh'
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
