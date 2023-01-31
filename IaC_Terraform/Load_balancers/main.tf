resource "aws_alb" "public-ALB" {
  name            = "external-ALB"
  internal        = false
  security_groups = [var.ALB-public-sec-id]
  subnets         = [var.public-subnet-ids[0],var.public-subnet-ids[1]]
}

resource "aws_security_group_rule" "allow_all_to_alb" {
  security_group_id = var.ALB-public-sec-id

  type        = "ingress"
  from_port   = 0
  to_port     = 65535
  protocol    = "tcp"
  cidr_blocks = [var.traffic]
}


resource "aws_alb_target_group" "public-target-group" {
    
    name = "public-target-group"
    port = 80
    protocol = "HTTP"
    vpc_id = var.vpc-id
    
}




resource "aws_alb_listener" "external-ALB-listener" {
    load_balancer_arn = aws_alb.public-ALB.arn
    port              = "80"
    protocol          = "HTTP"

    default_action {
        target_group_arn = aws_alb_target_group.public-target-group.arn
        type             = "forward"
    }
}




# Private LoadBalancer and it's compnents #

resource "aws_alb_target_group" "private-target-group" {
    
    name = "private-target-group"
    port = 80
    protocol = "HTTP"
    vpc_id = var.vpc-id
    
}




resource "aws_alb" "internal-LB" {
    
    name            = "private-LB"
    internal        = true
    security_groups = [var.LB-private-sec-id]
    subnets = [var.private-subnet-ids[0],var.private-subnet-ids[1]]
    
}

resource "aws_alb_listener" "internal-ALB-listener" {
    load_balancer_arn = aws_alb.internal-LB.arn
    port              = "80"
    protocol          = "HTTP"

    default_action {
        target_group_arn = aws_alb_target_group.private-target-group.arn
        type             = "forward"
    }
}


  

