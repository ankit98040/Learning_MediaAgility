#! /bin/bash
sudo apt update
sudo apt install openjdk-8-jdk
wget –q –O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add –
sudo apt update
sudo apt install Jenkins
sudo systemctl status jenkins
sudo ufw allow 8080
sudo ufw status
sudo ufw enable