currentBuild.displayName="Community-Announcement-Portal-#"+currentBuild.number
pipeline {
    agent any
     tools {
       maven 'maven'
     }
     environment {
      DOCKER_TAG = getDockerTag()
      BRANCH_NAME = "${GIT_BRANCH.split("/")[0]}"
     }

    stages {
        stage('Git Checkout') {
            steps {
                git branch: BRANCH_NAME, credentialsId: 'git_credential', url: 'https://github.com/rakeshkumar1019/java-jsp-diary.git'
            }
        }
        
        stage('Maven Build') {
            steps {
                sh "mvn clean package"
                sh "mv target/*.war target/myweb.war"
            }
        }
        
       
      
        
        
       stage('Build Docker Image') {
            steps {
              sshagent(['k8password']) {
                  sh """
                   docker build . -t rakesh1019/javahome:${DOCKER_TAG}
                  """
               } 
            }
        }
        
         stage('DockerHub Push Image') {
            steps {
                 withCredentials([string(credentialsId: 'docker-hub', variable: 'dockerHubPwd')]) {
                      sh "docker login -u rakesh1019 -p ${dockerHubPwd}"
                      sh "docker push rakesh1019/javahome:${DOCKER_TAG}"
                 }
            }
        }
        
        stage('Deploying tomcat on k8s ') {
            steps {
                 sh "chmod +x changeTag.sh"
                 sh "./changeTag.sh ${DOCKER_TAG}"
                 echo BRANCH_NAME
                 script{

                    if(BRANCH_NAME == "master") { 
                         echo "master"
                        sshagent(['k8password']) {
                                sh "scp -o StrictHostKeyChecking=no services.yml java-app-pod.yml centos@13.127.47.7:/home/centos/"
                                try{
                                    sh "ssh centos@13.127.47.7 kubectl apply -f . "      
                                }catch(error){
                                    sh "ssh centos@13.127.47.7 kubectl create -f . "      
                                }   
                        }
                    }


                    if(BRANCH_NAME == "development") {
                      echo "dev"
                       sshagent(['k8password']) {
                                sh "scp -o StrictHostKeyChecking=no services.yml java-app-pod.yml centos@52.66.243.106:/home/centos/"
                                try{
                                    sh " ssh centos@52.66.243.106 kubectl apply -f . "      
                                }catch(error){
                                    sh " ssh centos@52.66.243.106 kubectl create -f . "      
                                }   
                        }
                    }


                    if(BRANCH_NAME == "staging") {
                        echo "staging"
                        sshagent(['k8password']) {
                                sh "scp -o StrictHostKeyChecking=no services.yml java-app-pod.yml centos@35.154.231.241:/home/centos/"
                                try{
                                    sh " ssh centos@35.154.231.241 kubectl apply -f . "      
                                }catch(error){
                                    sh " ssh centos@35.154.231.241 kubectl create -f .  "      
                                }   
                        }

                    }


                 }


            }
       }
        
        
      
        
    }
}

def getDockerTag(){
     def tag = sh script: 'git rev-parse HEAD', returnStdout: true
     return tag
}




