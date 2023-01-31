#!/bin/bash
sudo apt update -y
sudo apt install nginx -y
IP=$(hostname -I)
sudo echo "Hello from Private instance ${IP}" > var/www/html/index.html 
sudo systemctl restart nginx 