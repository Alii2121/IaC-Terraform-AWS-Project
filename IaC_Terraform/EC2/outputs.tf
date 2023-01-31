output "public-EC2-1-id" {
    value =  aws_instance.EC2-Public[0].id
           
    
}

output "public-EC2-2-id" {
    value =  aws_instance.EC2-Public[1].id
  
}

output "private-EC2-1-id" {
    value = aws_instance.EC2-Private[0].id
        

    
  
}

output "private-EC2-2-id" {
    value =  aws_instance.EC2-Private[1].id
  
}

output "public-EC2-ids" {
    value = [ aws_instance.EC2-Public[0].id,
            aws_instance.EC2-Public[1].id
    ] 
}

output "private-EC2-ids" {
    value = [ aws_instance.EC2-Private[0].id,
            aws_instance.EC2-Private[1].id
    ] 
}