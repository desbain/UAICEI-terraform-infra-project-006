provider "aws" {
  region = "us-east-2"
}

terraform {
  backend "s3" {
    bucket       = "tfstate-remote-backend-006"
    key          = "jupiter/statefile"
    region       = "us-east-2"
    use_lockfile = true
    encrypt      = true

  }
}

#creating vpc module ##############################################
module "vpc" {
  source             = "./vpc"
  vpc_cidr_block     = var.vpc_cidr_block
  tags               = local.project_tags
  public_cidr_block  = var.public_cidr_block
  private_cidr_block = var.private_cidr_block
  db_cidr_block      = var.db_cidr_block
  availability_zone  = var.availability_zone

}

# creating EC2 module ########################################
module "ec2" {
  source        = "./EC2"
  ami_id        = var.ami_id
  tags          = local.project_tags
  vpc_id        = module.vpc.vpc_id
  instance_type = var.instance_type
  subnet_id     = module.vpc.subnet_id
  key_name      = var.key_name

}