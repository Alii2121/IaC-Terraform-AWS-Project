# IaC-Terraform-AWS-Project

## Creating the following infrastructure using Terraform
![photo1674223144](https://user-images.githubusercontent.com/103090890/215821310-42d639e9-ea86-490e-b652-2305672f3886.jpeg)

-------------
## To Deploy this infrastructure on your account
1- clone this repo 

```bash
git clone https://github.com/Alii2121/IaC-Terraform-AWS-Project.git
```
2- Create your own key-pair and use in EC2/main.tf

3- Make sure to pass your credentials correctly in ***main.tf*** file provider block

4- Comment the backend in ***RemoteStateFile.tf*** and change ***S3*** name to a unique one

5- Make sure you Have installed latest version of Terraform and run the following commands inside the project directory 

```bash
terraform init 
terraform apply
```
6- uncomment the backend and apply step 5 again


------------------------

### Bonus
- Added Ansible files to configure EC2 machines using configuration management tool tou use it instead of provisioner in Terraform
- Ansible uses 1 of the EC2 public machines as a bastion host to connect to the private ones
- Installs Nginx on all machines then copy a script and run it on the machines
- Pass any script to the ansible files to cinfigure the machines as you like
- The provided IPS are dynamic not static so make sure to clear the ***all-ips*** file and use the IPS generated on applying terraform 

-----------


### Screenshots of output 

### Enviroment 
![Screenshot from 2023-01-30 14-39-47](https://user-images.githubusercontent.com/103090890/215821664-09c9bfa6-9b91-430e-bb81-228ba532e3cd.png)

----------

### 2 Public EC2s 2 Private EC2s

![Screenshot from 2023-01-31 17-46-10](https://user-images.githubusercontent.com/103090890/215821840-79b77431-5180-42d5-98a8-70e2ac1fbdbb.png)

-----------

### Security Groups

![Screenshot from 2023-01-31 17-46-30](https://user-images.githubusercontent.com/103090890/215821991-e22e8a28-f3ca-4002-9c62-11087b81c726.png)
![Screenshot from 2023-01-31 17-57-20](https://user-images.githubusercontent.com/103090890/215822793-0ad59aa2-8c1c-4d3d-84ae-85ee181d59b3.png)

--------

### Elastic IP

![Screenshot from 2023-01-31 17-46-37](https://user-images.githubusercontent.com/103090890/215822058-bb59704a-1b46-4e52-8d7f-51be0d528ae0.png)

-----------


### Load Balancers (External and Internal facing)


![Screenshot from 2023-01-31 17-46-47](https://user-images.githubusercontent.com/103090890/215822209-f0ddf024-6251-4765-ad9b-cd70257e134b.png)

![Screenshot from 2023-01-31 17-47-00](https://user-images.githubusercontent.com/103090890/215822227-c6f568f1-d83a-4bb2-97b1-d47b9fb2560d.png)

![Screenshot from 2023-01-31 17-47-10](https://user-images.githubusercontent.com/103090890/215822240-1eed4147-4bbc-4498-929a-2471cd8ed6dc.png)

--------

### Target Groups

![Screenshot from 2023-01-31 17-55-07](https://user-images.githubusercontent.com/103090890/215822365-36a06648-dc84-4d83-924a-a2a9173d61a9.png)

![Screenshot from 2023-01-31 17-55-17](https://user-images.githubusercontent.com/103090890/215822388-75edddab-0674-4198-ada9-1efdd43283bb.png)


![Screenshot from 2023-01-31 17-55-25](https://user-images.githubusercontent.com/103090890/215822406-ab9330cd-a0a8-486a-8ef3-b57687b4aa38.png)

-----------

### VPC and Subnets



![Screenshot from 2023-01-31 17-55-54](https://user-images.githubusercontent.com/103090890/215822466-a63699d1-f3f1-43fb-863c-a5d14c8d3549.png)

![Screenshot from 2023-01-31 17-56-07](https://user-images.githubusercontent.com/103090890/215822510-7b0ac47d-0c69-4268-9102-a92978a417d6.png)

-----------

### Route Tables


![Screenshot from 2023-01-31 17-56-21](https://user-images.githubusercontent.com/103090890/215822576-d71e9b81-0f22-448d-98d2-ef2f3f0fe02b.png)


![Screenshot from 2023-01-31 17-56-28](https://user-images.githubusercontent.com/103090890/215822604-bdda5050-18c5-49e4-8ec3-350414fe3ee6.png)


-----------

### Internet gateway & NAT gateway


![Screenshot from 2023-01-31 17-56-42](https://user-images.githubusercontent.com/103090890/215822732-5f6217e4-1624-4c8a-9fe4-bbb9ae8c328e.png)


![Screenshot from 2023-01-31 17-57-06](https://user-images.githubusercontent.com/103090890/215822746-098d1cca-506d-4c96-9f3e-cd485377ee04.png)


------------

### S3 Bucket and DynamoDB used for statelock of terrafrom.tfstate file


![Screenshot from 2023-01-31 17-57-55](https://user-images.githubusercontent.com/103090890/215822969-de8b7712-a6dd-460f-a49b-76b3349307f7.png)

![Screenshot from 2023-01-31 17-58-03](https://user-images.githubusercontent.com/103090890/215822992-bea5002b-f37b-4c59-87df-0783f5a22e93.png)


![Screenshot from 2023-01-31 17-58-10](https://user-images.githubusercontent.com/103090890/215823005-b75c8f52-2aaf-4917-a057-05707662a568.png)

![Screenshot from 2023-01-31 17-58-30](https://user-images.githubusercontent.com/103090890/215823016-a909a0e2-2e0c-4f4e-aff9-c26b15dcbcf8.png)

--------------

### ALB-DNS Output 


![Screenshot from 2023-01-31 18-21-33](https://user-images.githubusercontent.com/103090890/215823092-b07761f0-1556-4166-9df0-ee226dda9017.png)


![Screenshot from 2023-01-31 18-21-42](https://user-images.githubusercontent.com/103090890/215823114-3f6d934f-f9ef-4817-9342-3bc6f005d9cb.png)

-------------

### Proxy Configuration 

```bash
            sudo apt update -y
            sudo apt install nginx -y 
            echo 'server { \n listen 80 default_server; \n  listen [::]:80 default_server; \n  server_name _; \n  location / { \n  proxy_pass http://${var.internal-LB-DNS}; \n  } \n}' > default
            sudo mv default /etc/nginx/sites-enabled/default
            sudo systemctl restart nginx
            sudo apt install curl -y

```

# Thank You !

