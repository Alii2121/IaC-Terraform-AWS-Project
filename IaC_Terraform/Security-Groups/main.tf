resource "aws_security_group" "public-sec-group" {
    
    vpc_id      = var.vpc-id

    ingress {
        from_port        = 80
        to_port          = 80
        protocol         = "tcp"
        cidr_blocks      = [var.traffic]
    }

    ingress {
        from_port        = 22
        to_port          = 22
        protocol         = "tcp"
        cidr_blocks      = [var.traffic]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [var.traffic]
    }

    tags = {
        Name = "public-sec-group"
        
    }
}


resource "aws_security_group" "private-sec-group" {
    
    vpc_id      = var.vpc-id


    ingress {
        from_port        = 80
        to_port          = 80
        protocol         = "tcp"
        security_groups = [aws_security_group.private-internal-LB-sec-group.id]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [var.traffic]
    }

    tags = {
        Name = "private-sec-group"
    }
}



resource "aws_security_group" "ALB-external-sec-group" {

    vpc_id = var.vpc-id


    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = [var.traffic]
    }


    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [var.traffic]
    }



    tags = {
        name = "ALB-public-sec-group"
    }
}



resource "aws_security_group" "private-internal-LB-sec-group" {

    vpc_id = var.vpc-id


    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        security_groups = [aws_security_group.public-sec-group.id]
    }


    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [var.traffic]
    }



    tags = {
        name = "private-intrenal-LB-sec-group"
    }
}
