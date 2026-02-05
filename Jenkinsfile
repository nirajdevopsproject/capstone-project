pipeline {
    agent any

    environment {
        GIT_REPO = 'https://github.com/nirajdevopsproject/capstone-project'
        GIT_BRANCH = 'main'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: "${GIT_BRANCH}", url: "${GIT_REPO}"
            }
        }

        stage('Deploy Dev') {
            steps {
                withAWS(credentials: 'aws-terraform-creds', region: 'ap-south-1') {
                    dir('env/dev') {
                        sh 'terraform init'
                        sh 'terraform apply -auto-approve'
                    }
                }
            }
        }

        stage('Deploy Staging') {
            steps {
                withAWS(credentials: 'aws-terraform-creds', region: 'ap-south-1') {
                    dir('env/staging') {
                        sh 'terraform init'
                        sh 'terraform apply -auto-approve'
                    }
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
                withAWS(credentials: 'aws-terraform-creds', region: 'ap-south-1') {
                    dir('env/prod') {
                        sh 'terraform init'
                        sh 'terraform apply -auto-approve'
                    }
                }
            }
        }
    }
}
