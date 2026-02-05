pipeline {
    agent any

    stages {
        stage('Clone Git Repository') {
            steps {
                // Cloning the repository from GitHub
                git branch: 'main', url: 'https://github.com/your-username/your-repo.git'
            }
        }

        stage('List Files') {
            steps {
                // Optional: List files to verify clone
                sh 'ls -la'
            }
        }
    }

    post {
        always {
            echo 'Git clone stage finished.'
        }
    }
}
