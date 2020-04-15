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
    stage('Build Kubernetes cluster') {
	when {
           branch 'development'
        }
        steps {
	        sh 'echo "change permissions"' 
		sh 'chmod +x ./infra/vpc/create.sh && chmod +x ./infra/cluster/create.sh && chmod +x ./infra/cluster/getClusterName.sh && chmod +x ./infra/nodes/create.sh'
		sh './infra/vpc/create.sh' 
		sh './infra/cluster/create.sh'
		script {
 	    	clusterName = sh (script: './infra/cluster/getClusterName.sh',returnStdout: true).trim()
	    	}
		sh './infra/nodes/create.sh $clusterName'
        } 
    }
    stage('Deploy to Kubernetes cluster') {
	when {
           branch 'production'
        }
        steps {
            sh 'echo "docker image to be deployed here"'
	    sh 'chmod +x ./kubernetes/changeTag.sh'
	    sh './kubernetes/changeTag.sh $BUILD_NUMBER'
	    sh 'aws eks --region us-west-2 update-kubeconfig --name $clusterName'
	    sh 'kubectl apply -f ./kubernetes/service.yaml'
	    sh 'kubectl apply -f ./kubernetes/current_deployment.yaml'
        } 
    }
  }
}
