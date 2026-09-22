provider "aws" {
    region = "us-east-2"
    
  
}

terraform {
  backend "s3" {
    bucket = "tfstate-remote-backend-006"
    key = "jupiter/statefile"
    region = "us-east-2"
     use_lockfile = true
    encrypt = true
    
  }
}

#creating vpc module ############
module "vpc" {
    source = "./vpc"
    vpc_cidr_block = var.vpc_cidr_block
    tags = local.project_tags
  
}