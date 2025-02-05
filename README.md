# Install Jenkins in a server

## Using Docker

### Install Docker and git

```
sudo apt update -y &&

sudo apt install apt-transport-https ca-certificates curl software-properties-common -y &&

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg &&

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null &&

sudo apt install docker-ce docker-ce-cli containerd.io -y &&

sudo systemctl start docker &&

sudo systemctl enable docker &&

sudo usermod -aG docker $USER &&

sudo apt install git -y

```

### Create an SSH key

```
ssh-keygen -t ed25519 -C "jenkins@ubuntu-server"
```

### Copy the pub and save it to the deploy keys

```
cat /home/ubuntu/.ssh/id_ed25519.pub
```

### Logout and login

```
logout
```


### Git clone this repository

```
git clone git@github.com:sky-lester/jenkins-server.git
```

### Build the container:

```
docker build -t myjenkins-blueocean:2.462.3-1 .
```

### Create jenkins network

```
docker network create jenkins
```

### Run the container

```
docker run --name jenkins-blueocean --restart=on-failure --detach \
  --network jenkins --env DOCKER_HOST=tcp://docker:2376 \
  --env DOCKER_CERT_PATH=/certs/client --env DOCKER_TLS_VERIFY=1 \
  --publish 8080:8080 --publish 50000:50000 \
  --volume /var/run/docker.sock:/var/run/docker.sock \
  --volume jenkins-data:/var/jenkins_home \
  --volume jenkins-docker-certs:/certs/client:ro \
  myjenkins-blueocean:2.462.3-1
```

### Check jenkins initial admin password

```
docker exec -it jenkins-blueocean cat /var/jenkins_home/secrets/initialAdminPassword
```


Reference: [jenkins on docker](https://www.jenkins.io/doc/book/installing/docker/)


## In Ubuntu Server

### Install Docker and git

```
sudo apt update -y &&

sudo apt install apt-transport-https ca-certificates curl software-properties-common -y &&

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg &&

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

```

```
sudo apt update -y

sudo apt install docker-ce docker-ce-cli containerd.io -y &&

sudo systemctl start docker &&

sudo systemctl enable docker &&

sudo usermod -aG docker $USER &&

sudo apt install git -y

```

### Install JAVA

```
sudo apt update
sudo apt install fontconfig openjdk-17-jre -y
java -version
```

### Install Jenkins

```
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt update
sudo apt install jenkins -y
```


### Add jenkins user to docker group

```
sudo usermod -aG docker jenkins
```


### Start jenkins service

```
sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins
```

### Restart docker

```
sudo systemctl restart docker
```

Reference: [jenkins on linux](https://www.jenkins.io/doc/book/installing/linux/)



## Create an SSH Key inside and copy to Gitlab
```
ssh -i key.pem ubuntu@[IP_ADDRESS]
```
```
sudo su - jenkins
```

```
ssh-keygen -t rsa
```

Copy the id_rsa.pub to Gitlab

Add the id_rsa into jenkins credentials

## Add gitlab to knownhost

```
ssh-keyscan gitlab.com >> ~/.ssh/known_hosts
```
