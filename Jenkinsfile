pipeline {
    agent any

    stages {
        stage('check out') {
            steps {
                git branch: 'main', credentialsId: 'git-credential', url: 'https://github.com/adkab99/my-k8s-cicd.git'
            }
        }
        stage('Build & Tag Microservice Docker Image') {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'Dockerhub-credential', toolName: 'Docker', url: 'hub.docker.com') {
                        sh "docker build -t adkab99/jenkins/jenkins"
                       
                   }
                }
            }
        }
       
        stage('Push Microservice Docker Image') {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'Dockerhub-credential', toolName: 'Docker', url: 'hub.docker.com') {
                        sh "docker push adkab99/jenkins/jenkins "
                    }
                }
            }
        }
        // Deploy to The Staging/Test Environment
        stage('Deploy Microservice To The Stage/Test Env'){
            steps{
                script{
                    withKubeConfig(caCertificate: '', clusterName: '', contextName: '', credentialsId: 'k8s-credential', namespace: '', restrictKubeConfigAccess: false, serverUrl: '') {
                       sh 'kubectl apply -f deployment.yml'
                       sh 'kubectl apply -f service.yml'  //ClusterIP Service
                   }
                }
            }
        }
        // Production Deployment Approval
        stage('Approve Prod Deployment') {
            steps {
                    input('Do you want to proceed?')
            }
        }
        // // Deploy to The Production Environment
        stage('Deploy Microservice To The Prod Env'){
            steps{
                script{
                    withKubeConfig(caCertificate: '', clusterName: '', contextName: '', credentialsId: 'k8s-credential', namespace: '', restrictKubeConfigAccess: false, serverUrl: '') {
                       sh 'kubectl apply -f deployment.yml'
                       sh 'kubectl apply -f service.yml'  //ClusterIP Service
                    }
                }
            }
        }
    }
    
}
