pipeline {
    agent any

    environment {
        GIT_REPO = 'https://github.com/nirajdevopsproject/capstone-project'
        GIT_BRANCH = 'main'
    }

    stages {
        stage('Checkout') {
            steps {
                // Jenkins handles Git clone automatically
                git branch: "${GIT_BRANCH}", url: "${GIT_REPO}"
            }
        }

        stage('Intializing ec2 module') {
            steps {
                dir('module/ec2') {
                    sh 'terraform init'
                }
            }
        }
        stage('Intializing rds module') {
            steps {
                dir('module/rds') {
                    sh 'terraform init'
                }
            }
        }

        stage('Intializing vpc module') {
            steps {
                dir('module/vpc') {
                    sh 'terraform init'
                }
            }
        }
        
        stage('Intializing s3-dr module') {
            steps {
                dir('module/s3-dr') {
                    sh 'terraform init'
                }
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
