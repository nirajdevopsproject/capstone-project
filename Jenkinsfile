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
        stage('Deploy Dev') {
            steps {
                withCredentials(withAWS(credentialsId: 'aws-terraform-creds', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')])
                dir('env/dev') {
                    sh 'terraform init'
                    sh 'terraform apply -auto-approve'
                }
            }
        }

        stage('Deploy Staging') {
            steps {
                withCredentials([withAWS(credentialsId: 'aws-terraform-creds', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')])
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
               withCredentials([withAWS(credentialsId: 'aws-terraform-creds', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')])
                dir('env/prod') {
                    sh 'terraform init'
                    sh 'terraform apply -auto-approve'
                }
            }
        }
    }
}
