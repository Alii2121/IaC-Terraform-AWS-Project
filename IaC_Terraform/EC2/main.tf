
data "aws_ami" "ubuntu" {
    most_recent = true

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }

    owners = ["099720109477"]
}

# Also this method is used to pass a variable inside the script-------


# data "template_file" "script_file" {
#   template = "${file("config_proxy.sh")}"
#   vars = {
#     private-LB = "${var.private-LB}"
#   }
# }

 resource "aws_instance" "EC2-Public" {
     count = 2 
     ami = data.aws_ami.ubuntu.id 
     instance_type = var.ec2-type
     associate_public_ip_address = true
     
     subnet_id = var.public-subnet-ids[count.index]
    
     tags = {
       name = "Public-EC2-${count.index}"
     }
 
   
   
    provisioner "remote-exec" {
        inline = [
            "sudo apt update -y",
            "sudo apt install nginx -y ",
           # "echo 'server { \n listen 80 default_server; \n  listen [::]:80 default_server; \n  server_name _; \n  location / { \n  proxy_pass http://${var.private-LB}; \n  } \n}' > default",
            "sudo mv default /etc/nginx/sites-enabled/default",
            "sudo systemctl restart nginx",
            "sudo apt install curl -y",
        ]

    }

     connection {
     host        = self.public_ip   
     type        = "ssh"
     user        = "ubuntu"
     private_key = "${file("./ali-iti.pem")}"
   }

    provisioner "local-exec" {
        command = "echo Public-ip : ${self.public_ip} >> all-ips.txt"
    }

 }

   # A provisioner method to pass a script into EC2 not user data-----
#       provisioner "file" {
#      source      = "./config_proxy.sh"
#      destination = "/tmp/config_proxy.sh"
#    }
#    provisioner "remote-exec" {
#      inline = [
#        "chmod +x /tmp/config_proxy.sh",
#        "/tmp/config_proxy.sh"
#      ]
#    }
 


 resource "aws_instance" "EC2-Private" {

     count = 2 
     ami = data.aws_ami.ubuntu.id 
     instance_type = var.ec2-type
     associate_public_ip_address = false
     
     #user_data = file("EC2/private-ec2.sh")
     subnet_id = var.private-subnet-ids[count.index]
     tags = {
       name = "Private-EC2-${count.index}"
     }
      

     }