stage('Security Scan') {
    steps {
        echo 'Running Trivy scan...'
        bat 'trivy image abhinavcpsingh/myapp:latest'
    }
}