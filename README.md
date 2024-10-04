# Install Jenkins in a server using Docker

## Install Docker and git

```
sudo apt update

sudo apt install apt-transport-https ca-certificates curl software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update

sudo apt install docker-ce docker-ce-cli containerd.io

sudo systemctl start docker

sudo systemctl enable docker

sudo usermod -aG docker $USER

sudo apt install git

```

## Git clone this repository

```
git clone git@github.com:sky-lester/jenkins-server.git
```

## Run the container:

```
docker build -t myjenkins-blueocean:2.462.3-1 .
```
