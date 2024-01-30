#!/bin/bash

sudo apt-get update
sudo apt-get install -y docker.io
sudo usermod -aG docker ubuntu
sudo docker run -d --name sonar -p 9000:9000 sonarqube:lts-community