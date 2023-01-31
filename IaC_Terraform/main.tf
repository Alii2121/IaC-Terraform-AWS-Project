provider "aws" {
  shared_config_files      = ["~/.aws/config"]
  shared_credentials_files = ["~/.aws/credentials"]
  region                   = var.region
  profile                  = "default"
}



module "vpc-subnets" {
  source = "./VPC-Subnets-RouteTables"

  vpc-cidrs         = var.vpc-cidrs
  public-cidr-subs  = var.public-cidr-subs
  AZ                = var.AZ
  private-cidr-subs = var.private-cidr-subs
  public-traffic    = var.public-traffic
}




module "EC2" {

  source                   = "./EC2"
  vpc-id                   = module.vpc-subnets.vpc-id
  ec2-type                 = var.ec2-type
  
  public-subnet-ids        = module.vpc-subnets.public-subnet-ids
  private-subnet-ids       = module.vpc-subnets.private-subnet-ids
  
  public-sec-id            = module.security-groups.public-sec-id
  private-sec-id           = module.security-groups.private-sec-id
  
  internal-LB-DNS          = module.load-balancers.internal-LB-DNS
  public-target-group-arn  = module.load-balancers.public-target-group-arn
  private-target-group-arn = module.load-balancers.private-target-group-arn
}


module "security-groups" {
  source  = "./Security-Groups"
  traffic = var.public-traffic
  vpc-id  = module.vpc-subnets.vpc-id

}




module "load-balancers" {

  source             = "./Load_balancers"
  traffic            = var.public-traffic
  
  
  vpc-id             = module.vpc-subnets.vpc-id

  public-subnet-ids  = module.vpc-subnets.public-subnet-ids
  private-subnet-ids = module.vpc-subnets.private-subnet-ids
  
  ALB-public-sec-id  = module.security-groups.ALB-public-sec-id
  LB-private-sec-id  = module.security-groups.LB-private-sec-id

  private-EC2-ids    = [module.EC2.private-EC2-ids]
  public-EC2-ids     = [module.EC2.public-EC2-ids]

}