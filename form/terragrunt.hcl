remote_state {
  backend = "s3"
  config = {
    bucket = "festicket-poc-state"
    key    = "${path_relative_to_include()}/terraform.tfstate"
    region = "eu-west-2"
  }
}
