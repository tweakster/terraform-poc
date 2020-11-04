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
  source = "../../../modules/cloud"

  vpc_name = "cheese"
  vpc_cidr = "172.17.0.0/16"
}
