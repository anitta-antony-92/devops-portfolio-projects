# main.tf
module "vpc" {
  source = "./modules/vpc"
}

module "ec2" {
  source    = "./modules/ec2"
  subnet_id = module.vpc.subnet_a_id  # Pass subnet_a_id to EC2 module
}

module "s3" {
  source = "./modules/s3"
}