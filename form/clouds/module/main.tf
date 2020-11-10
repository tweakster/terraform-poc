terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  backend "s3" {}
}

provider "aws" {
  region = "eu-west-2"
}

module "cloud" {
  # This will be run from .terragrunt-cache/{hash}/{hash} so we need a lot of ../
  source = "../../../../../../modules/cloud"

  vpc_name = var.vpc_name
  vpc_cidr = var.vpc_cidr
}
