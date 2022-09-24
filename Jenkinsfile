pipeline {
  agent { label 'master' }
   environment {
     HOST_NAME="192.168.150.128"
     DOCKER_HOST="192.168.150.128"
     USER_ID="dockeradmin"
   }
  stages {
    stage('Source') { // Get code
      steps {
        // get code from our Git repository
        git 'https://github.com/saikrishna2653/SpringBoot-Registration-Login.git'
      }
    }
  /*  stage('Compile') { // Compile and do unit testing
      tools {
        maven 'maven3'
      }
      steps {
        // run Gradle to execute compile and unit testing
        sh 'mvn clean install package'
      }
    } 
   stage('Build and Push Docker images to Hub'){
	steps {  
      sshagent(['deploy_user']) {
         sh '''		 
	 scp /var/jenkins_home/workspace/login-appln-k8s-deploy/target/Spring-Full-Security-1.0-SNAPSHOT.war Dockerfile $USER_ID@$DOCKER_HOST:/opt/docker;
	 ssh $USER_ID@$DOCKER_HOST docker image rm -f login_registration || true;
	 ssh $USER_ID@$DOCKER_HOST "cd /opt/docker && pwd && ls -lrt && docker build -t login_registration . ";  
         ssh $USER_ID@$DOCKER_HOST docker tag login_registration saikrishna2653/login_registration;  
         ssh $USER_ID@$DOCKER_HOST docker push saikrishna2653/login_registration; 	
         '''
         }	  
     }
   } 	*/  
    stage('Copy manifest files to server') { 
	 steps {   
      dir('kubernetes-my-appln') {
        sh ''' 	
		   
          #
          # copy files to server
          #
          chmod +x k8s-deploy.sh
	  sed -i -e 's/\r$//' k8s-deploy.sh
	  echo ${HOST_NAME}
	  echo ${USER_ID}
	      
          su dockeradmin -c './k8s-deploy.sh "${HOST_NAME}" "${USER_ID}"'
        '''		
      }
    }
  }

	stage('Deploy in to Kubernetes pods') { 
	 steps {   
      dir('kubernetes-my-appln') {
        sh ''' 	
		   
          #
          # copy files to server
          #
	 su dockeradmin -c 'ssh $USER_ID@$HOST_NAME "kubectl delete -f /opt/kubernetes_Deloy/crud-app-service.yml; kubectl delete -f /opt/kubernetes_Deloy/crud-app-deploy.yml;"' 
         su dockeradmin -c 'ssh $USER_ID@$HOST_NAME "kubectl apply -f /opt/kubernetes_Deloy/crud-app-deploy.yml; kubectl apply -f /opt/kubernetes_Deloy/crud-app-service.yml"'
        '''		
      }
    }
  }

  }
}
