#!usr/bin/bash
sudo chmod +x private-ec2.sh
sudo apt update -y
sudo apt install nginx -y
sudo systemctl start nginx 
IP=$(hostname -I)
sudo cd var/www/html
sudo echo "Hello from Private instance ${IP}" > index.html 
sudo systemctl restart nginx