output "internal-LB-DNS" {
    value = aws_alb.internal-LB.dns_name
}


output "external-ALB-DNS" {
    value = aws_alb.public-ALB.dns_name
}

output "public-target-group-arn" {
    value = aws_alb_target_group.public-target-group.arn
  
}

output "private-target-group-arn" {
    value = aws_alb_target_group.private-target-group.arn
  
}