terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  backend "s3" {
    bucket = "festicket-poc-state"
    key    = "environments/web/notlive/terraform.tfstate"
    region = "eu-west-2"
  }
}

provider "aws" {
  region = "eu-west-2"
}

data "terraform_remote_state" "cloud" {
  backend = "s3"

  config = {
    bucket = "festicket-poc-state"
    key    = "clouds/cheese/terraform.tfstate"
    region = "eu-west-2"
  }
}

locals {
  env_name  = "web"
  type_name = "notlive"
  azs       = ["eu-west-2a", "eu-west-2b"]
}

module "public_subnets" {
  source = "../../../../modules/subnets"

  vpc_id     = data.terraform_remote_state.cloud.outputs.cloud.vpc_id
  vpc_cidr   = data.terraform_remote_state.cloud.outputs.cloud.vpc_cidr
  gateway_id = data.terraform_remote_state.cloud.outputs.cloud.gw_id
  name       = format("%s %s public", local.env_name, local.type_name)
  offset     = 2
  azs        = local.azs
}

module "private_subnets" {
  source = "../../../../modules/subnets"

  vpc_id   = data.terraform_remote_state.cloud.outputs.cloud.vpc_id
  vpc_cidr = data.terraform_remote_state.cloud.outputs.cloud.vpc_cidr
  name     = format("%s %s private", local.env_name, local.type_name)
  offset   = 0
  azs      = local.azs
}
