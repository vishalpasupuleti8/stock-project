pipeline {
    agent any
    
    environment {
        DOCKER_IMAGE_NAME = 'vishalpasupuleti/flask-app-polygon'
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image
                    docker.build("${DOCKER_IMAGE_NAME}")
                }
            }
        }

       stage('push Docker Image') {
            steps {
                script {
                withCredentials([string(credentialsId: 'dockerhub-pwd', variable: 'dockerhubpwd')]) {
                sh 'docker login -u vishalpasupuleti -p ${dockerhubpwd}'
                sh 'docker push vishalpasupuleti/flask-app-polygon'
            }
        }
      }
    }
  }
}
