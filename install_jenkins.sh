#!/bin/bash


# Install docker and git
sudo apt update -y &&

sudo apt install apt-transport-https ca-certificates curl software-properties-common -y &&

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg &&

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update -y

sudo apt install docker-ce docker-ce-cli containerd.io -y &&

sudo systemctl start docker && sudo systemctl enable docker &&

sudo usermod -aG docker $USER &&

sudo apt install git -y

# Install Java
sudo apt update
sudo apt install fontconfig openjdk-17-jre -y
java -version

# Install Jenkins
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt update
sudo apt install jenkins -y

sudo usermod -aG docker jenkins

sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins


sudo systemctl restart docker

# Install AWS Cli

sudo apt install unzip curl -y

curl -s "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && unzip awscliv2.zip

sudo apt update
sudo ./aws/install
sudo apt install jq -y

sudo usermod -aG docker jenkins
sudo systemctl restart jenkins