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

module "deployment" {
  source = "../../modules/deployment"

  prefix = "festicket-poc"
}
