pipeline {
    agent any

    environment {
        DOCKERHUB_USER = "your-dockerhub-username"
        IMAGE_NAME = "sample-app"
    }

    triggers {
        githubPush()   // triggers on GitHub push
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/your-user/your-repo.git'
            }
        }

        stage('Build Image') {
            steps {
                sh "docker build -t ${DOCKERHUB_USER}/${IMAGE_NAME}:latest ."
            }
        }

        stage('Login to DockerHub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'USER',
                    passwordVariable: 'PASS'
                )]) {
                    sh "echo $PASS | docker login -u $USER --password-stdin"
                }
            }
        }

        stage('Push Image') {
            steps {
                sh "docker push ${DOCKERHUB_USER}/${IMAGE_NAME}:latest"
            }
        }

        stage('Run Container') {
            steps {
                sh "docker rm -f myapp || true"
                sh "docker run -d --name myapp -p 8000:8000 ${DOCKERHUB_USER}/${IMAGE_NAME}:latest"
            }
        }
    }

    post {
        always {
            sh "docker logout"
        }
    }
}
i
