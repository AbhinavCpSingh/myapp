pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-login')
        IMAGE_NAME = 'abhinavcpsingh/myapp'
        TAG = 'latest'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    credentialsId: 'github-token',
                    url: 'https://github.com/AbhinavCpSingh/myapp.git'
            }
        }

        stage('Build') {
            steps {
                echo 'Building Docker image...'
                bat '''
docker build -t %IMAGE_NAME%:%TAG% .
'''
            }
        }

        stage('Security Scan') {
            steps {
                echo 'Running Trivy scan...'
                bat '''
docker run --rm -v //var/run/docker.sock:/var/run/docker.sock aquasec/trivy image %IMAGE_NAME%:%TAG% || exit /b 0
'''
            }
        }

        stage('Push to Docker Hub') {
            steps {
                echo 'Pushing image to Docker Hub...'
                bat '''
echo %DOCKERHUB_CREDENTIALS_PSW% | docker login -u %DOCKERHUB_CREDENTIALS_USR% --password-stdin
docker push %IMAGE_NAME%:%TAG%
docker logout
'''
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying Docker container...'
                bat '''
FOR /F "tokens=*" %%i IN ('docker ps -q --filter "name=myapp"') DO docker stop %%i && docker rm %%i
docker run -d -p 5000:5000 --name myapp %IMAGE_NAME%:%TAG%
docker ps
'''
            }
        }
    }
}