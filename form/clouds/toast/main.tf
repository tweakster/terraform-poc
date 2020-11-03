terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  backend "s3" {
    bucket = "festicket-poc-state"
    key    = "clouds/toast/terraform.tfstate"
    region = "eu-west-2"
  }
}

provider "aws" {
  region = "eu-west-2"
}

module "cloud" {
  source = "../../../modules/cloud"

  vpc_name = "toast"
  vpc_cidr = "172.16.0.0/16"
}
