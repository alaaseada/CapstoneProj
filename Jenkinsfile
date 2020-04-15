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
	    sh 'chmod +x ./Infra/vpc/create.sh && chmod +x ./Infra/cluster/create.sh && chmod +x ./Infra/cluster/getClusterName.sh && chmod +x ./Infra/nodes/create.sh'
            sh './Infra/vpc/create.sh'
            sh './Infra/cluster/create.sh'
	    script {
 	    	clusterName = sh (script: './Infra/cluster/getClusterName.sh',returnStdout: true).trim()
	    }
            sh './Infra/nodes/create.sh $clusterName'
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
