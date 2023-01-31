output "public-sec-id" {
    value = aws_security_group.public-sec-group.id
  
}

output "private-sec-id" {
    value = aws_security_group.private-sec-group.id
  
}

output "ALB-public-sec-id" {

    value = aws_security_group.ALB-external-sec-group.id
  
}

output "LB-private-sec-id" {

    value = aws_security_group.private-internal-LB-sec-group.id
  
}