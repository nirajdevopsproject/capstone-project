pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Deploy Dev') {
            steps {
                dir('env/dev') {
                    sh 'terraform init'
                    sh 'terraform apply -auto-approve'
                }
            }
        }

        stage('Deploy Staging') {
            steps {
                dir('env/staging') {
                    sh 'terraform init'
                    sh 'terraform apply -auto-approve'
                }
            }
        }

        stage('Approve Prod') {
            steps {
                input message: 'Approve deployment to PROD?'
            }
        }

        stage('Deploy Prod') {
            steps {
                dir('env/prod') {
                    sh 'terraform init'
                    sh 'terraform apply -auto-approve'
                }
            }
        }
    }
}
