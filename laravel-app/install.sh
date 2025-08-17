#!/bin/bash

# Exit on any error
set -e

echo "Starting installation of DevOps tools..."

# Update system packages
echo "--------------------Updating System Packages--------------------"
sudo apt-get update -y
sudo apt-get upgrade -y

# Install Java
echo "--------------------Installing Java--------------------"
sudo apt-get install -y openjdk-17-jdk
echo "Java version:"
java -version

# Install Jenkins 
echo "--------------------Installing Jenkins--------------------"
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update -y
sudo apt-get install -y jenkins
sudo systemctl start jenkins
sudo systemctl enable jenkins
echo "Jenkins version:"
jenkins --version

# Install Git
echo "--------------------Installing Git--------------------"
sudo apt-get install -y git
echo "Git version:"
git --version

# Install Docker
echo "--------------------Installing Docker--------------------"
sudo apt-get update -y
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Add current user to docker group
sudo usermod -aG docker $USER
echo "Docker version:"
docker --version

# Install Ansible
echo "--------------------Installing Ansible--------------------"
sudo apt update -y
sudo apt install -y software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install -y ansible
echo "Ansible version:"
ansible --version

# Install Docker Compose (standalone)
echo "--------------------Installing Docker Compose--------------------" 
sudo curl -L "https://github.com/docker/compose/releases/download/v2.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -sf /usr/local/bin/docker-compose /usr/bin/docker-compose
echo "Docker Compose version:"
docker-compose --version

# Install EksCtl
echo "--------------------Installing EKS-CTL--------------------"
sudo curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
echo "EKS CTL version:"
eksctl version

# Install Kubectl
echo "--------------------Installing Kubectl--------------------"
sudo curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
echo "$(<kubectl.sha256)  kubectl" | sha256sum --check
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
echo "Kubectl version:"
kubectl version --client

# Install Minikube
echo "--------------------Installing Minikube--------------------"
sudo curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
echo "Minikube version:"
minikube version

# Install K9s
echo "--------------------Installing K9s--------------------"
wget https://github.com/derailed/k9s/releases/download/v0.28.1/k9s_Linux_x86_64.tar.gz
sudo tar -xvzf k9s_Linux_x86_64.tar.gz
sudo install -m 755 k9s /usr/local/bin
echo "K9s version:"
k9s version

# Install AWS-CLI
echo "--------------------Installing AWS-CLI--------------------"
sudo apt-get install -y zip
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
echo "AWS CLI version:"
aws --version

# Install Kompose
echo "--------------------Installing Kompose--------------------"
wget https://github.com/kubernetes/kompose/releases/download/v1.32.0/kompose_1.32.0_amd64.deb
sudo apt install -y ./kompose_1.32.0_amd64.deb
echo "Kompose version:"
kompose version

# Set proper permissions for Docker
echo "--------------------Setting Docker Permissions--------------------"
sudo chmod 666 /var/run/docker.sock

# Show Jenkins Password
echo "--------------------Jenkins Password--------------------"
echo "Jenkins initial admin password:"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

echo "--------------------Installation Complete--------------------"
echo "All tools have been installed successfully!"
echo "Please restart your session or run 'newgrp docker' to use Docker without sudo"