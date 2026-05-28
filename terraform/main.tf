terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "starttech-tf-state1"
    key    = "production/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = var.aws_region
}

module "networking" {
  source       = "./modules/networking"
  project_name = var.project_name
  environment  = var.environment
}

module "compute" {
  source                = "./modules/compute"
  project_name          = var.project_name
  environment           = var.environment
  vpc_id                = module.networking.vpc_id
  public_subnet_ids     = module.networking.public_subnet_ids
  ec2_security_group_id = module.networking.ec2_security_group_id
  alb_security_group_id = module.networking.alb_security_group_id
  instance_type         = var.instance_type
  min_size              = var.min_size
  max_size              = var.max_size
  desired_capacity      = var.desired_capacity
  ecr_repository_url    = module.compute.ecr_repository_url
  mongo_uri             = var.mongo_uri
  jwt_secret            = var.jwt_secret
  aws_region            = var.aws_region
}

module "storage" {
  source                  = "./modules/storage"
  project_name            = var.project_name
  environment             = var.environment
  aws_region              = var.aws_region
  vpc_id                  = module.networking.vpc_id
  private_subnet_ids      = module.networking.private_subnet_ids
  redis_security_group_id = module.networking.redis_security_group_id
}

module "monitoring" {
  source           = "./modules/monitoring"
  project_name     = var.project_name
  environment      = var.environment
  asg_name         = module.compute.asg_name
  alb_arn          = module.compute.alb_arn
  target_group_arn = module.compute.target_group_arn
}