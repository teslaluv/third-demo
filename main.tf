provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket = "s3-owned-by-teslaluv"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
  }
}

module "vpc-dev" {
  source = "../modules/cluster"
  env                  = var.env
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.pub_subnet_cidr
  private_subnet_cidrs = []
  # private_subnet_cidrs = var.priv_subnet_cidr
}

module "ecr" {
  source = "../modules/ecr"
}

module "init-build" {
  source = "../modules/init-build"
  app_name = module.ecr.app_name
  region = var.region
  reg_id = module.ecr.reg_id
}
