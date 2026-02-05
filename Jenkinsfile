pipeline {
    agent any

    stages {
        stage('Clone Git Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/nirajdevopsproject/capstone-project.git'
            }
        }

        stage('Verify Clone') {
            steps {
                // List all files to confirm clone
                sh 'ls -la'
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished.'
        }
    }
}
