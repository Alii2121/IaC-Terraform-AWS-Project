resource "aws_vpc" "main-vpc" {
  
    cidr_block = var.vpc-cidrs
    tags = {
      Name = "Main-VPC"
    }

}


resource "aws_subnet" "public-Subnets" {

    vpc_id = aws_vpc.main-vpc.id
    cidr_block = var.public-cidr-subs[count.index]
    count = length(var.public-cidr-subs)
    availability_zone = var.AZ[count.index]   
    map_public_ip_on_launch = true 

    tags = {
      Name = "Public-Subnets-"
    }

}


resource "aws_subnet" "private-Subnets" {

    vpc_id = aws_vpc.main-vpc.id
    cidr_block = var.private-cidr-subs[count.index]
    count = length(var.private-cidr-subs)
    availability_zone = var.AZ[count.index] 
    map_public_ip_on_launch = false
    tags = {
      Name = "Private-Subnet"
    }
}

 


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main-vpc.id
}



resource "aws_eip" "eip" {

  vpc = true
  depends_on = [
    aws_internet_gateway.igw
  ]


}


resource "aws_nat_gateway" "nat" {

    subnet_id =   aws_subnet.public-Subnets[0].id
    allocation_id = aws_eip.eip.id
    
}


resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.main-vpc.id
  route {
    cidr_block = var.public-traffic
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public" {
    count = length(aws_subnet.public-Subnets)
    subnet_id = aws_subnet.public-Subnets[count.index].id
    route_table_id = aws_route_table.public-rt.id
  
}


