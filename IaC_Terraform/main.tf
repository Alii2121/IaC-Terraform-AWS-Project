provider "aws" {
  shared_config_files      = ["~/.aws/config"]
  shared_credentials_files = ["~/.aws/credentials"]
  region                   = var.region
  profile                  = "default"
}

module "vpc-subnets" {
  source = "./VPC-Subnets-RouteTables"

  vpc-cidrs          = var.vpc-cidrs
  public-cidr-subs   = var.public-cidr-subs
  AZ                 = var.AZ
  private-cidr-subs = var.private-cidr-subs
  public-traffic = var.public-traffic
}

module "EC2" {
    
    source = "./EC2"
    vpc-id = module.vpc-subnets.vpc-id
    ec2-type = var.ec2-type
    public-subnet-ids = module.vpc-subnets.public-subnet-ids
    private-subnet-ids = module.vpc-subnets.private-subnet-ids
    
}