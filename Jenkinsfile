pipeline {
    agent any

    stages {
        stage('Clone Git Repository') {
            steps {
                // Clone the repository
                git branch: 'main', url: 'https://github.com/nirajdevopsproject/capstone-project.git'
            }
        }

        stage('Verify Clone') {
            steps {
                // Show current directory
                sh 'pwd'
                
                // List all files to confirm repo clone
                sh 'ls -la'
            }
        }
    }
}
