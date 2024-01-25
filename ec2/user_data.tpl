#!/bin/sh
sudo apt-get update
sudo apt --assume-yes install nginx
sudo apt --assume-yes install git
sudo ufw allow 'Nginx HTTP'
#sudo systemctl start nginx
sudo systemctl enable nginx
sudo systemctl status nginx
sudo git clone https://github.com/omeeomi/tf-cloud-demo-website /tmp/tf-cloud-demo-website
sudo mkdir -p /var/www/html/
sudo cp /tmp/tf-cloud-demo-website/index.html /var/www/html/index.html