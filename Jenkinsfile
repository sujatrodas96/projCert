pipeline {
    agent none
    
    stages {
        stage('Install Puppet Agent') {
            agent { label 'test-server' }
            steps {
                echo 'Installing Puppet Agent...'
                sh '''
                    wget https://apt.puppet.com/puppet7-release-focal.deb || true
                    sudo dpkg -i puppet7-release-focal.deb || true
                    sudo apt update
                    sudo apt install puppet-agent -y
                    sudo systemctl start puppet
                    sudo systemctl enable puppet
                    /opt/puppetlabs/bin/puppet --version
                '''
            }
        }
        
        stage('Install Docker with Ansible') {
            agent { label 'test-server' }
            steps {
                echo 'Installing Docker using Ansible...'
                sh '''
                    export PATH=$PATH:/usr/bin:/usr/local/bin
                    cd ~/ansible-playbooks
                    ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i hosts.ini install_docker.yml
                '''
            }
        }
        
        stage('Build and Deploy Container') {
            agent { label 'test-server' } 
            steps {
                echo 'Building and deploying Docker container...'
                git branch: 'main', url: 'https://github.com/sujatrodas96/projCert.git'
                sh '''
                    docker stop php-app || true
                    docker rm php-app || true
                    docker rmi php-webapp:latest || true
                    
                    docker build -t php-webapp:latest .
                    docker run -d --name php-app -p 8081:80 php-webapp:latest
                    docker ps | grep php-app
                '''
            }
            post {
                failure {
                    sh '''
                        echo "Deployment failed! Cleaning up..."
                        docker stop php-app || true
                        docker rm php-app || true
                    '''
                }
            }
        }
        
       stage('Deploy to Production') {
            agent { label 'test-server' }
            steps {
                echo 'Deploying to production...'
                sh '''
                    docker tag php-webapp:latest php-webapp:prod
                    echo "Production deployment completed!"
                '''
            }
        }
    }
    
    post {
        success { echo 'Pipeline completed successfully!' }
        failure { echo 'Pipeline failed!' }
    }
}