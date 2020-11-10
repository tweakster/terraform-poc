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

data "terraform_remote_state" "cloud" {
  backend = "s3"

  config = {
    bucket = "festicket-poc-state"
    key    = format("clouds/%s/terraform.tfstate", var.cloud_name)
    region = "eu-west-2"
  }
}

locals {
  env_name = "web"
  env_type = var.env_type
  azs      = ["eu-west-2a", "eu-west-2b"]
}

module "public_subnets" {
  # This will be run from .terragrunt-cache/{hash}/{hash} so we need a lot of ../
  source = "../../../../../../../modules/subnets"

  vpc_id     = data.terraform_remote_state.cloud.outputs.cloud.vpc_id
  vpc_cidr   = data.terraform_remote_state.cloud.outputs.cloud.vpc_cidr
  gateway_id = data.terraform_remote_state.cloud.outputs.cloud.gw_id
  name       = format("%s %s public", local.env_name, local.env_type)
  offset     = 2
  azs        = local.azs
}

module "private_subnets" {
  source = "../../../../../../../modules/subnets"

  vpc_id   = data.terraform_remote_state.cloud.outputs.cloud.vpc_id
  vpc_cidr = data.terraform_remote_state.cloud.outputs.cloud.vpc_cidr
  name     = format("%s %s private", local.env_name, local.env_type)
  offset   = 0
  azs      = local.azs
}
