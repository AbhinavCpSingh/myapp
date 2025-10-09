pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-login')
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/AbhinavCpSingh/myapp.git', branch: 'main', credentialsId: 'github-token'
            }
        }

        stage('Build') {
            steps {
                echo 'Building Docker image...'
                bat 'docker build -t abhinavcpsingh/myapp:latest .'
            }
        }

        stage('Security Scan') {
            steps {
                echo 'Running Trivy scan...'
                // ✅ Windows-compatible Trivy scan using Docker
                bat 'docker run --rm -v %cd%:/app aquasec/trivy image abhinavcpsingh/myapp:latest'
            }
        }

        stage('Push to Docker Hub') {
            when { expression { currentBuild.resultIsBetterOrEqualTo('SUCCESS') } }
            steps {
                echo 'Pushing Docker image to Docker Hub...'
                bat '''
                docker login -u %DOCKERHUB_CREDENTIALS_USR% -p %DOCKERHUB_CREDENTIALS_PSW%
                docker push abhinavcpsingh/myapp:latest
                '''
            }
        }

        stage('Deploy') {
            steps {
                echo 'Running container to test deployment...'
                bat 'docker run --rm -d -p 8080:8080 abhinavcpsingh/myapp:latest'
            }
        }
    }
}
