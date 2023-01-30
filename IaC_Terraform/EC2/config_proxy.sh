#!usr/bin/bash

 sudo apt update -y
 sudo apt install nginx -y 
 echo -e 'server { \n listen 80 default_server; \n  listen [::]:80 default_server; \n  server_name _; \n  location / { \n  proxy_pass http://${var.private-LB}; \n  } \n}' > default
 sudo mv default /etc/nginx/sites-enabled/default
 sudo systemctl restart nginx
 sudo apt install curl -y