pipeline {
    agent any

    stages {
        stage('GitCheckout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/jayaprakash-kuppusami/hello-python-test.git']]])
            }
        }
        // stage('Sonarscanner_Analysis') {
        //     steps {
        //         script {
        //             def scannerHome = tool 'Sonarqubescanner-4.7.0';
        //             withSonarQubeEnv('sonarqube-8.9.8') {
        //                 sh "${scannerHome}/bin/sonar-scanner \
        //                 -D sonar.login=admin \
        //                 -D sonar.password=Password@123 \
        //                 -D sonar.projectKey=github_clone_project \
        //                 -D sonar.exclusions=vendor/**,resources/**,**/,*.java \
        //                 -D sonar.host.url=http://18.206.57.83:9000"    
        //             }
        //         }
        //     }
        // }
        stage ('Install_Requirements') {
            steps {
                git branch: 'main', url: 'https://github.com/jayaprakash-kuppusami/hello-python-test.git'
                dir('app') {
                    sh """
                        pip3 install -r requirements.txt
                    """
                }
            }
        }
        stage('Build') {
            steps {
                sh """
                    docker build -f dockerfile -t hello-python:latest .
                    docker image ls
                """
            }
        }
        stage('PushImage') {
            //environment = registryCredential = 'dockerhublogin'
            
            steps {
                //script {
                //    docker.withRegistry
                //}
                sh """
                    docker tag hello-python:latest jayaprakashkuppusami/python-app:latest
                    docker login -u jayaprakashkuppusami -p Backspace@7 docker.io
                    docker push jayaprakashkuppusami/python-app:latest
                """
            }
            
        }
        stage('DeployImage') {
          steps {
            script{
              kubernetesDeploy(configs: "Kubeconfig.yaml", kubeconfigId: "kubernetes")
            }
          }
        }
    }
}
