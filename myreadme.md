# PHP CI/CD Pipeline Project

## Project Overview
Automated CI/CD pipeline using Jenkins, Puppet, Ansible, and Docker to deploy a PHP web application.

## Architecture
- **Jenkins Controller**: Orchestrates the pipeline
- **Test Server**: Jenkins agent node where deployment happens
- **Tools Used**:
  - Puppet: Configuration management
  - Ansible: Docker installation automation
  - Docker: Application containerization
  - Git/GitHub: Source code management

## Pipeline Stages
1. **Install Puppet Agent**: Installs and configures Puppet on test-server
2. **Install Docker with Ansible**: Uses Ansible playbook to install Docker
3. **Build and Deploy Container**: Builds Docker image and runs PHP application
4. **Deploy to Production**: Tags image for production deployment

## Prerequisites
- Jenkins installed with agent node configured
- Ubuntu server for test-server
- SSH access configured between Jenkins and test-server
- GitHub repository with application code

## Setup Instructions

### 1. Configure Jenkins Agent
- Add test-server as Jenkins node with label 'test-server'
- Configure SSH credentials

### 2. Setup Ansible on Test Server
```bash
ssh jenkins@test-server
mkdir -p ~/ansible-playbooks
```

### 3. Configure SSH Keys
```bash
ssh-keygen -t rsa -b 4096 -f ~/.ssh/jenkins_slave -N ""
ssh-copy-id -i ~/.ssh/jenkins_slave jenkins@192.168.0.105
```

### 4. Create Jenkins Pipeline Job
- Create new Pipeline job in Jenkins
- Configure to use SCM (GitHub repository)
- Set script path to Jenkinsfile

## Running the Pipeline
1. Push code to GitHub repository
2. Trigger pipeline manually or via webhook
3. Monitor pipeline execution in Jenkins
4. Access deployed application at http://<server-ip>:8081

## Troubleshooting
- **Docker permission issues**: Ensure jenkins user is in docker group
- **Ansible connection errors**: Verify SSH keys and host_key_checking
- **Container startup failures**: Check Dockerfile CMD and base image compatibility

## Project Files
- `Jenkinsfile`: Pipeline definition
- `Dockerfile`: Container configuration
- `install_docker.yml`: Ansible playbook
- `hosts.ini`: Ansible inventory
- `ansible.cfg`: Ansible configuration
- `index.php`: PHP application

## Author
Sujatro Das

## Date
November 2025