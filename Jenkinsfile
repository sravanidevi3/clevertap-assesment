pipeline {
    agent any
    stages {
        stage('Build'){
            steps{
                script{
                docker.withRegistry("https://900024488048.dkr.ecr.us-east-1.amazonaws.com", "ecr:us-east-1:Wordpress") {
                    def wordPressImage = docker.build("900024488048.dkr.ecr.us-east-1.amazonaws.com/bala-clever-tap:wordpress_${BUILD_NUMBER}")            
                     wordPressImage.push()
                    }
                }
            }
        }
        stage('Deploy'){
          dir('terraform'){
            steps{
                sh 'terraform init' 
                sh 'terraform validate'
                sh 'sleep 10'
                sh 'terraform apply -var="tag=wordpress_${BUILD_NUMBER}" -auto-approve'
            }
          }
        }
    }
}
  
  
