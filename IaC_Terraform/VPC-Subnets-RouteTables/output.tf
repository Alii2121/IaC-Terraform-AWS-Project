output "public-subnet-ids" {

    value = [
         aws_subnet.public-Subnets[0].id,
         aws_subnet.public-Subnets[1].id
    ]
} 

output "vpc-id" {
    value = aws_vpc.main-vpc.id 
  
}

output "private-subnet-ids" {

    value = [
        aws_subnet.private-Subnets[0].id,
        aws_subnet.private-Subnets[1].id

    ]
  
}